# PCLPSO
The source code of PCLPSO algorithm

**Author**： Xiaoyu Liu ， Qingke Zhang*（Corresponding Author）， Jiajun Sun， Huaxiang Zhang

**Aff.**: 
1) School of Information Science and Engineering, Shandong Normal University, Jinan, 250358, China 
2) School of Science and Engineering, The Chinese University of Hong Kong （Shenzhen）， Shenzhen, 518172, China

### Abstract
Social Learning Particle Swarm Optimization （SLPSO） is an advanced variant of the PSo algorithm, designed to enhance optimization performance in Large-Scale Global
Optimization （LSGO） problems. However, SLPSO encounters significant challenges, particularly in maintaining a balanced trade-off between exploration and exploitation, which
limits its effectiveness in complex optimization tasks. In response to these limitations, this paper proposes the Pulse-based Collective Learning Swarm Optimizer （PCLSO）. The
PCLSO introduces two key innovations: collective learning, which replaces the traditional average position updates in SLPSO, thereby enhancing exploration by leveraging
knowledge from multiple high-quality particles; and a pulse-strategy, which addresses convergence stagnation by dynamically perturbing the global best solution to improve
exploitation capabilities. Extensive experimental evaluations on the CEC’2010 and CEC’2013 benchmark suites demonstrate that PCLSO significantly outperforms SLPSO, as well
as several advanced and classical PSO and DE variants, and the latest cooperative coevolutionary （CC）-based algorithms. Furthermore, to validate its practical applicability, PCLSo
is applied to the biological Multiple Sequence Alignment （MSA） problem using Hidden Markov Models （HMM）， where it exhibits superior performance compared to other state-of-
the-art metaheuristic algorithms. In summary, the study presents a robust optimization tool that advances the field of LSGO and shows promise for addressing complex real-world
optimization challenges. The source code of the PCLSO algorithm is publicly available at https://github.com/tsingke/PCLPSO.
