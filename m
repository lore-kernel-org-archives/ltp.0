Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1NBMYd-0002w7-8I
	for ltp-list@lists.sourceforge.net; Fri, 20 Nov 2009 06:01:23 +0000
Received: from smtp-gate3.ryobi.co.jp ([210.163.224.134])
	by 1b2kzd1.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1NBMYW-0000Us-Np
	for ltp-list@lists.sourceforge.net; Fri, 20 Nov 2009 06:01:23 +0000
Received: from 5109496 ([10.113.10.40]) by po.rsoa.ryobi.co.jp
	(Post.Office MTA v4.1.1 release 20090730
	ID# 201-058U1200L1200S0V41J) with ESMTP id jp
	for <ltp-list@lists.sourceforge.net>; Fri, 20 Nov 2009 15:00:59 +0900
From: "Mitani" <mitani@ryobi.co.jp>
Date: Fri, 20 Nov 2009 15:00:58 +0900
Message-ID: <000001ca69a6$d6ad7520$84085f60$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: [LTP] move_pages test failed in ltp-2009-11-19.tar.gz
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

When I ran LTP in RHEL5.4 using ltp-2009-11-19.tar.gz, 
"move_pages03" and "move_pages11" were failed in each of "syscalls" and 
"numa" tests like that:

------------
move_pages01    1  TCONF  :  NUMA support not provided
move_pages02    1  TCONF  :  NUMA support not provided
chown: cannot access `move_pages03': No such file or directory
move_pages04    1  TCONF  :  NUMA support not provided
move_pages05    1  TCONF  :  NUMA support not provided
move_pages06    1  TCONF  :  NUMA support not provided
move_pages07    1  TCONF  :  NUMA support not provided
move_pages08    1  TCONF  :  NUMA support not provided
move_pages09    1  TCONF  :  NUMA support not provided
move_pages10    1  TCONF  :  NUMA support not provided
chown: cannot access `move_pages11': No such file or directory
------------


These fails didn't occured with ltp-full-20090930.tgz, but they occured
with ltp-full-20091031.tgz.
With ltp-full-20090930.tgz, all of move_pagesXX (XX:01-11) were passed
(NUMA support not provided) in my system.


I compared these version and found out following scenarios changed.
  - ${LTPROOT}/runtest/numa
  - ${LTPROOT}/runtest/syscalls


These scenarios are as follows, and "move_pages03" and "move_pages01" 
are revised.

------------
# cat ./runtest/numa
Numa-testcases numa01.sh
move_pages01 move_pages.sh 01
move_pages02 move_pages.sh 02
move_pages03 cd $LTPROOT/bin && chown root move_pages03 && chmod 04755 &&
move_pages.sh 03
move_pages04 move_pages.sh 04
move_pages05 move_pages.sh 05
move_pages06 move_pages.sh 06
move_pages07 move_pages.sh 07
move_pages08 move_pages.sh 08
move_pages09 move_pages.sh 09
move_pages10 move_pages.sh 10
move_pages11 cd $LTPROOT/bin && chown root move_pages11 && chmod 04755 &&
move_pages.sh 11
# cat ./runtest/syscalls | grep move_page
move_pages01 move_pages.sh 01
move_pages02 move_pages.sh 02
move_pages03 cd $LTPROOT/bin && chown root move_pages03 && chmod 04755 &&
move_pages.sh 03
move_pages04 move_pages.sh 04
move_pages05 move_pages.sh 05
move_pages06 move_pages.sh 06
move_pages07 move_pages.sh 07
move_pages08 move_pages.sh 08
move_pages09 move_pages.sh 09
move_pages10 move_pages.sh 10
move_pages11 cd $LTPROOT/bin && chown root move_pages11 && chmod 04755 &&
move_pages.sh 11
#------------


I think there are two problems in each changes:

  - "move_pagesXX" files are in "$LTPROOT/testcases/bin" direcotory, 
    not in "$LTPROOT/bin" directory.
  - "chmod" commands don't have target file.


I don't know why these revisions are done. But if these revisions should 
be validated, they will come to work in the change like following, I think.
I wish I can get opinion whether my revision is right or not.

============

--- syscalls	2009-11-18 13:24:34.000000000 +0900
+++ syscalls.new	2009-11-19 16:15:13.000000000 +0900
@@ -571,7 +571,7 @@
 
 move_pages01 move_pages.sh 01
 move_pages02 move_pages.sh 02
-move_pages03 cd $LTPROOT/bin && chown root move_pages03 && chmod 04755 &&
move_pages.sh 03
+move_pages03 cd $LTPROOT/testcases/bin && chown root move_pages03 && chmod
04755 move_pages.sh && move_pages.sh 03
 move_pages04 move_pages.sh 04
 move_pages05 move_pages.sh 05
 move_pages06 move_pages.sh 06
@@ -579,7 +579,7 @@
 move_pages08 move_pages.sh 08
 move_pages09 move_pages.sh 09
 move_pages10 move_pages.sh 10
-move_pages11 cd $LTPROOT/bin && chown root move_pages11 && chmod 04755 &&
move_pages.sh 11
+move_pages11 cd $LTPROOT/testcases/bin && chown root move_pages11 && chmod
04755 move_pages.sh && move_pages.sh 11
 
 mprotect01 mprotect01
 mprotect02 mprotect02

--- numa	2009-11-18 13:24:34.000000000 +0900
+++ numa.new	2009-11-19 16:15:33.000000000 +0900
@@ -1,7 +1,7 @@
 Numa-testcases numa01.sh
 move_pages01 move_pages.sh 01
 move_pages02 move_pages.sh 02
-move_pages03 cd $LTPROOT/bin && chown root move_pages03 && chmod 04755 &&
move_pages.sh 03
+move_pages03 cd $LTPROOT/testcases/bin && chown root move_pages03 && chmod
04755 move_pages.sh && move_pages.sh 03
 move_pages04 move_pages.sh 04
 move_pages05 move_pages.sh 05
 move_pages06 move_pages.sh 06
@@ -9,4 +9,4 @@
 move_pages08 move_pages.sh 08
 move_pages09 move_pages.sh 09
 move_pages10 move_pages.sh 10
-move_pages11 cd $LTPROOT/bin && chown root move_pages11 && chmod 04755 &&
move_pages.sh 11
+move_pages11 cd $LTPROOT/testcases/bin && chown root move_pages11 && chmod
04755 move_pages.sh && move_pages.sh 11

============


In addition, please teach why this revision was performed, if all right.
  - Why do only "move_pages03" and "move_pages11" appoint another directory
    not a current directory?
  - Why "chmod" is needed?



Thank you--

-Tomonori Mitani



------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
