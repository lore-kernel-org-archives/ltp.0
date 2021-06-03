From: xuyang2018.jy@fujitsu.com <xuyang2018.jy@fujitsu.com>
Date: Thu, 3 Jun 2021 08:49:14 +0000
Subject: [LTP] [PATCH] syscalls/mallinfo201: Add a basic test for
 mallinfo2 when setting 2G size
In-Reply-To: <YKzX7FPWGGROn6kR@pevik>
References: <1620372638-25690-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <YKzX7FPWGGROn6kR@pevik>
Message-ID: <60B897B1.6050800@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr
Sorry for late reply. I am busy recently.
> Hi Xu,
>
>> Since these members of mallinfo struct use int data type, it will overflow
>> when allocating 2G size. mallinfo() is deprecated and we should use mallinfo2()
>> in the future. So we test mallinfo2 whether works well.
>
>> Signed-off-by: Yang Xu<xuyang2018.jy@fujitsu.com>
>> ---
>>   configure.ac                                  |  1 +
>>   runtest/syscalls                              |  2 +
>>   .../syscalls/mallinfo/mallinfo_common.h       | 18 +++++++
>>   .../kernel/syscalls/mallinfo2/.gitignore      |  1 +
>>   testcases/kernel/syscalls/mallinfo2/Makefile  |  8 ++++
>>   .../kernel/syscalls/mallinfo2/mallinfo201.c   | 47 +++++++++++++++++++
> nit: Maybe rename test: mallinfo201.c =>  mallinfo2_01.c ?
> Now it looks like mallinfo() 201st test.
Agree.

>>   6 files changed, 77 insertions(+)
>>   create mode 100644 testcases/kernel/syscalls/mallinfo2/.gitignore
>>   create mode 100644 testcases/kernel/syscalls/mallinfo2/Makefile
>>   create mode 100644 testcases/kernel/syscalls/mallinfo2/mallinfo201.c
>
> ...
>> diff --git a/testcases/kernel/syscalls/mallinfo/mallinfo_common.h b/testcases/kernel/syscalls/mallinfo/mallinfo_common.h
>> index a00cc7a64..e7737b270 100644
>> --- a/testcases/kernel/syscalls/mallinfo/mallinfo_common.h
>> +++ b/testcases/kernel/syscalls/mallinfo/mallinfo_common.h
>> @@ -28,4 +28,22 @@ static inline void print_mallinfo(const char *msg, struct mallinfo *m)
>>   }
>>   #endif
>
>> +#ifdef HAVE_MALLINFO2
>> +static inline void print_mallinfo2(const char *msg, struct mallinfo2 *m)
>> +{
>> +	tst_res(TINFO, "%s...", msg);
>> +#define P2(f) tst_res(TINFO, "%s: %ld", #f, m->f)
>> +	P2(arena);
>> +	P2(ordblks);
>> +	P2(smblks);
>> +	P2(hblks);
>> +	P2(hblkhd);
>> +	P2(usmblks);
>> +	P2(fsmblks);
>> +	P2(uordblks);
>> +	P2(fordblks);
>> +	P2(keepcost);
>> +}
>> +#endif
>
> BTW did you copy this from glibc? (and previously in 7eb7a97a1)?
Yes.

> Code is similar as that one in malloc/tst-mallinfo2.c in glibc,
> which you modified.
>
> I guess we should also add glibc copyright to mallinfo_common.h
> Copyright (C) 2020 Free Software Foundation, Inc.
> (+ probably keep our)
I will add glibc copyright.
>
> ...
>> diff --git a/testcases/kernel/syscalls/mallinfo2/Makefile b/testcases/kernel/syscalls/mallinfo2/Makefile
>> new file mode 100644
>> index 000000000..044619fb8
>> --- /dev/null
>> +++ b/testcases/kernel/syscalls/mallinfo2/Makefile
>> @@ -0,0 +1,8 @@
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +# Copyright (c) International Business Machines  Corp., 2001
> Here should be your or LTP copyright with 2021.
>
OK.
>> +
>> +top_srcdir		?= ../../../..
>> +
>> +include $(top_srcdir)/include/mk/testcases.mk
> CFLAGS += -I../mallinfo
> (see description below)
>
>> +
>> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> ...
>> --- /dev/null
>> +++ b/testcases/kernel/syscalls/mallinfo2/mallinfo201.c
>> @@ -0,0 +1,47 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (c) 2021 FUJITSU LIMITED. All rights reserved.
>> + * Author: Yang Xu<xuyang2018.jy@fujitsu.com>
>> + */
>> +
>> +/*\
>> + * [DESCRIPTION]
>> + *
>> + * Basic mallinfo2() test. Test the member of struct mallinfo2
>> + * whether overflow when setting 2G size. mallinfo() is deprecated
>> + * since the type used for the fields is too small. We should use
>> + * mallinfo2() and it was added since glibc 2.33.
>> + */
>
> I'd format it a bit and remove info which is not related to the test and people
> can find in man page.
>
> /*\
>   * [DESCRIPTION]
>   *
>   * Basic mallinfo2() test.
>   *
>   * Test members of struct mallinfo2() whether overflow when setting 2G size.
>   */
>
Looks well.
>> +#include "../mallinfo/mallinfo_common.h"
> Please use
> #include "mallinfo_common.h"
>
> and add include path to to Makefile
> CFLAGS += -I../mallinfo
>
OK.
>> +#include "tst_safe_macros.h"
>> +
>> +#ifdef HAVE_MALLINFO2
>> +
>> +void test_mallinfo2(void)
>> +{
>> +	struct mallinfo2 info;
>> +	char *buf;
>> +	size_t size = 2UL * 1024UL * 1024UL * 1024UL;
>> +
>> +	buf = malloc(size);
>> +	if (!buf) {
>> +		tst_res(TCONF, "Current system can not malloc 2G space, skip it");
>> +		return;
>> +	}
> BTW sometimes I wonder if we should have something like SAFE_*() functions which
> would result with TCONF, not with TBROK.
IMO, I don't want to add a flag in SAFE_* functions to control return 
TCONF or TBORK because it is clear enough now. Other maintainers may 
have different option. But Now, I want to keep it.
>
>> +	info = mallinfo2();
>> +	if (info.hblkhd<  size) {
>> +		print_mallinfo2("Test malloc 2G",&info);
>> +		tst_brk(TFAIL, "The member of struct mallinfo2 overflow?");
>> +	}
>> +	tst_res(TPASS, "The member of struct mallinfo2 doesn't overflow");
>> +	free(buf);
>> +}
>> +
>> +static struct tst_test test = {
>> +	.test_all = test_mallinfo2,
>> +};
>> +
>> +#else
>> +TST_TEST_TCONF("system doesn't implement non-POSIX mallinfo2()");
>> +#endif
>
> The rest LGTM.
Thanks for your review. I will send a v2 patch soon.
>
> Kind regards,
> Petr
