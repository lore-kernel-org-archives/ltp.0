Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <deller@gmx.de>) id 1VdRKj-0006Rb-Am
	for ltp-list@lists.sourceforge.net; Mon, 04 Nov 2013 21:05:13 +0000
Received: from mout.gmx.net ([212.227.15.19])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1VdRKh-0007GY-8Z
	for ltp-list@lists.sourceforge.net; Mon, 04 Nov 2013 21:05:13 +0000
Received: from [192.168.178.60] ([84.173.31.83]) by mail.gmx.com (mrgmx003)
	with ESMTPSA (Nemesis) id 0Lg0wl-1VyFR53Dhr-00pZw7 for
	<ltp-list@lists.sourceforge.net>; Mon, 04 Nov 2013 22:05:04 +0100
Message-ID: <52780C00.6010706@gmx.de>
Date: Mon, 04 Nov 2013 22:05:04 +0100
From: Helge Deller <deller@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090608070808010503090401"
Subject: [LTP] [PATCH] fcntl16.c patch
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------090608070808010503090401
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

The fcntl16 testcase is being compiled twice, once normal, and the other
time with the _FILE_OFFSET_BITS=64 define set.

When compiled with 64bit file functions (as fcntl16_64) all 
file functions will automatically use their 64bit variants, e.g.
"struct flock64" instead of "struct flock".

So, when in the code e.g.
	fcntl(fd, F_SETLK, thislock)
is called, this will automatically be translated into
	fcntl64(fd, F_SETLK64, thislock)
and "thislock" needs to be of type "struct flock64".

So, we need to make sure that thislock is of the correct type,
with the start and len fields being of type "off_t" which then
will be translated into "loff_t" during compilation when 
_FILE_OFFSET_BITS=64 is set.

This fixes the fcntl16_64 testcase on hppa64-linux-gnu with
32bit userspace running on 64bit kernel.

Signed-off-by: Helge Deller <deller@gmx.de>

--------------090608070808010503090401
Content-Type: text/x-patch;
 name="fcntl16.c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="fcntl16.c.patch"

diff -up ./testcases/kernel/syscalls/fcntl/fcntl16.c.org ./testcases/kernel/syscalls/fcntl/fcntl16.c
--- ./testcases/kernel/syscalls/fcntl/fcntl16.c.org	2013-11-04 15:25:15.000000000 +0100
+++ ./testcases/kernel/syscalls/fcntl/fcntl16.c	2013-11-04 16:06:33.000000000 +0100
@@ -66,8 +66,8 @@
 typedef struct {
 	short type;
 	short whence;
-	long start;
-	long len;
+	off_t start;
+	off_t len;
 	short flag;
 } lock;
 

--------------090608070808010503090401
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Android is increasing in popularity, but the open development platform that
developers love is also attractive to malware creators. Download this white
paper to learn more about secure code signing practices that can help keep
Android apps secure.
http://pubads.g.doubleclick.net/gampad/clk?id=65839951&iu=/4140/ostg.clktrk
--------------090608070808010503090401
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------090608070808010503090401--

