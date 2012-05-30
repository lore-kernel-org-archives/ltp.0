Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <penght@cn.fujitsu.com>) id 1SZdep-0004Cl-0j
	for ltp-list@lists.sourceforge.net; Wed, 30 May 2012 07:49:27 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SZdei-0004Bj-5b
	for ltp-list@lists.sourceforge.net; Wed, 30 May 2012 07:49:26 +0000
Received: from mailserver.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id q4U7nZ9a015506
	for <ltp-list@lists.sourceforge.net>; Wed, 30 May 2012 15:49:36 +0800
Message-ID: <4FC5D120.8010002@cn.fujitsu.com>
Date: Wed, 30 May 2012 15:49:52 +0800
From: Peng Haitao <penght@cn.fujitsu.com>
MIME-Version: 1.0
References: <1338363782-10590-1-git-send-email-penght@cn.fujitsu.com>
In-Reply-To: <1338363782-10590-1-git-send-email-penght@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] filecapstest.sh: fix a bug of fail in RHEL5
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
To: ltp-list@lists.sourceforge.net

On 05/30/2012 03:43 PM, Peng Haitao wrote:

> setcap is not used in ltp, So AC_CHECK_PROG(SETCAP,setcap,setcap)
> should be deleted.
> 
> When HAVE_LIBCAP is not defined, the case should not be fail.
> 


Before the patch, the test log is as follows:
<<<test_start>>>
tag=Cap_bounds stime=1338362616
cmdline="run_capbounds.sh"
contacts=""
analysis=exit
<<<test_output>>>
<<<execution_status>>>
initiation_status="pan(6369): execvp of 'run_capbounds.sh' (tag
Cap_bounds) failed.  errno:2  No such file or directory"
duration=0 termination_type=exited termination_id=2 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=Filecaps stime=1338362616
cmdline="filecapstest.sh"
contacts=""
analysis=exit
<<<test_output>>>
<<<execution_status>>>
initiation_status="pan(6369): execvp of 'filecapstest.sh' (tag Filecaps)
failed.  errno:2  No such file or directory"
duration=0 termination_type=exited termination_id=2 corefile=no
cutime=0 cstime=0
<<<test_end>>>
incrementing stop
INFO: ltp-pan reported all tests PASS
LTP Version: 20120401-51-gd5507d0

       ###############################################################

            Done executing testcases.
            LTP Version:  20120401-51-gd5507d0
       ###############################################################

# cat /opt/ltp/results/LTP_RUN_ON-2012_May_30-15h_23m_36s.log
Test Start Time: Wed May 30 15:23:36 2012
-----------------------------------------
Testcase                       Result     Exit Value
--------                       ------     ----------
Cap_bounds                     FAIL       2
Filecaps                       FAIL       2

-----------------------------------------------
Total Tests: 2
Total Failures: 2
Kernel Version: 2.6.18-274.el5
Machine Architecture: x86_64
Hostname: RHEL5U7GA-Intel64


After the patch, the test log is as follows:
<<<test_start>>>
tag=Cap_bounds stime=1338362725
cmdline="run_capbounds.sh"
contacts=""
analysis=exit
<<<test_output>>>

Set variables TCID, TST_TOTAL, and TST_COUNT before each test:
export TCID=<test name>
export TST_TOTAL=<Total Number of Tests >
export TST_COUNT=<Test case number>

/opt/ltp/testcases/bin/run_capbounds.sh: line 26: 13933 Aborted
        tst_resm TCONF "System kernel version is less than 2.6.25"

Set variables TCID, TST_TOTAL, and TST_COUNT before each test:
export TCID=<test name>
export TST_TOTAL=<Total Number of Tests >
export TST_COUNT=<Test case number>

/opt/ltp/testcases/bin/run_capbounds.sh: line 26: 13934 Aborted
        tst_resm TCONF "Cannot execute test"
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=Filecaps stime=1338362725
cmdline="filecapstest.sh"
contacts=""
analysis=exit
<<<test_output>>>
Running in:
cap_sys_admin tests
filecaps    1  TCONF  :  System doesn't have POSIX capabilities support.
testing for correct caps
filecaps    1  TCONF  :  System doesn't have POSIX capabilities support.
testing for correct pI checks
filecaps    1  TCONF  :  System doesn't have POSIX capabilities support.
incrementing stop
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
INFO: ltp-pan reported all tests PASS
LTP Version: 20120401-52-g82fb69b

       ###############################################################

            Done executing testcases.
            LTP Version:  20120401-52-g82fb69b
       ###############################################################

# cat /opt/ltp/results/LTP_RUN_ON-2012_May_30-15h_25m_25s.log
Test Start Time: Wed May 30 15:25:25 2012
-----------------------------------------
Testcase                       Result     Exit Value
--------                       ------     ----------
Cap_bounds                     PASS       0
Filecaps                       PASS       0

-----------------------------------------------
Total Tests: 2
Total Failures: 0
Kernel Version: 2.6.18-274.el5
Machine Architecture: x86_64
Hostname: RHEL5U7GA-Intel64


-- 
Best Regards,
Peng

> Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>
> ---
>  include/mk/features.mk.default                      |    3 ---
>  include/mk/features.mk.in                           |    3 ---
>  m4/ltp-cap.m4                                       |    1 -
>  testcases/kernel/security/Makefile                  |    8 --------
>  testcases/kernel/security/cap_bound/cap_bounds_r.c  |    4 ++--
>  testcases/kernel/security/cap_bound/cap_bounds_rw.c |   10 +++++++++-
>  6 files changed, 11 insertions(+), 18 deletions(-)
> 
> diff --git a/include/mk/features.mk.default b/include/mk/features.mk.default
> index 75a4c1d..86e4d4c 100644
> --- a/include/mk/features.mk.default
> +++ b/include/mk/features.mk.default
> @@ -20,9 +20,6 @@
>  # Garrett Cooper, October 2010
>  #
>  
> -# Path to setcap program
> -SETCAP				:=
> -
>  # Tools enable knobs
>  WITH_EXPECT			:= no
>  
> diff --git a/include/mk/features.mk.in b/include/mk/features.mk.in
> index c9162e5..1fd28f8 100644
> --- a/include/mk/features.mk.in
> +++ b/include/mk/features.mk.in
> @@ -20,9 +20,6 @@
>  # Garrett Cooper, October 2010
>  #
>  
> -# Path to setcap program
> -SETCAP				:= @SETCAP@
> -
>  # Tools enable knobs
>  WITH_EXPECT			:= @WITH_EXPECT@
>  
> diff --git a/m4/ltp-cap.m4 b/m4/ltp-cap.m4
> index 953ea50..c646c8c 100644
> --- a/m4/ltp-cap.m4
> +++ b/m4/ltp-cap.m4
> @@ -29,7 +29,6 @@ AH_TEMPLATE(HAVE_LIBCAP,
>  AC_CHECK_HEADERS([sys/capability.h],[capability_header_prefix="sys"])
>  if test "x$capability_header_prefix" != x; then
>  	AC_CHECK_LIB(cap,cap_compare,[cap_libs="-lcap"])
> -	AC_CHECK_PROG(SETCAP,setcap,setcap)
>  fi
>  if test "x$cap_libs" != x; then
>  	AC_DEFINE(HAVE_LIBCAP)
> diff --git a/testcases/kernel/security/Makefile b/testcases/kernel/security/Makefile
> index 9a7a2b2..0bb816f 100644
> --- a/testcases/kernel/security/Makefile
> +++ b/testcases/kernel/security/Makefile
> @@ -24,14 +24,6 @@ top_srcdir		?= ../../..
>  
>  include	$(top_srcdir)/include/mk/env_pre.mk
>  
> -# For broken compilers and toolchains, like Montavista, that improperly detect
> -# system headers when running autoconf -_-... bleh.
> -ifeq ($(strip $(CAP_LIBS)),)
> -FILTER_OUT_DIRS		:= cap_bound filecaps securebits
> -endif
> -ifeq ($(strip $(SETCAP)),)
> -FILTER_OUT_DIRS		+= filecaps
> -endif
>  ifneq ($(HAVE_SECUREBITS),yes)
>  FILTER_OUT_DIRS		+= securebits
>  endif
> diff --git a/testcases/kernel/security/cap_bound/cap_bounds_r.c b/testcases/kernel/security/cap_bound/cap_bounds_r.c
> index 006ab6a..0c09873 100644
> --- a/testcases/kernel/security/cap_bound/cap_bounds_r.c
> +++ b/testcases/kernel/security/cap_bound/cap_bounds_r.c
> @@ -37,7 +37,7 @@ int TST_TOTAL=1;
>  
>  int main(int argc, char *argv[])
>  {
> -#if HAVE_SYS_CAPABILITY_H
> +#ifdef HAVE_LIBCAP
>  	int ret = 1;
>  	int i;
>  
> @@ -88,4 +88,4 @@ int main(int argc, char *argv[])
>  	tst_resm(TCONF, "System doesn't have POSIX capabilities.");
>  #endif
>  	tst_exit();
> -}
> \ No newline at end of file
> +}
> diff --git a/testcases/kernel/security/cap_bound/cap_bounds_rw.c b/testcases/kernel/security/cap_bound/cap_bounds_rw.c
> index eb69b4e..7ebdd65 100644
> --- a/testcases/kernel/security/cap_bound/cap_bounds_rw.c
> +++ b/testcases/kernel/security/cap_bound/cap_bounds_rw.c
> @@ -55,6 +55,7 @@ int check_remaining_caps(int lastdropped)
>  			return i;
>  		}
>  	}
> +#ifdef HAVE_LIBCAP
>  	for (; i <= CAP_LAST_CAP; i++) {
>  #if HAVE_DECL_PR_CAPBSET_READ
>  		ret = prctl(PR_CAPBSET_READ, i);
> @@ -71,6 +72,9 @@ int check_remaining_caps(int lastdropped)
>  			return -i;
>  		}
>  	}
> +#else
> +	printf("System doesn't support full POSIX capabilities.\n");
> +#endif
>  	return 0;
>  }
>  
> @@ -79,6 +83,7 @@ int main(int argc, char *argv[])
>  	int ret = 1;
>  	int i;
>  
> +#ifdef HAVE_LIBCAP
>  #if HAVE_DECL_PR_CAPBSET_DROP
>  	ret = prctl(PR_CAPBSET_READ, -1);
>  #else
> @@ -131,5 +136,8 @@ int main(int argc, char *argv[])
>  		}
>  	}
>  	tst_resm(TPASS, "PR_CAPBSET_DROP tests passed\n");
> +#else
> +	printf("System doesn't support full POSIX capabilities.\n");
> +#endif
>  	tst_exit();
> -}
> \ No newline at end of file
> +}



------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
