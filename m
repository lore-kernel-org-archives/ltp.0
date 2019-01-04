From: Cristian Marussi <cristian.marussi@arm.com>
Date: Fri, 4 Jan 2019 10:21:13 +0000
Subject: [LTP] [PATCH v3]  cgroup_regression_test.sh ported to newlib
In-Reply-To: <20190104034555.GA5992@dell5510>
References: <20181221182516.45689-1-cristian.marussi@arm.com>
 <20190104034555.GA5992@dell5510>
Message-ID: <9a580965-10d4-80d1-a0c6-23c502289ee7@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr

On 04/01/2019 03:45, Petr Vorel wrote:
> Hi Cristian,
> 
>> Ported to newlib and cleaned up.
> 
>>  - removed absolute/relative commands invocations
>>  - avoid bashism
>>   + removed bash shebang
>>   + giving up 'kill' bash-builtin: this needs redefining
>>     used sigspec strings
>>  - A common function 'get_cgroup_mountpoint' is added to help
>>    parse /proc/mounts in search of specific cgroup subsystems
>>    mountpoints. It is added as part of a common cgroup_lib.sh.
>>  - converted Copyright headers to SPDX
>>  - renamed each helper to include a tag prefix (cgroup_regress_)
>>    in order to avoid possible name clashes once installed all together
>>    into testcases/bin
> 
>> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> 
> Thanks for your patch, merged with several code style changes:
>  - unify file names (cgroup_regress_* => cgroup_regression_)
>  - rename also getdelays.c and fork_processes.c
>  - redirect wait's stderr to /dev/null to keep it quiet
>  - remove mandatory commands from TST_NEEDS_CMDS
>  - move tst_test.sh loading into library
>  - cleanup get_cgroup_mountpoint()
>  - minor code style fixes
> 
Thanks for your review and further fixes.

> See diff bellow. I also added 4 commits related to this test,
> one of them is fixing regression I added while changing your code
> (I'm sorry).

Everything's fine but in cgroup_regress_test_6_2.c you reverted to old API,
while you previously told me not to:

> +++ b/testcases/kernel/controllers/cgroup/cgroup_regress_test_6_2.c
> @@ -0,0 +1,37 @@
[snip]

> +#include <sched.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include "test.h"
Please don't use legacy API. <<<<<<

is that fine ?

Thanks

Regards

Cristian
