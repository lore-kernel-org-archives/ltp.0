Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrivers@iversen-net.dk>) id 1Uoabm-0005qF-0J
	for ltp-list@lists.sourceforge.net; Mon, 17 Jun 2013 14:40:38 +0000
Received: from mail.sikkerhed.org ([93.176.89.22])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Uoabk-0002hJ-55
	for ltp-list@lists.sourceforge.net; Mon, 17 Jun 2013 14:40:37 +0000
Received: from localhost (mailscan.sikkerhed.org [93.176.89.24])
	by mail.sikkerhed.org (Postfix) with ESMTP id 830231668
	for <ltp-list@lists.sourceforge.net>;
	Mon, 17 Jun 2013 16:23:51 +0200 (CEST)
Received: from mail.sikkerhed.org ([93.176.89.22])
	by localhost (mailscan.sikkerhed.org [93.176.89.24]) (amavisd-new,
	port 10024)
	with LMTP id Qt2LX-XuytPZ for <ltp-list@lists.sourceforge.net>;
	Mon, 17 Jun 2013 16:23:46 +0200 (CEST)
Received: from [192.168.20.168] (unknown [86.58.254.98])
	by mail.sikkerhed.org (Postfix) with ESMTPSA id E2986165C
	for <ltp-list@lists.sourceforge.net>;
	Mon, 17 Jun 2013 16:23:46 +0200 (CEST)
Message-ID: <51BF1BF2.1060006@iversen-net.dk>
Date: Mon, 17 Jun 2013 16:23:46 +0200
From: Christian Iversen <chrivers@iversen-net.dk>
MIME-Version: 1.0
Subject: [LTP] Patch for disktest: Handle long filenames more reasonably
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

Hi all (please CC as I'm not on the list)

I've been using disktest, but I found a less than optimal piece of code 
regarding the device names.

I'd like to contribute the following patch:

--- main2.h     2013-06-17 16:21:26.585825912 +0200
+++ main.h      2013-06-17 16:10:08.725310241 +0200
@@ -54,7 +54,7 @@
  #define BLKGETSIZE _IO(0x12,96)                /* IOCTL for getting 
the device size */
  #define BLKSSZGET  _IO(0x12,104)       /* ALT IOCTL for getting the 
device size */

-#define DEV_NAME_LEN           80              /* max character for 
target name */
+#define DEV_NAME_LEN           256             /* max character for 
target name */
  #define MAX_ARG_LEN                    160             /* max length 
of command line arguments for startarg display */
  #define HOSTNAME_SIZE          16              /* number of hostname 
characters used in mark header */
  #define BLK_SIZE                       512             /* default size 
of an LBA in bytes */


(or perhaps simply use PATH_MAX)

80 characters is way too much for devices like /dev/sdc, but easily too 
little for 
"/dev/disk/by-path/ip-172.16.15.51:3260-iscsi-iqn.2013-01.com.synology:srvnas1.02-lun-0" 
(that's a real device name, btw)

I know, iSCSI names are really long, but disktest should be able to 
handle it more gracefully. I got a really odd error ("could not open 
device") because the last handful of characters has been cut out.

-- 
Med venlig hilsen
Christian Iversen

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
