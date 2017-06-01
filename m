From: Jakub =?unknown-8bit?q?Ra=C4=8Dek?= <jracek@redhat.com>
Date: Thu, 1 Jun 2017 13:33:48 +0200
Subject: [LTP] [PATCH] syscalls/memfd_create: test memfd flags separately
In-Reply-To: <20170531105616.GC2276@rei.lan>
References: <1496131199-6979-1-git-send-email-jracek@redhat.com>
 <20170531105616.GC2276@rei.lan>
Message-ID: <4bbf5b72-b23e-6df0-75e1-57e3e83c876c@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

On 05/31/2017 12:56 PM, Cyril Hrubis wrote:
> Hi!
>> This patch fixes the test on some kernels where memfd_create doesn't
>> have  have sealing support. Calls to memfd_create are done so that we
>> know what flags are available. Depending on that, some tests are skipped
>> instead of incorrectly reporting breakage.
>>
>> Signed-off-by: Jakub Racek <jracek@redhat.com>
>> ---
>>  .../kernel/syscalls/memfd_create/memfd_create01.c  | 16 +++++++-
>>  .../kernel/syscalls/memfd_create/memfd_create02.c  | 25 +++++++-----
>>  .../syscalls/memfd_create/memfd_create_common.c    | 44 +++++++++++++++++++---
>>  .../syscalls/memfd_create/memfd_create_common.h    | 12 ++++--
>>  4 files changed, 78 insertions(+), 19 deletions(-)
>>
>> diff --git a/testcases/kernel/syscalls/memfd_create/memfd_create01.c b/testcases/kernel/syscalls/memfd_create/memfd_create01.c
>> index 54c817b..c5e76f2 100644
>> --- a/testcases/kernel/syscalls/memfd_create/memfd_create01.c
>> +++ b/testcases/kernel/syscalls/memfd_create/memfd_create01.c
>> @@ -22,6 +22,7 @@
>>
>>  #define _GNU_SOURCE
>>
>> +#include <errno.h>
>>  #include "tst_test.h"
>>  #include "memfd_create_common.h"
>>
>> @@ -259,7 +260,20 @@ static void verify_memfd_create(unsigned int n)
>>
>>  static void setup(void)
>>  {
>> -	ASSERT_HAVE_MEMFD_CREATE();
>> +
>> +	int available_flags;
>> +
>> +	/*
>> +	 * For now, all tests in this file require MFD_ALLOW_SEALING flag
>> +	 * to be implemented, even though that flag isn't always set when
>> +	 * memfd is created. So don't check anything else and TCONF right away
>> +	 * is this flag is missing.
>> +	 */
>> +	available_flags = GET_MFD_ALL_AVAILABLE_FLAGS();
>> +	if ((available_flags & MFD_ALLOW_SEALING) != MFD_ALLOW_SEALING) {
>> +		tst_brk(TCONF | TTERRNO,
>> +			"memfd_create(%u) not implemented", MFD_ALLOW_SEALING);
>> +	}
>>  }
>>
>>  static struct tst_test test = {
>> diff --git a/testcases/kernel/syscalls/memfd_create/memfd_create02.c b/testcases/kernel/syscalls/memfd_create/memfd_create02.c
>> index d65e496..0e616d7 100644
>> --- a/testcases/kernel/syscalls/memfd_create/memfd_create02.c
>> +++ b/testcases/kernel/syscalls/memfd_create/memfd_create02.c
>> @@ -31,6 +31,8 @@
>>  static char buf[2048];
>>  static char term_buf[2048];
>>
>> +static int available_flags;
>> +
>>  static const struct tcase {
>>  	char *descr;
>>  	char *memfd_name;
>> @@ -62,7 +64,8 @@ static const struct tcase {
>>
>>  static void setup(void)
>>  {
>> -	ASSERT_HAVE_MEMFD_CREATE();
>> +
>> +	available_flags = GET_MFD_ALL_AVAILABLE_FLAGS();
>>
>>  	memset(buf, 0xff, sizeof(buf));
>>
>> @@ -76,14 +79,18 @@ static void verify_memfd_create_errno(unsigned int n)
>>
>>  	tc = &tcases[n];
>>
>> -	TEST(sys_memfd_create(tc->memfd_name, tc->flags));
>> -	if (TEST_ERRNO != tc->memfd_create_exp_err)
>> -		tst_brk(TFAIL, "test '%s'", tc->descr);
>> -	else
>> -		tst_res(TPASS, "test '%s'", tc->descr);
>> -
>> -	if (TEST_RETURN > 0)
>> -		SAFE_CLOSE(TEST_RETURN);
>> +	if ((available_flags & tc->flags) == tc->flags) {
>> +		TEST(sys_memfd_create(tc->memfd_name, tc->flags));
>> +		if (tc->memfd_create_exp_err != TEST_ERRNO)
>> +			tst_brk(TFAIL, "test '%s'", tc->descr);
>> +		else
>> +			tst_res(TPASS, "test '%s'", tc->descr);
>> +
>> +		if (TEST_RETURN > 0)
>> +			SAFE_CLOSE(TEST_RETURN);
>> +	} else
>> +		tst_res(TCONF, "test '%s' skipped, flag not implemented",
>> +			tc->descr);
>
> It would be a bit cleaner to check for the flags first and return from
> the function if flag is not available, i.e.
>
>
> 	if ((available_flags & tc->flags) != tc->flags) {
> 		tst_res(TCONF, ...);
> 		return;
> 	}
>
> 	TEST(sys_memfd_create(...));
> 	...
>
>>  }
>>

Good catch, this actually has to be changed even more than that since 
memfd_create02 tests how api responds to invalid flags.

That and all other suggestions are reflected in V2 I'm sending now.

>>  static struct tst_test test = {
>> diff --git a/testcases/kernel/syscalls/memfd_create/memfd_create_common.c b/testcases/kernel/syscalls/memfd_create/memfd_create_common.c
>> index 4cf3bd5..f87c858 100644
>> --- a/testcases/kernel/syscalls/memfd_create/memfd_create_common.c
>> +++ b/testcases/kernel/syscalls/memfd_create/memfd_create_common.c
>> @@ -103,20 +103,52 @@ void check_ftruncate_fail(const char *filename, const int lineno,
>>  		"ftruncate(%d, %ld) failed as expected", fd, length);
>>  }
>>
>> -void assert_have_memfd_create(const char *filename, const int lineno)
>> +int get_mfd_all_available_flags(const char *filename, const int lineno)
>>  {
>> -	TEST(sys_memfd_create("dummy_call", 0));
>> +	unsigned int i;
>> +	int flag;
>> +	int flags2test[] = {0, MFD_CLOEXEC,  MFD_ALLOW_SEALING};
>> +	int flags_available = 0;
>> +	int any_available = 0;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(flags2test); i++) {
>> +		flag = flags2test[i];
>> +
>> +		TEST(check_mfd_available_with_flags(flag));
>> +		if (TEST_RETURN == MFD_FLAG_NOT_IMPLEMENTED) {
>> +			tst_res_(filename, lineno, TINFO | TTERRNO,
>> +				"memfd_create(%u) not implemented", flag);
>> +		} else if (TEST_RETURN == MFD_FAILED) {
>> +			tst_res_(filename, lineno, TINFO | TTERRNO,
>> +					"memfd_create(%u) failed", flag);
>> +		} else {
>> +			flags_available |= flag;
>> +			any_available = 1;
>> +		}
>> +	}
>> +
>> +	if (!any_available) {
>> +		tst_brk_(filename, lineno, TCONF,
>> +				"memfd_create() not implemented at all");
>> +	}
>
> Hmm, I wonder if there could be a situation where memfd_create() with
> flags = 0 will fail but memfd_creat() with non-zero flags will not. I
> doubt so but as the code is that will create a situaion where tests
> with flags = 0 will fail as well.
>
> So what about checking for flags=0 first, doing tst_brk(TCONF, ...) if
> that is not working, then loop over the MFD_CLOEXEC and
> MFD_ALLOW_SEALING flags?
>
>> +	return flags_available;
>> +}
>> +
>> +int check_mfd_available_with_flags(unsigned int flags)
>> +{
>> +	TEST(sys_memfd_create("dummy_call", flags));
>>  	if (TEST_RETURN < 0) {
>>  		if (TEST_ERRNO == EINVAL) {
>> -			tst_brk_(filename, lineno, TCONF | TTERRNO,
>> -				"memfd_create() not implemented");
>> +			return MFD_FLAG_NOT_IMPLEMENTED;
>>  		}
>>
>> -		tst_brk_(filename, lineno, TBROK | TTERRNO,
>> -			"memfd_create() failed");
>> +		return MFD_FAILED;
>
> I would argue that if the mfd_create() has failed unexpectedly here the
> right thing to do is tst_brk(TBROK | TTERRNO, ...), there is no point in
> continuing the test if the syscall is failing for unknown reason, in
> that case the best course of action is to die quickly with a good
> description of the problem. Which also means that there is no point in
> returning anything else than 0 and 1 in this function, just return 0 if
> flags are not available and 1 if they are.
>
>>  	}
>>
>>  	SAFE_CLOSE(TEST_RETURN);
>> +
>> +	return MFD_AVAILABLE;
>>  }
>>
>>  int check_mfd_new(const char *filename, const int lineno,
>> diff --git a/testcases/kernel/syscalls/memfd_create/memfd_create_common.h b/testcases/kernel/syscalls/memfd_create/memfd_create_common.h
>> index 6329ac3..c90d1f7 100644
>> --- a/testcases/kernel/syscalls/memfd_create/memfd_create_common.h
>> +++ b/testcases/kernel/syscalls/memfd_create/memfd_create_common.h
>> @@ -22,8 +22,12 @@
>>
>>  #define MFD_DEF_SIZE 8192
>>
>> -#define ASSERT_HAVE_MEMFD_CREATE() \
>> -	assert_have_memfd_create(__FILE__, __LINE__)
>> +#define MFD_AVAILABLE            0
>> +#define MFD_FAILED               1
>> +#define MFD_FLAG_NOT_IMPLEMENTED 2
>> +
>> +#define GET_MFD_ALL_AVAILABLE_FLAGS() \
>> +	get_mfd_all_available_flags(__FILE__, __LINE__)
>>
>>  #define CHECK_MFD_NEW(name, sz, flags) \
>>  	check_mfd_new(__FILE__, __LINE__, (name), (sz), (flags))
>> @@ -89,7 +93,9 @@
>>  #define CHECK_MFD_NON_GROWABLE_BY_WRITE(fd) \
>>  	check_mfd_non_growable_by_write(__FILE__, __LINE__, (fd))
>>
>> -void assert_have_memfd_create(const char *filename, const int lineno);
>> +int check_mfd_available_with_flags(unsigned int flags);
>> +int get_mfd_all_available_flags(const char *filename, const int lineno);
>> +
>>  int sys_memfd_create(const char *name, unsigned int flags);
>>
>>  int check_fallocate(const char *filename, const int lineno, int fd,
>> --
>> 1.8.3.1
>>
>>
>> --
>> Mailing list info: https://lists.linux.it/listinfo/ltp
>

Thank you.

-- 
Regards,
     Jakub
