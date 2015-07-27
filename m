Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <liwan@redhat.com>) id 1ZJbMx-00087d-0F
	for ltp-list@lists.sourceforge.net; Mon, 27 Jul 2015 05:54:35 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZJbMv-00089H-Bq
	for ltp-list@lists.sourceforge.net; Mon, 27 Jul 2015 05:54:34 +0000
Date: Mon, 27 Jul 2015 01:54:26 -0400 (EDT)
From: Li Wang <liwang@redhat.com>
Message-ID: <2055436226.240732.1437976466421.JavaMail.zimbra@redhat.com>
In-Reply-To: <1216267366.178924.1437911143948.JavaMail.zimbra@redhat.com>
References: <1437722520-2794-1-git-send-email-liwang@redhat.com>
	<1216267366.178924.1437911143948.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] syscalls/sysfs: replace the TWARN to TCONF
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi Jan,

----- Original Message -----
> 
> 
> 
> 
> ----- Original Message -----
> > From: "Li Wang" <liwang@redhat.com>
> > To: ltp-list@lists.sourceforge.net
> > Sent: Friday, 24 July, 2015 9:22:00 AM
> > Subject: [LTP] [PATCH] syscalls/sysfs: replace the TWARN to TCONF
> > 
> > I run some of these cases on aarch64 today and get a series waring, that's
> > because
> > sysfs syscall is not implemented on aarch64. So, maybe TCONF is better than
> > TWARN
> > in the testcase.
> 
> Are you sure it's not supported? Or is it just disabled in your kernel
> config?
> I'm looking at Kconfig and nothing suggests you can't use it on aarch64:

Hmm, to be precise, it has supported sysfs_syscall but not define '__NR_sysfs' on aarch64.

My system config:
# grep -i sysfs_syscall /boot/config-4.1.0-0.12.el7.aarch64 
CONFIG_SYSFS_SYSCALL=y
# grep -i EXPERT /boot/config-4.1.0-0.12.el7.aarch64 
CONFIG_EXPERT is not set

(1)---->
If I change the code as:

diff --git a/testcases/kernel/syscalls/sysfs/sysfs01.c b/testcases/kernel/syscalls/sysfs/sysfs01.c
index 11ebe43..770c9c9 100644
--- a/testcases/kernel/syscalls/sysfs/sysfs01.c
+++ b/testcases/kernel/syscalls/sysfs/sysfs01.c
@@ -67,6 +67,7 @@
  ******************************************************************************/
 
 #include "test.h"
+#include "linux_syscall_numbers.h"
 #include <errno.h>
 #include <unistd.h>
 #include <syscall.h>
@@ -85,14 +86,12 @@ int main(int ac, char **av)
 
        setup();
 
-#ifdef __NR_sysfs
-
        for (lc = 0; TEST_LOOPING(lc); lc++) {
 
                tst_count = 0;
 
                /* option 1, buf holds fs name */
-               TEST(syscall(__NR_sysfs, 1, "proc"));
+               TEST(ltp_syscall(__NR_sysfs, 1, "proc"));
 
                /* check return code */
                if (TEST_RETURN == -1) {
@@ -102,10 +101,6 @@ int main(int ac, char **av)
                        tst_resm(TPASS, "sysfs(2) Passed for " "option 1");
                }
        }                       /*End of TEST_LOOPING */
-#else
-       tst_resm(TWARN,
-                "This test can only run on kernels that support the sysfs system call");
-#endif
 
        /*Clean up and exit */
        cleanup();


It's show:

# ./sysfs01 
sysfs01     1  TCONF  :  sysfs01.c:94: syscall __NR_sysfs not supported on your arch
sysfs01     2  TCONF  :  sysfs01.c:94: Remaining cases not appropriate for configuration



(2)---->
then I add the macro to "linux_syscall_numbers.h" by manual:

# grep -e __aarch64 -e __NR_sysfs  linux_syscall_numbers.h -A 2 -B 2

#ifdef __aarch64__
...
# ifndef __NR_sysfs
#  define __NR_sysfs 135
# endif


It's failed as:

# ./sysfs01 
sysfs01     1  TFAIL  :  sysfs01.c:99: sysfs(2) Failed for option 1 and set errno to 22


> 
> config SYSFS_SYSCALL
>         bool "Sysfs syscall support" if EXPERT
>         default y
>         ---help---
>           sys_sysfs is an obsolete system call no longer supported in libc.
>           Note that disabling this option is more secure but might break
>           compatibility with some systems.
> 
>           If unsure say Y here.
> 
> We have "linux_syscall_numbers.h", if you include that and use
> ltp_syscall() instead of syscall() you can remove the #ifdef,
> as it should TCONF at runtime (in case kernel gives you ENOSYS)

Yes, It's a better way. But I'm still not sure if it is good enough to format 
a patchV2, like (1) or (1)+(2)?   or any others? 

Thanks!

Best,
Li Wang

> 
> Regards,
> Jan
> 
> > 
> > Signed-off-by: Li Wang <liwang@redhat.com>
> > ---
> >  testcases/kernel/syscalls/sysfs/sysfs01.c | 2 +-
> >  testcases/kernel/syscalls/sysfs/sysfs02.c | 2 +-
> >  testcases/kernel/syscalls/sysfs/sysfs03.c | 2 +-
> >  testcases/kernel/syscalls/sysfs/sysfs04.c | 2 +-
> >  testcases/kernel/syscalls/sysfs/sysfs05.c | 2 +-
> >  testcases/kernel/syscalls/sysfs/sysfs06.c | 2 +-
> >  6 files changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/testcases/kernel/syscalls/sysfs/sysfs01.c
> > b/testcases/kernel/syscalls/sysfs/sysfs01.c
> > index 11ebe43..c29f6c0 100644
> > --- a/testcases/kernel/syscalls/sysfs/sysfs01.c
> > +++ b/testcases/kernel/syscalls/sysfs/sysfs01.c
> > @@ -103,7 +103,7 @@ int main(int ac, char **av)
> >  		}
> >  	}			/*End of TEST_LOOPING */
> >  #else
> > -	tst_resm(TWARN,
> > +	tst_resm(TCONF,
> >  		 "This test can only run on kernels that support the sysfs system
> >  		 call");
> >  #endif
> >  
> > diff --git a/testcases/kernel/syscalls/sysfs/sysfs02.c
> > b/testcases/kernel/syscalls/sysfs/sysfs02.c
> > index f7cb96a..54557cc 100644
> > --- a/testcases/kernel/syscalls/sysfs/sysfs02.c
> > +++ b/testcases/kernel/syscalls/sysfs/sysfs02.c
> > @@ -103,7 +103,7 @@ int main(int ac, char **av)
> >  		}
> >  	}			/*End of TEST_LOOPING */
> >  #else
> > -	tst_resm(TWARN,
> > +	tst_resm(TCONF,
> >  		 "This test can only run on kernels that support the sysfs system
> >  		 call");
> >  #endif
> >  
> > diff --git a/testcases/kernel/syscalls/sysfs/sysfs03.c
> > b/testcases/kernel/syscalls/sysfs/sysfs03.c
> > index 59b997e..9048dfe 100644
> > --- a/testcases/kernel/syscalls/sysfs/sysfs03.c
> > +++ b/testcases/kernel/syscalls/sysfs/sysfs03.c
> > @@ -101,7 +101,7 @@ int main(int ac, char **av)
> >  		}
> >  	}			/*End of TEST_LOOPING */
> >  #else
> > -	tst_resm(TWARN,
> > +	tst_resm(TCONF,
> >  		 "This test can only run on kernels that support the sysfs system
> >  		 call");
> >  #endif
> >  
> > diff --git a/testcases/kernel/syscalls/sysfs/sysfs04.c
> > b/testcases/kernel/syscalls/sysfs/sysfs04.c
> > index f4fda36..2b2530a 100644
> > --- a/testcases/kernel/syscalls/sysfs/sysfs04.c
> > +++ b/testcases/kernel/syscalls/sysfs/sysfs04.c
> > @@ -105,7 +105,7 @@ int main(int ac, char **av)
> >  		}
> >  	}
> >  #else
> > -	tst_resm(TWARN,
> > +	tst_resm(TCONF,
> >  		 "This test can only run on kernels that support the sysfs system
> >  		 call");
> >  #endif
> >  
> > diff --git a/testcases/kernel/syscalls/sysfs/sysfs05.c
> > b/testcases/kernel/syscalls/sysfs/sysfs05.c
> > index e97f0c8..2ab6707 100644
> > --- a/testcases/kernel/syscalls/sysfs/sysfs05.c
> > +++ b/testcases/kernel/syscalls/sysfs/sysfs05.c
> > @@ -129,7 +129,7 @@ int main(int ac, char **av)
> >  		}		/*End of TEST LOOPS */
> >  	}
> >  #else
> > -	tst_resm(TWARN,
> > +	tst_resm(TCONF,
> >  		 "This test can only run on kernels that support the sysfs system
> >  		 call");
> >  #endif
> >  
> > diff --git a/testcases/kernel/syscalls/sysfs/sysfs06.c
> > b/testcases/kernel/syscalls/sysfs/sysfs06.c
> > index 121e944..7ef5ee2 100644
> > --- a/testcases/kernel/syscalls/sysfs/sysfs06.c
> > +++ b/testcases/kernel/syscalls/sysfs/sysfs06.c
> > @@ -132,7 +132,7 @@ int main(int ac, char **av)
> >  		}		/*End of TEST LOOPS */
> >  	}
> >  #else
> > -	tst_resm(TWARN,
> > +	tst_resm(TCONF,
> >  		 "This test can only run on kernels that support the sysfs system
> >  		 call");
> >  #endif
> >  
> > --
> > 1.8.3.1
> > 
> > 
> > ------------------------------------------------------------------------------
> > _______________________________________________
> > Ltp-list mailing list
> > Ltp-list@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/ltp-list
> > 
> 

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
