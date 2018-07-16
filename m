From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 16 Jul 2018 11:07:29 -0400 (EDT)
Subject: [LTP] [PATCH] Rename TEST_ERRNO and TEST_RETURN for new test lib
In-Reply-To: <20180716135617.7782-1-clanig@suse.com>
References: <20180716135617.7782-1-clanig@suse.com>
Message-ID: <1814001310.33298567.1531753649985.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it




----- Original Message -----
> This is just a proposal! to renaming the mentioned variables as requested in
> https://github.com/linux-test-project/ltp/issues/336.
> 
> Renaming has been done with these commands:
> egrep -RlZ 'include "tst_test.h"' --include=*.c --include=*.h | xargs -0 -l
> sed
> 	-i -e '/[\W\s]*TEST_ERRNO[\W\s]*/s/TEST_ERRNO/TST_ERR/g'
> 
> egrep -RlZ 'include "tst_test.h"' --include=*.c --include=*.h | xargs -0 -l
> sed
> 	-i -e '/[\W\s]*TEST_RETURN[\W\s]*/s/TEST_RETURN/TST_RET/g'
> 
> They basically express to exchange all occurrences of TEST_RETURN with
> TST_RET

Hi,

I added question to github issue, whether TEST() macro should be renamed.

> (as an example), in all files with .c or .h as suffix that include
> tst_test.h,
> when the processed line contains TEST_RETURN without pre- or suffixes that
> match
> word characters (Aa-Zz) including _, but non-word characters(+, [, ...)
> including whitespace.
> 
> I have added a temporary preprocessor directive to include/tst_test.h that
> renames both variables again to their old names because otherwise they are
> con-
> flicting with the old variables and have cleaned some non-tab signs that gave
> style errors in few lines.

I lost you here - I don't see conflict between new and old variables.

> 
> Signed-off-by: Christian Lanig <clanig@suse.com>
> ---
> 
> diff --git a/include/tst_test.h b/include/tst_test.h
> index 7caf2e174..56f0e3f54 100644
> --- a/include/tst_test.h
> +++ b/include/tst_test.h
> @@ -195,6 +195,13 @@ void tst_reinit(void);
>  extern long TEST_RETURN;
>  extern int TEST_ERRNO;

So what if we changed this to new variables (TST_RET and TST_ERR),
add definitions to lib/tst_test.c

>  
> +/*
> + * This is a temporary workaround. Remove this and rename the variables in
> the
> + * definition above after everything has been migrated to the new test
> library.
> + */
> +#define TST_RET TEST_RETURN
> +#define TST_ERR TEST_ERRNO
> +

then this can go away and because TEST_RETURN and TEST_ERRNO
will be undefined in newlib tests, you'll get compilation
errors for all instances you missed:

futex_wait05
pselect01
open08
mq_timedsend01
clock_nanosleep02
poll02
madvise10
epoll_wait02
memfd_create02
mq_timedreceive01
testcases/kernel/mem/lib/mem.c
testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c
testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
testcases/kernel/mem/hugetlb/hugemmap/hugemmap06.c

>  extern void *TST_RET_PTR;
>  
>  #define TESTPTR(SCALL) \

TESTPTR needs changing as well, to use TST_ERR.

Regards,
Jan
