%% PCLSO matlab code
function [gbestx,gbestfitness,gbesthistory]=PCLSO(~,popsize,dimension,xmax,xmin,~,~,maxiter,Func,FuncId,~)
c3 = 0.1;
popsize = 200;
l = (1:popsize) / popsize;
rand('seed', sum(100 * clock));

for i = 1:popsize
    p(i,:)=xmin+(xmax-xmin).*rand(1,dimension);
    fitness(i,:) = Func(p(i,:)', FuncId); 
end
v = zeros(popsize,dimension);
gbestfitness = Inf;
pbestx = p;
pbestfitness = fitness;
FEs = popsize;
MaxFEs = 3e6;
Stag = 0;

gbesthistory(1:FEs) = min(fitness);

while(FEs < MaxFEs)
    [fitness rank] = sort(fitness);
    p = p(rank,:);
    v = v(rank,:);
    pbestx = pbestx(rank,:);
    pbestfitness = pbestfitness(rank);
    pastgbestfitness = gbestfitness;
    winidxmask = repmat([1:popsize]', [1 dimension]); % m行，d列
    winidx = popsize-(winidxmask + ceil(rand(popsize, dimension).*(popsize - winidxmask)))+1;
    winidx = flipud(winidx);
    pwin = p;
    for j = 1:dimension
        pwin(:,j) = p(winidx(:,j),j);
    end
     
    for i = 2:popsize
        if (rand < l(i))
            elite = randi(i-1);
            weight =  (elite:-1:1)./sum(1:elite); % 权重根据排名计算
            center(i,:) = weight*pbestx(1:elite,:);
            v(i,:) = rand(1,dimension).*v(i,:)+rand(1,dimension).*(pwin(i,:)-p(i,:))+c3*rand(1,dimension).*(center(i,:)-p(i,:));
            p(i,:) = p(i,:) + v(i,:);

            index1 = (p(i,:)>xmax)|(p(i,:)<xmin); % 边界控制
            p(i,index1) = pbestx(i,index1);
            fitness(i,:) = Func(p(i,:)', FuncId);
            FEs = FEs + 1;

            if fitness(i) < pbestfitness(i)
                pbestfitness(i) = fitness(i);
                pbestx(i,:) = p(i,:);
            end
            if fitness(i,:) < gbestfitness
                gbestx = p(i,:);
                gbestfitness = fitness(i,:);
            end

            if ((pastgbestfitness-gbestfitness) < pastgbestfitness/1000)
                Stag = Stag+1;
            else 
                Stag = 0;
            end
            gbesthistory(FEs) = gbestfitness;
            if mod(FEs, MaxFEs/10) == 0 && FEs <= MaxFEs
                fprintf("PCLSO 第%d次评价，最佳适应度 = %e\n",FEs,gbestfitness);
            end            
        end
    end

    if Stag >= 10000 
        [~,i] = min(fitness); % 针对全局最优
        for k=1:popsize
            Pj=normrnd(ones(1,dimension)*0.01,ones(1,dimension)*0.01);
            bottleneck=rand(1,dimension)<Pj;
            F=normrnd(0.5,0.1);
            r=[];
            r=selectID(popsize,i,2);
            r1=r(1);
            r2=r(2);
            for j = 1:dimension
                if rand < 0.01
                    prand = xmin+(xmax-xmin)*rand;
                    newp(i,j) = gbestx(j)+F*(p(r1,j)-prand);
                else
                    newp(i,j) = gbestx(j)+F*(p(r1,j)-p(r2,j));
                end
            end
            index1 = (newp(i,:)>xmax)|(newp(i,:)<xmin); % 边界控制
            newp(i,index1) = gbestx(index1);
            
            newgbestX=gbestx;
            newgbestX(bottleneck) = newp(i,bottleneck);
            newgbestfitness = Func(newgbestX',FuncId);
            FEs = FEs +1;
            if newgbestfitness<=gbestfitness
                gbestfitness = newgbestfitness;
                gbestx = newgbestX;
                p(i,:) = gbestx;
                pbestx(i,:)=p(i,:);
                pbestfitness(i)=fitness(i);
            end
            gbesthistory(FEs)=gbestfitness;
            fprintf("PCLSO 第%d次评价，最佳适应度 = %e\n",FEs,gbestfitness);
        end
        Stag = 0;
    end
    if FEs < MaxFEs
        gbesthistory(FEs+1:MaxFEs) = gbestfitness;
    else
        if FEs > MaxFEs
            gbesthistory(MaxFEs+1:end)=[];
        end
    end
end
end

function [r]=selectID(popsize,i,count)
if count<= popsize
    vec=[1:i-1,i+1:popsize];
    r=zeros(1,count);
    
    for j =1:count
        n = popsize-j;
        t = randi(n,1,1);
        r(j) = vec(t); 
        vec(t)=[]; 
    end
end
end
