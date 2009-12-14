Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1NK5yw-0006ZK-0t
	for ltp-list@lists.sourceforge.net; Mon, 14 Dec 2009 08:08:38 +0000
Received: from smtp-gate3.ryobi.co.jp ([210.163.224.134])
	by sfi-mx-3.v28.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1NK5yq-0007pj-V5
	for ltp-list@lists.sourceforge.net; Mon, 14 Dec 2009 08:08:37 +0000
From: "Mitani" <mitani@ryobi.co.jp>
References: <000001ca7a43$574a3900$05deab00$@co.jp>
	<43E7FEEB-166F-4F94-9820-1AD5B924D71B@gmail.com>
In-Reply-To: <43E7FEEB-166F-4F94-9820-1AD5B924D71B@gmail.com>
Date: Mon, 14 Dec 2009 17:08:20 +0900
Message-ID: <000001ca7c94$99d4bae0$cd7e30a0$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: Re: [LTP] "cgroup_fj" and "cgroup" have problems?
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
To: 'Garrett Cooper' <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

I took your indication and changed the patch as follows.

Case 1:
I revised "[ -f /proc/cgroups ]" case to use "tst_resm TCONF"
instead of "echo".
But this revision is unbalanced with the other exit messages,
so I revised other cases too.
I don't know how to use exit code, so I use 0 or 1.
I might mistake those code.

============
--- run_cgroup_test_fj.sh	2009-10-26 23:49:23.000000000 +0900
+++ run_cgroup_test_fj.sh.new	2009-12-14 14:21:53.000000000 +0900
@@ -34,19 +34,19 @@
 export CASENO2=0
 
 if [ "$(id -ru)" -ne 0 ]; then
-	echo "***error***:you must use root to test"
-	exit -1
+	tst_brkm TBROK ignored "***error***:you must use root to test"
+	exit 1
 fi
 
 if ! [ -f /proc/cgroups ]; then
-	echo "***error***:you must enable cgroup config in kernel";
-	exit -3;
+	tst_resm TCONF "***error***:you must enable cgroup config in
kernel";
+	exit 0;
 fi
 
 if [ ! -x $TESTROOT/cgroup_fj_proc ]; then
-	echo "***warning***:file \"cgroup_fj_proc\" is not exist or not
executable";
-	echo "please do make and check execution permission"
-	exit -4;
+	tst_brkm TBROK ignored "***warning***:file \"cgroup_fj_proc\" is not
exist or not executable";
+	tst_brkm TBROK ignored "please do make and check execution
permission"
+	exit 1;
 fi
 
 CPUSET=`grep -w cpuset /proc/cgroups | cut -f1`;
@@ -83,10 +83,10 @@
         SYBSYSCOMPILED="$SYBSYSCOMPILED devices,"
 fi
 if [ "$SYBSYSCOMPILED" = "" ];then	# Warning and exit if all cgroup
subsystem are not compiled
-	echo "CONTROLLERS TESTCASES: WARNING";
-	echo "Kernel does not support for any cgroup subsystem";
-	echo "Skipping all controllers testcases....";
-	exit -2;
+	tst_resm TCONF "CONTROLLERS TESTCASES: WARNING";
+	tst_resm TCONF "Kernel does not support for any cgroup subsystem";
+	tst_resm TCONF "Skipping all controllers testcases....";
+	exit 0;
 fi
 
 echo "Now, we start the test for cgroup...";
============


Case 2:
I revised "[ "$USER" != root ]" case, and revised 
"[ ! -f /proc/cgroups ]" case to use "tst_resm" instead of "echocase"
 for balance.

============
--- cgroup_regression_test.sh	2009-11-30 17:41:37.000000000 +0900
+++ cgroup_regression_test.sh.new	2009-12-14 11:42:58.000000000 +0900
@@ -29,15 +29,15 @@
 export TST_COUNT=1
 
 if [ ! -f /proc/cgroups ]; then
-        echo "CONTROLLERS TESTCASES: WARNING"
-        echo "Kernel does not support for control groups";
-        echo "Skipping all controllers testcases....";
+	tst_resm TCONF "CONTROLLERS TESTCASES: WARNING"
+	tst_resm TCONF "Kernel does not support for control groups"
+	tst_resm TCONF "Skipping all controllers testcases...."
 	exit 0
 fi
 
 if [ "$USER" != root ]; then
 	tst_brkm TBROK ignored "Test must be run as root"
-	exit 0
+	exit 1
 fi
 
 tst_kvercmp 2 6 29
============


Regards--


-Tomonori Mitani


-----Original Message-----
From: Garrett Cooper [mailto:yanegomi@gmail.com] 
Sent: Friday, December 11, 2009 6:45 PM
To: Mitani
Cc: ltp-list@lists.sourceforge.net
Subject: Re: [LTP] "cgroup_fj" and "cgroup" have problems?

On Dec 11, 2009, at 1:21 AM, Mitani wrote:

> Hi,
> 
> Sorry for my many many mails today.
> 
> 
> I ran tests with "ltp-2009-12-10" cvs.
> 
> In my system (kernel 2.6.18-164.el5), kernel does not support 
> control groups.
> So, when I ran test of "cgroup_fj", I got following message and the
> test faild by "FAIL 253".
> 
> ------------
> ***error***:you must enable cgroup config in kernel
> ------------
> 
> In the investigation for above error message, I found that there may be
> two problems,.
> 
>  (a) "cgroup_fj" test failed in the system not support "control groups".
>  (b) "cgroup" test may passed by user-ID which isn't "root".
> 
> 
> (a) "cgroup_fj" test
>  Above message is correct message, but exiting by "FAIL" is not
>  correct, I think.
>  Referring to the example of other tests, I think that the tests
>  for non-supported functions must be finished in "PASS 0" basically.
>  (For example, "move_pages{01...11}" tests exit in "PASS 0" and with 
>  "NUMA support not provided" messages.)
> 
>  I suggest following patch to resolve this problem.
> 
> ============
> --- run_cgroup_test_fj.sh	2009-10-26 23:49:23.000000000 +0900
> +++ run_cgroup_test_fj.sh.new	2009-12-11 16:10:39.000000000 +0900
> @@ -40,7 +40,7 @@
> 
> if ! [ -f /proc/cgroups ]; then
> 	echo "***error***:you must enable cgroup config in kernel";
> -	exit -3;
> +	exit 0;
> fi
> 
> if [ ! -x $TESTROOT/cgroup_fj_proc ]; then
> 
> ============
> 
> 
> (b) "cgroup" test
>  I watched "cgroup" test source for hints for (a), and found another
>  problem.
>  If this test run by user-ID non-"root", it will exit in "PASS", I think.
>  But I think that it must exit in "FAIL".
>  Because this test cannot be tested only by "root" user.
> 
> =========
> --- cgroup_regression_test.sh	2009-11-30 17:41:37.000000000 +0900
> +++ cgroup_regression_test.sh.new	2009-12-11 16:22:14.000000000 +0900
> @@ -37,7 +37,7 @@
> 
> if [ "$USER" != root ]; then
> 	tst_brkm TBROK ignored "Test must be run as root"
> -	exit 0
> +	exit -1
> fi
> 
> tst_kvercmp 2 6 29

1. Case 1 should be tst_brkm TCONF and should have exit 0 (like you
suggested).
2. Case 2 should have the equivalent exit code for TBROK (it's in
include/test.h). $? -> -1 is undefined via POSIX and while it passes on
bash, it doesn't pass on ash, and thus would fail with busybox.
Thanks,
-Garrett=



------------------------------------------------------------------------------
Return on Information:
Google Enterprise Search pays you back
Get the facts.
http://p.sf.net/sfu/google-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
