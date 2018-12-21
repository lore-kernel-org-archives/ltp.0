From: Cristian Marussi <cristian.marussi@arm.com>
Date: Fri, 21 Dec 2018 18:23:44 +0000
Subject: [LTP] [PATCH v2 4/4]  cgroup: helpers various fixes
In-Reply-To: <20181221140118.GA22257@dell5510>
References: <20181220182149.48326-1-cristian.marussi@arm.com>
 <20181220182149.48326-5-cristian.marussi@arm.com>
 <20181221140118.GA22257@dell5510>
Message-ID: <7c20bbf9-278b-82d0-75a0-51047443b90d@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi

On 21/12/2018 14:01, Petr Vorel wrote:
> Hi Cristian,
> 
>> diff --git a/testcases/kernel/controllers/cgroup/cgroup_regress_test_6_2.c b/testcases/kernel/controllers/cgroup/cgroup_regress_test_6_2.c
>> new file mode 100644
> When you add new file, you need to put it also into .gitignore.
> + Remove /test_6_2 from it (original file).
> 
> ...
>> +++ b/testcases/kernel/controllers/cgroup/cgroup_regress_test_6_2.c
>> @@ -0,0 +1,37 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (c) 2009 FUJITSU LIMITED
>> + *
>> + * Author: Li Zefan <lizf@cn.fujitsu.com>
>> + */
>> +
>> +#define _GNU_SOURCE
> Is _GNU_SOURCE really needed?
> 

Yes..needed to compile the CLONE_NEWNS flag passed down the newlib function
ltp_clone_quick()

>> +#include <sched.h>
>> +#include <stdlib.h>
>> +#include <unistd.h>
>> +#include "test.h"
> Please don't use legacy API.

Done.
> 
>> +
>> +#define DEFAULT_USEC	30000
>> +
>> +int foo(void __attribute__ ((unused)) * arg)
>> +{
>> +	return 0;
>> +}
>> +
>> +int main(int argc, char **argv)
>> +{
>> +	int usec;
>> +
>> +	if (argc == 2)
>> +		usec = atoi(argv[1]);
>> +	else
>> +		usec = DEFAULT_USEC;
>> +
>> +	while (1) {
>> +		usleep(usec);
>> +		ltp_clone_quick(CLONE_NEWNS, foo, NULL);
>> +	}
>> +
>> +	tst_exit();
>> +}
> 
> ...
> 
>> +++ b/testcases/kernel/controllers/cgroup/getdelays.c
>> @@ -1,3 +1,4 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>  /* getdelays.c
> 
> There is build warning, can you please fix it:
> 
> getdelays.c: In function ‘get_family_id’:
> getdelays.c:177:14: warning: variable ‘rc’ set but not used [-Wunused-but-set-variable]
>   int id = 0, rc;
>               ^~
> getdelays.c: In function ‘main’:
> getdelays.c:418:7: warning: variable ‘i’ set but not used [-Wunused-but-set-variable]
>    int i;
>        ^
> 
Done.

Regards

Cristian

> Kind regards,
> Petr
> 

