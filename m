Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NJ244-0007pk-F5
	for ltp-list@lists.sourceforge.net; Fri, 11 Dec 2009 09:45:32 +0000
Received: from mail-gx0-f224.google.com ([209.85.217.224])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NJ23x-0003va-EA
	for ltp-list@lists.sourceforge.net; Fri, 11 Dec 2009 09:45:32 +0000
Received: by gxk24 with SMTP id 24so839145gxk.6
	for <ltp-list@lists.sourceforge.net>;
	Fri, 11 Dec 2009 01:45:19 -0800 (PST)
Mime-Version: 1.0 (Apple Message framework v1077)
From: Garrett Cooper <yanegomi@gmail.com>
In-Reply-To: <000001ca7a43$574a3900$05deab00$@co.jp>
Date: Fri, 11 Dec 2009 01:45:16 -0800
Message-Id: <43E7FEEB-166F-4F94-9820-1AD5B924D71B@gmail.com>
References: <000001ca7a43$574a3900$05deab00$@co.jp>
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
To: Mitani <mitani@ryobi.co.jp>
Cc: ltp-list@lists.sourceforge.net

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

1. Case 1 should be tst_brkm TCONF and should have exit 0 (like you suggested).
2. Case 2 should have the equivalent exit code for TBROK (it's in include/test.h). $? -> -1 is undefined via POSIX and while it passes on bash, it doesn't pass on ash, and thus would fail with busybox.
Thanks,
-Garrett
------------------------------------------------------------------------------
Return on Information:
Google Enterprise Search pays you back
Get the facts.
http://p.sf.net/sfu/google-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
