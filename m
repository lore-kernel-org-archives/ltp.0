From: Cristian Marussi <cristian.marussi@arm.com>
Date: Fri, 4 Jan 2019 12:28:25 +0000
Subject: [LTP] [PATCH v3]  cgroup_regression_test.sh ported to newlib
In-Reply-To: <20190104122535.GA31329@dell5510>
References: <20181221182516.45689-1-cristian.marussi@arm.com>
 <20190104034555.GA5992@dell5510>
 <9a580965-10d4-80d1-a0c6-23c502289ee7@arm.com>
 <20190104122535.GA31329@dell5510>
Message-ID: <e08cc47d-f5c3-0a09-0420-e815b6246173@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi

On 04/01/2019 12:25, Petr Vorel wrote:
> Hi Cristian,
> 
>>> See diff bellow. I also added 4 commits related to this test,
>>> one of them is fixing regression I added while changing your code
>>> (I'm sorry).
> 
>> Everything's fine but in cgroup_regress_test_6_2.c you reverted to old API,
>> while you previously told me not to:
> 
>>> +++ b/testcases/kernel/controllers/cgroup/cgroup_regress_test_6_2.c
>>> @@ -0,0 +1,37 @@
>> [snip]
> 
>>> +#include <sched.h>
>>> +#include <stdlib.h>
>>> +#include <unistd.h>
>>> +#include "test.h"
>> Please don't use legacy API. <<<<<<
> 
>> is that fine ?
> 
> I'm sorry I forget to tell you I reverted this, it was deliberate change.
> Using TST_NO_DEFAULT_MAIN was wrong (it's usually used in LTP library only.
> Also it's recommended to use SAFE_*() if possible.

Oh..ok..fine I didn't know that.

> 
> I've sent patch to implement this for some C code [1], but it's failing (endless clone).
> 

I saw the patch, I'll try locally later.

> Kind regards,
> Petr

Thanks

Regards

Cristian

> 
> [1] https://patchwork.ozlabs.org/patch/1020712/
> 

