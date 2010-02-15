Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <y_yao@ryobi.co.jp>) id 1NguWj-0002mT-TX
	for ltp-list@lists.sourceforge.net; Mon, 15 Feb 2010 06:33:49 +0000
Received: from out02.sjc.mx.trendmicro.com ([216.99.131.6])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NguWi-0000jP-An
	for ltp-list@lists.sourceforge.net; Mon, 15 Feb 2010 06:33:49 +0000
Received: from relay02.sjc.mx.trendmicro.com (unknown [10.30.239.25])
	by out02.sjc.mx.trendmicro.com (Postfix) with ESMTP id 3859C58C507
	for <ltp-list@lists.sourceforge.net>;
	Mon, 15 Feb 2010 06:33:40 +0000 (UTC)
Received: from smtp-gate.ryobi.co.jp (unknown [210.163.224.132])
	by relay02.sjc.mx.trendmicro.com (Postfix) with ESMTP id 975C09583C
	for <ltp-list@lists.sourceforge.net>;
	Mon, 15 Feb 2010 06:33:39 +0000 (UTC)
Received: from 5108637 ([10.113.10.201]) by po.rsoa.ryobi.co.jp
	(Post.Office MTA v4.1.1 release 20090730
	ID# 201-058U1200L1200S0V41J) with ESMTP id jp
	for <ltp-list@lists.sourceforge.net>; Mon, 15 Feb 2010 15:33:38 +0900
From: "Yuki Yao" <y_yao@ryobi.co.jp>
Date: Mon, 15 Feb 2010 15:33:37 +0900
Message-ID: <000f01caae08$ce91e640$6bb5b2c0$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: [LTP] "logrotate01" has problem
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

I contributed following problem previously, but it's not yet revised.
So, I contribute this again.

After "./runltp" execution, all log files such as "/var/log/messages*" 
disappeared, and there is only new log file created after the test.

This seems a problem that occurs after the "logrotate01" test. 
I found that the past log files were deleted by forcing a "logrotate"
(logrotate -fv $LTPTMP/tst_logrotate.conf).

Besides, logrotate01's shell script "./testcases/commands/logrotate
/logrotate_tests.sh" creats logrotate configuration file ($LTPTMP
/tst_logrotate.conf) for the test, and this configration file includes
"/etc/logrotate.d" as follows:

[ ./testcases/commands/logrotate/logrotate_tests.sh line:156~ ]
----------
# create config file.
	cat >$LTPTMP/tst_logrotate.conf <<-EOF
	#****** Begin Config file *******
	# create new (empty) log files after rotating old ones
	create

	# compress the log files
	compress

	# RPM packages drop log rotation information into this directory
	include /etc/logrotate.d

	/var/log/tst_logfile {
		rotate 5
		weekly
	}
	#****** End Config file *******
	EOF
----------

By This, not only a log file for the test (/var/log/tst_logfile) 
but also 30 fies such as "/var/log/messages*" become "logrotate" 
command target.
Only a log file for this test must become a target of the forced 
execution of "logrotate".

To resolve this problem, we must change "/logrotate_tests.sh" not to 
include "/etc/logrotate.d", I think.

Signed-off-by: Yuki Yao<y_yao@ryobi.co.jp>

Index: ./testcases/commands/logrotate/logrotate_tests.sh
============
--- ./testcases/commands/logrotate/logrotate_tests.sh.orig	2008-10-21
15:54:15.000000000 +0900
+++ ./testcases/commands/logrotate/logrotate_tests.sh	2010-02-15
13:32:02.000000000 +0900
@@ -163,7 +163,7 @@
 	compress
 
 	# RPM packages drop log rotation information into this directory
-	include /etc/logrotate.d
+	# include /etc/logrotate.d
 
 	/var/log/tst_logfile {
 		rotate 5
@@ -200,7 +200,7 @@
 		# check if  /etc/logrotate.d is included/
 		# check if 5 rotations are forced.
         # check if compression is done.
-		grep "including /etc/logrotate.d" $LTPTMP/tst_logrotate.out
\
+		# grep "including /etc/logrotate.d"
$LTPTMP/tst_logrotate.out \
 			> $LTPTMP/tst_logrotate.err 2>&1 || RC=$?
 		grep "reading config file $LTPTMP/tst_logrotate.conf" \
 			$LTPTMP/tst_logrotate.out   >
$LTPTMP/tst_logrotate.err 2>&1 || RC=$?
============


I'm glad if I got some opinion about this.

Thank you,
-Yuki Yao



------------------------------------------------------------------------------
SOLARIS 10 is the OS for Data Centers - provides features such as DTrace,
Predictive Self Healing and Award Winning ZFS. Get Solaris 10 NOW
http://p.sf.net/sfu/solaris-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
