Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1Odw6p-0002b6-Lb
	for ltp-list@lists.sourceforge.net; Wed, 28 Jul 2010 02:11:03 +0000
Received: from out14.sjc.mx.trendmicro.com ([216.99.131.51])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Odw6n-0000r8-BG
	for ltp-list@lists.sourceforge.net; Wed, 28 Jul 2010 02:11:03 +0000
Received: from relay02.sjc.mx.trendmicro.com (unknown [10.30.239.27])
	by out14.sjc.mx.trendmicro.com (Postfix) with ESMTP id 4F4E2980432
	for <ltp-list@lists.sourceforge.net>;
	Wed, 28 Jul 2010 02:10:55 +0000 (UTC)
Received: from smtp-gate.ryobi.co.jp (unknown [210.163.224.132])
	by relay02.sjc.mx.trendmicro.com (Postfix) with ESMTP id D7F9E95839
	for <ltp-list@lists.sourceforge.net>;
	Wed, 28 Jul 2010 02:10:54 +0000 (UTC)
Received: from 5109496 ([10.113.10.40]) by po.rsoa.ryobi.co.jp
	(Post.Office MTA v4.1.1 release 20090730
	ID# 201-058U1200L1200S0V41J) with ESMTP id jp
	for <ltp-list@lists.sourceforge.net>; Wed, 28 Jul 2010 11:10:52 +0900
From: "Mitani" <mitani@ryobi.co.jp>
Date: Wed, 28 Jul 2010 11:10:52 +0900
Message-ID: <000a01cb2dfa$1ab62650$502272f0$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: [LTP] How to run "conformance" tests?
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

Hi,


I want to run "conformance" testcases in "open_posix_testsuite".
But I couldn't run it without manually copying.

I used "ltp-dev-a4e64cb8bb97d09b5695151106946a76984b330a.tar.gz" git.
Environment is RHEL5.5 and x86_64 architecture.

First, I executed following commands.
  make autotools
  configure
  make
  make install
And I confirmed that those commands succeeded.
And I could see "logfile.conformance-all" file in "${LTPROOT}/testcases
/open_posix_testsuite" directory.

I ran "make conformance-test" command. But it failed as follows:
------------
make[1]: Entering directory
`/home/LTP/ltp-dev-20100726/testcases/open_posix_testsuite/con
formance'
make[2]: Entering directory
`/home/LTP/ltp-dev-20100726/testcases/open_posix_testsuite/con
formance/behavior'
make[3]: Entering directory
`/home/LTP/ltp-dev-20100726/testcases/open_posix_testsuite/con
formance/behavior/WIFEXITED'
./run.sh: line 2: /bin/run-tests.sh: No such file or directory
make[3]: *** [test] Error 127
make[3]: Leaving directory
`/home/LTP/ltp-dev-20100726/testcases/open_posix_testsuite/conf
ormance/behavior/WIFEXITED'
make[3]: Entering directory
`/home/LTP/ltp-dev-20100726/testcases/open_posix_testsuite/con
formance/behavior/timers'
./run.sh: line 2: /bin/run-tests.sh: No such file or directory
make[3]: *** [test] Error 127
...
------------


So I copied following files to "/bin" directory manually.
  "${LTPROOT}/testcases/open_posix_testsuite/bin/run-tests.sh"
  "${LTPROOT}/testcases/open_posix_testsuite/bin/t0"

After that, "make conformance-test" command began to run.
I confirmed redirected log file, it was as follows:

------------
make[1]: Entering directory
`/home/LTP/ltp-dev-20100726/testcases/open_posix_testsuite/con
formance'
make[2]: Entering directory
`/home/LTP/ltp-dev-20100726/testcases/open_posix_testsuite/con
formance/behavior'
make[3]: Entering directory
`/home/LTP/ltp-dev-20100726/testcases/open_posix_testsuite/con
formance/behavior/WIFEXITED'
/bin/run-tests.sh: line 109: 11583 Alarm clock             $SCRIPT_DIR/t0 0
*******************
SUMMARY
*******************
PASS              3
FAIL              0
*******************
TOTAL             3
*******************
make[3]: Leaving directory
`/home/LTP/ltp-dev-20100726/testcases/open_posix_testsuite/conf
ormance/behavior/WIFEXITED'
make[3]: Entering directory
`/home/LTP/ltp-dev-20100726/testcases/open_posix_testsuite/con
formance/behavior/timers'
*******************
SUMMARY
*******************
PASS              2
FAIL              0
*******************
TOTAL             2
*******************
...
------------


Is my method wrong? 
Or is there the insufficient operation?



Regards--

-Tomonori Mitani



------------------------------------------------------------------------------
The Palm PDK Hot Apps Program offers developers who use the
Plug-In Development Kit to bring their C/C++ apps to Palm for a share 
of $1 Million in cash or HP Products. Visit us here for more details:
http://ad.doubleclick.net/clk;226879339;13503038;l?
http://clk.atdmt.com/CRS/go/247765532/direct/01/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
