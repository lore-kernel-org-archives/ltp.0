Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <michal.simek@petalogix.com>) id 1NRoia-0006Dx-HB
	for ltp-list@lists.sourceforge.net; Mon, 04 Jan 2010 15:19:40 +0000
Received: from mail-bw0-f212.google.com ([209.85.218.212])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NRoiY-00010c-4b
	for ltp-list@lists.sourceforge.net; Mon, 04 Jan 2010 15:19:40 +0000
Received: by bwz4 with SMTP id 4so9472669bwz.2
	for <ltp-list@lists.sourceforge.net>;
	Mon, 04 Jan 2010 07:19:31 -0800 (PST)
Message-ID: <4B4204D2.70204@petalogix.com>
Date: Mon, 04 Jan 2010 16:10:10 +0100
From: Michal Simek <michal.simek@petalogix.com>
MIME-Version: 1.0
Subject: [LTP] lchown test case
Reply-To: michal.simek@petalogix.com
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
To: Garrett Cooper <yanegomi@gmail.com>, "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi,

I have some problems with lchown02 test which is caused with this patch.
What is prep_create_link?

Thanks,
Michal

http://git.kernel.org/?p=linux/kernel/git/galak/ltp.git;a=commitdiff;h=ee1a022fc76076d7fc1b6b1797c195244414c038


diff --git a/runtest/syscalls b/runtest/syscalls
index fbe8641..34631ed 100644 (file)
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -462,10 +462,10 @@ kill12 kill12

  lchown01 lchown01
  lchown01_16 lchown01_16
-lchown02 cp -p $LTPROOT/testcases/bin/create_link $TMP; lchown02
-lchown02_16 cp -p $LTPROOT/testcases/bin/create_link $TMP; lchown02_16
+lchown02 prep_create_link; lchown02
+lchown02_16 prep_create_link; lchown02_16

-- 
Michal Simek, Ing. (M.Eng)
PetaLogix - Linux Solutions for a Reconfigurable World
w: www.petalogix.com p: +61-7-30090663,+42-0-721842854 f: +61-7-30090663

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
