Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1NRh9E-0007WD-CF
	for ltp-list@lists.sourceforge.net; Mon, 04 Jan 2010 07:14:40 +0000
Received: from out02.sjc.mx.trendmicro.com ([216.99.131.6])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NRh9C-0004og-Qj
	for ltp-list@lists.sourceforge.net; Mon, 04 Jan 2010 07:14:40 +0000
From: "Mitani" <mitani@ryobi.co.jp>
References: <000001ca7a43$574a3900$05deab00$@co.jp>	
	<43E7FEEB-166F-4F94-9820-1AD5B924D71B@gmail.com>	
	<000001ca7c94$99d4bae0$cd7e30a0$@co.jp>
	<364299f40912221653ub6ed378sab394dd54b5077c9@mail.gmail.com>
In-Reply-To: <364299f40912221653ub6ed378sab394dd54b5077c9@mail.gmail.com>
Date: Mon, 4 Jan 2010 16:14:28 +0900
Message-ID: <000401ca8d0d$8df81ee0$a9e85ca0$@co.jp>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: 'Garrett Cooper' <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi,

Thank you for fixing "cgroup" and "cgroup_fj".
However, I found a new problem in revised "cgroup" testcases.

It's in "cgroup_regression_test.sh".

In my original patch, I didn't revise about "tst_kvercmp 2 6 29" =

judgment.
But in fixed version, the error route of above judgment revised =

from "TBROK" to "TCONF".
If "TCONF" is used, the shell should end by exit 0, I think.
But "cgroup_regression_test.sh" does not end by exit 0.

Please consider about the following patch:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- cgroup_regression_test.sh	2009-12-23 09:52:18.000000000 +0900
+++ cgroup_regression_test.sh.new	2009-12-24 15:47:06.000000000 +0900
@@ -31,7 +31,7 @@
 tst_kvercmp 2 6 29
 if [ $? -eq 0 ]; then
 	tst_brkm TCONF ignored "test must be run with kernel 2.6.29 or
newer"
-	exit 1
+	exit 0
 elif [ ! -f /proc/cgroups ]; then
 	tst_brkm TCONF ignored "Kernel does not support for control groups;
skipping testcases";
 	exit 0
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D


Regards--


-Tomonori Miatani

-----Original Message-----
From: Garrett Cooper [mailto:yanegomi@gmail.com] =

Sent: Wednesday, December 23, 2009 9:53 AM
To: Mitani
Cc: ltp-list@lists.sourceforge.net
Subject: Re: [LTP] "cgroup_fj" and "cgroup" have problems?

On Mon, Dec 14, 2009 at 12:08 AM, Mitani <mitani@ryobi.co.jp> wrote:
> I took your indication and changed the patch as follows.
>
> Case 1:
> I revised "[ -f /proc/cgroups ]" case to use "tst_resm TCONF"
> instead of "echo".
> But this revision is unbalanced with the other exit messages,
> so I revised other cases too.
> I don't know how to use exit code, so I use 0 or 1.
> I might mistake those code.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- run_cgroup_test_fj.sh =A0 =A0 =A0 2009-10-26 23:49:23.000000000 +0900
> +++ run_cgroup_test_fj.sh.new =A0 2009-12-14 14:21:53.000000000 +0900
> @@ -34,19 +34,19 @@
> =A0export CASENO2=3D0
>
> =A0if [ "$(id -ru)" -ne 0 ]; then
> - =A0 =A0 =A0 echo "***error***:you must use root to test"
> - =A0 =A0 =A0 exit -1
> + =A0 =A0 =A0 tst_brkm TBROK ignored "***error***:you must use root to te=
st"
> + =A0 =A0 =A0 exit 1
> =A0fi
>
> =A0if ! [ -f /proc/cgroups ]; then
> - =A0 =A0 =A0 echo "***error***:you must enable cgroup config in kernel";
> - =A0 =A0 =A0 exit -3;
> + =A0 =A0 =A0 tst_resm TCONF "***error***:you must enable cgroup config in
> kernel";
> + =A0 =A0 =A0 exit 0;
> =A0fi
>
> =A0if [ ! -x $TESTROOT/cgroup_fj_proc ]; then
> - =A0 =A0 =A0 echo "***warning***:file \"cgroup_fj_proc\" is not exist or=
 not
> executable";
> - =A0 =A0 =A0 echo "please do make and check execution permission"
> - =A0 =A0 =A0 exit -4;
> + =A0 =A0 =A0 tst_brkm TBROK ignored "***warning***:file \"cgroup_fj_proc=
\" is
not
> exist or not executable";
> + =A0 =A0 =A0 tst_brkm TBROK ignored "please do make and check execution
> permission"
> + =A0 =A0 =A0 exit 1;
> =A0fi
>
> =A0CPUSET=3D`grep -w cpuset /proc/cgroups | cut -f1`;
> @@ -83,10 +83,10 @@
> =A0 =A0 =A0 =A0 SYBSYSCOMPILED=3D"$SYBSYSCOMPILED devices,"
> =A0fi
> =A0if [ "$SYBSYSCOMPILED" =3D "" ];then =A0 =A0 # Warning and exit if all=
 cgroup
> subsystem are not compiled
> - =A0 =A0 =A0 echo "CONTROLLERS TESTCASES: WARNING";
> - =A0 =A0 =A0 echo "Kernel does not support for any cgroup subsystem";
> - =A0 =A0 =A0 echo "Skipping all controllers testcases....";
> - =A0 =A0 =A0 exit -2;
> + =A0 =A0 =A0 tst_resm TCONF "CONTROLLERS TESTCASES: WARNING";
> + =A0 =A0 =A0 tst_resm TCONF "Kernel does not support for any cgroup subs=
ystem";
> + =A0 =A0 =A0 tst_resm TCONF "Skipping all controllers testcases....";
> + =A0 =A0 =A0 exit 0;
> =A0fi
>
> =A0echo "Now, we start the test for cgroup...";
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>
> Case 2:
> I revised "[ "$USER" !=3D root ]" case, and revised
> "[ ! -f /proc/cgroups ]" case to use "tst_resm" instead of "echocase"
> =A0for balance.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- cgroup_regression_test.sh =A0 2009-11-30 17:41:37.000000000 +0900
> +++ cgroup_regression_test.sh.new =A0 =A0 =A0 2009-12-14 11:42:58.0000000=
00
+0900
> @@ -29,15 +29,15 @@
> =A0export TST_COUNT=3D1
>
> =A0if [ ! -f /proc/cgroups ]; then
> - =A0 =A0 =A0 =A0echo "CONTROLLERS TESTCASES: WARNING"
> - =A0 =A0 =A0 =A0echo "Kernel does not support for control groups";
> - =A0 =A0 =A0 =A0echo "Skipping all controllers testcases....";
> + =A0 =A0 =A0 tst_resm TCONF "CONTROLLERS TESTCASES: WARNING"
> + =A0 =A0 =A0 tst_resm TCONF "Kernel does not support for control groups"
> + =A0 =A0 =A0 tst_resm TCONF "Skipping all controllers testcases...."
> =A0 =A0 =A0 =A0exit 0
> =A0fi
>
> =A0if [ "$USER" !=3D root ]; then
> =A0 =A0 =A0 =A0tst_brkm TBROK ignored "Test must be run as root"
> - =A0 =A0 =A0 exit 0
> + =A0 =A0 =A0 exit 1
> =A0fi
>
> =A0tst_kvercmp 2 6 29
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>
> Regards--
>
>
> -Tomonori Mitani
>
>
> -----Original Message-----
> From: Garrett Cooper [mailto:yanegomi@gmail.com]
> Sent: Friday, December 11, 2009 6:45 PM
> To: Mitani
> Cc: ltp-list@lists.sourceforge.net
> Subject: Re: [LTP] "cgroup_fj" and "cgroup" have problems?
>
> On Dec 11, 2009, at 1:21 AM, Mitani wrote:
>
>> Hi,
>>
>> Sorry for my many many mails today.
>>
>>
>> I ran tests with "ltp-2009-12-10" cvs.
>>
>> In my system (kernel 2.6.18-164.el5), kernel does not support
>> control groups.
>> So, when I ran test of "cgroup_fj", I got following message and the
>> test faild by "FAIL 253".
>>
>> ------------
>> ***error***:you must enable cgroup config in kernel
>> ------------
>>
>> In the investigation for above error message, I found that there may be
>> two problems,.
>>
>> =A0(a) "cgroup_fj" test failed in the system not support "control groups=
".
>> =A0(b) "cgroup" test may passed by user-ID which isn't "root".
>>
>>
>> (a) "cgroup_fj" test
>> =A0Above message is correct message, but exiting by "FAIL" is not
>> =A0correct, I think.
>> =A0Referring to the example of other tests, I think that the tests
>> =A0for non-supported functions must be finished in "PASS 0" basically.
>> =A0(For example, "move_pages{01...11}" tests exit in "PASS 0" and with
>> =A0"NUMA support not provided" messages.)
>>
>> =A0I suggest following patch to resolve this problem.
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- run_cgroup_test_fj.sh =A0 =A0 2009-10-26 23:49:23.000000000 +0900
>> +++ run_cgroup_test_fj.sh.new 2009-12-11 16:10:39.000000000 +0900
>> @@ -40,7 +40,7 @@
>>
>> if ! [ -f /proc/cgroups ]; then
>> =A0 =A0 =A0 echo "***error***:you must enable cgroup config in kernel";
>> - =A0 =A0 exit -3;
>> + =A0 =A0 exit 0;
>> fi
>>
>> if [ ! -x $TESTROOT/cgroup_fj_proc ]; then
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>>
>> (b) "cgroup" test
>> =A0I watched "cgroup" test source for hints for (a), and found another
>> =A0problem.
>> =A0If this test run by user-ID non-"root", it will exit in "PASS", I thi=
nk.
>> =A0But I think that it must exit in "FAIL".
>> =A0Because this test cannot be tested only by "root" user.
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- cgroup_regression_test.sh 2009-11-30 17:41:37.000000000 +0900
>> +++ cgroup_regression_test.sh.new =A0 =A0 2009-12-11 16:22:14.000000000 =
+0900
>> @@ -37,7 +37,7 @@
>>
>> if [ "$USER" !=3D root ]; then
>> =A0 =A0 =A0 tst_brkm TBROK ignored "Test must be run as root"
>> - =A0 =A0 exit 0
>> + =A0 =A0 exit -1
>> fi
>>
>> tst_kvercmp 2 6 29
>
> 1. Case 1 should be tst_brkm TCONF and should have exit 0 (like you
> suggested).
> 2. Case 2 should have the equivalent exit code for TBROK (it's in
> include/test.h). $? -> -1 is undefined via POSIX and while it passes on
> bash, it doesn't pass on ash, and thus would fail with busybox.
> Thanks,
> -Garrett

Committed -- thanks!
-Garrett



---------------------------------------------------------------------------=
---
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev =

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
