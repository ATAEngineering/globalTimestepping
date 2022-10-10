# Global Timestepping Module
This module was developed by [ATA Engineering](http://www.ata-e.com) as an 
add-on to the Loci/CHEM computational fluid dynamics (CFD) solver. The 
module can be used to enable a non-constant global time step for first order
temporal accuracy. The time step is selected based off of a user specified CFL 
ramp. This time integration scheme is helpful for steady state flow simulations 
that have initial stability problems that disappear as the solution evolves.

# Dependencies
This module depends on both Loci and CHEM being installed. Loci is an open
source framework developed at Mississippi State University (MSU) by Dr. Ed 
Luke. The framework provides a rule-based programming model and can take 
advantage of massively parallel high performance computing systems. CHEM is 
a full featured open source CFD code with finite-rate chemistry built on 
the Loci framework. CHEM is export controlled under the International 
Traffic In Arms Regulations (ITAR). Both Loci and CHEM can be obtained from 
the [SimSys Software Forum](http://www.simcenter.msstate.edu) hosted by 
MSU. This module also requires a compiler with C++11 support.

# Installation Instructions
First Loci and CHEM should be installed. The **LOCI_BASE** environment
variable should be set to point to the Loci installation directory. The 
**CHEM_BASE** environment variable should be set to point to the CHEM 
installation directory. The installation process follows the standard 
make, make install procedure.

```bash
make
make install
```

# Usage
First the module must be loaded at the top of the **vars** file. 
The **global_cfl** options list can be used to specify the parameters of the 
CFL ramp. The **time_integration** method should be set to **euler**, the 
**urelax** parameter should be set to 1, and the **cflmax** parameter should not
be used.

```
loadModule: globalTimeStepping

time_integration: euler
urelax: 1.0
global_cfl: <start=0.001, exponent=1.5, coefficient=1e-4, max=100>
```

The CFL ramp is calculated based on the iteration, $n$, as shown below where 
$A$ is the specified coefficient, $B$ the specified exponent, $C$ the specifed
starting value, and $D$ the specified maximum CFL.

$$ CFL = min \left( D, A n^B + C \right) $$
