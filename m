Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Jacky.Malcles@bull.net>) id 1MsBPu-0002kO-2i
	for ltp-list@lists.sourceforge.net; Mon, 28 Sep 2009 08:17:06 +0000
Received: from ecfrec.frec.bull.fr ([129.183.4.8])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MsBPl-0003YW-L0
	for ltp-list@lists.sourceforge.net; Mon, 28 Sep 2009 08:17:06 +0000
Message-ID: <4AC070E6.8000403@bull.net>
Date: Mon, 28 Sep 2009 10:16:38 +0200
From: Jacky Malcles <Jacky.Malcles@bull.net>
MIME-Version: 1.0
Subject: [LTP] resent patch for fs_di TestCase
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
To: subrata@linux.vnet.ibm.com
Cc: ltp-list@lists.sourceforge.net

Hi Subrata,

this should apply (I did a try)

[root@xena3 ltp-full-20090831]# patch -p0 < patch.bis
patching file testcases/kernel/fs/fs_di/fs_di
[root@xena3 ltp-full-20090831]#

regards,

-------------------------------------------------------------------------

diff -uprN testcases/kernel/fs/fs_di/fs_di.orig
testcases/kernel/fs/fs_di/fs_di
--- testcases/kernel/fs/fs_di/fs_di.orig        2009-08-31
07:15:46.000000000 +0200
+++ testcases/kernel/fs/fs_di/fs_di     2009-09-28 10:07:22.000000000 +0200
@@ -95,7 +95,6 @@ $trace_logic
     if [ "$CLEANUP" = "ON" ]; then
        rm -rf $TCtmp
        rm -rf ${TESTFS}
-       rm -rf $TMPBASE/*
         rm -f $TCtmp/testfile*
     fi




------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
