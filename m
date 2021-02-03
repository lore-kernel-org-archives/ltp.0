From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 3 Feb 2021 14:03:06 +0800
Subject: [LTP] [PATCH v1 1/3] syscalls/mallinfo01: Add a basic test for
 mallinfo
In-Reply-To: <YBLdKsBkrLuyvbjA@yuki.lan>
References: <1611654925-8994-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <YBLdKsBkrLuyvbjA@yuki.lan>
Message-ID: <601A3C9A.904@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril
Sorry for late reply, I am busy with other thing.
>> diff --git a/testcases/kernel/syscalls/mallinfo/mallinfo01.c b/testcases/kernel/syscalls/mallinfo/mallinfo01.c
>> new file mode 100644
>> index 000000000..1a2a30af1
>> --- /dev/null
>> +++ b/testcases/kernel/syscalls/mallinfo/mallinfo01.c
>> @@ -0,0 +1,84 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (c) 2021 FUJITSU LIMITED. All rights reserved.
>> + * Author: Yang Xu<xuyang2018.jy@cn.fujitsu.com>
>> + */
>> +
>> +/*\
>> + * [DESCRIPTION]
>> + *
>> + * Basic mallinfo() test. Refer to glibc test
>> + * https://sourceware.org/git/?p=glibc.git;a=blob;f=malloc/tst-mallinfo2.c
>> +\*/
>> +
>> +#include<malloc.h>
>> +
>> +#include "tst_test.h"
>> +#include "tst_safe_macros.h"
>> +
>> +#ifdef HAVE_MALLINFO
>> +static char *buf;
>> +static struct mallinfo info1;
>> +
>> +static void
>> +print_mallinfo(const char *msg, struct mallinfo *m)
>> +{
>> +	tst_res(TINFO, "%s...", msg);
>> +#define P(f) tst_res(TINFO, "%s: %d", #f, m->f)
>> +	P(arena);
>> +	P(ordblks);
>> +	P(smblks);
>> +	P(hblks);
>> +	P(hblkhd);
>> +	P(usmblks);
>> +	P(fsmblks);
>> +	P(uordblks);
>> +	P(fordblks);
>> +	P(keepcost);
>> +}
>> +
>> +void test_mallinfo(void)
>> +{
>> +	struct mallinfo info2;
>> +	int i;
>> +	int total = 0;
>> +
>> +	for (i = 1; i<  20; i++) {
>> +		buf = SAFE_MALLOC(160 * i);
>
> The buf here has to be array and we have to free the buffers at the end
> of this function, otherwise the malloc() will fail sooner or later when
> the test_mallinfo() function runs in a loop.
Yes. Will do it in v2.
>
>> +		total += 16 * i;
It looks glibc test uses wrong multiple for total variable, I will 
correct it (16=>160). Also, I have sent a patch to glibc.
>> +	}
>> +
>> +	info2 = mallinfo();
>> +	print_mallinfo("Test",&info2);
>> +	if (info2.uordblks>  info1.uordblks + total)
>> +		tst_res(TPASS, "mallinfo() passed");
>> +	else
>> +		tst_res(TFAIL, "mallinfo() failed");
>> +
>> +	info1 = info2;
>
> And then we cannot do this either.
Yes, Will do it in v2.
>
>> +}
>> +
>> +static void setup(void)
>> +{
>> +	if (sizeof(info1.arena) != sizeof(int))
>> +		tst_res(TFAIL, "The member of mallinfo struct is not int");
>> +
>> +	info1 = mallinfo();
>> +	print_mallinfo("Start",&info1);
>> +}
>> +
>> +static void cleanup(void)
>> +{
>> +	if (buf)
>> +		free(buf);
>> +}
>> +
>> +static struct tst_test test = {
>> +	.setup = setup,
>> +	.test_all = test_mallinfo,
>> +	.cleanup = cleanup,
>> +};
>> +
>> +#else
>> +TST_TEST_TCONF("system doesn't implement non-POSIX mallinfo()");
>> +#endif
>> --
>> 2.23.0
>>
>>
>>
>>
>> --
>> Mailing list info: https://lists.linux.it/listinfo/ltp
>



