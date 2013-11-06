Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <deller@gmx.de>) id 1Ve8yf-0003aq-4U
	for ltp-list@lists.sourceforge.net; Wed, 06 Nov 2013 19:41:21 +0000
Received: from mout.gmx.net ([212.227.17.21])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1Ve8yd-0001NG-74
	for ltp-list@lists.sourceforge.net; Wed, 06 Nov 2013 19:41:21 +0000
Received: from [192.168.178.60] ([84.173.29.254]) by mail.gmx.com (mrgmx002)
	with ESMTPSA (Nemesis) id 0McVKy-1VMc5g0JOa-00He6C for
	<ltp-list@lists.sourceforge.net>; Wed, 06 Nov 2013 20:41:12 +0100
Message-ID: <527A9B57.1000908@gmx.de>
Date: Wed, 06 Nov 2013 20:41:11 +0100
From: Helge Deller <deller@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090905090306030103070305"
Subject: [LTP] [PATCH] sendfile08 - initialize buf structure
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
--------------090905090306030103070305
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

The sendfile08 testcase uses the sendfile() syscall
to write the strings "hello" and "world" to a file descriptor
and then reads them back in through another file descriptor.

The length of the strings written are determined by strlen(),
so that in total 10 bytes are written.

When reading the strings back in, again 10 bytes are read, but
the problem is, that those are read back into a *local* string
buffer array (buf[]) which hasn't been initialized.

Afterwards, 
  strcmp(buf, "helloworld")
is called to compare input and output.
This strcmp() is wrong, because basically "helloworld\0" 
(with the trailing string zero terminator) is compared to
"helloworld" (likely without a trailing zero in the buf[] array).

So, if buf[] hasn't been initialized, it's not guaranteed
that the 10th byte in buf[10] equals to '\0'.

This problem was found on hppa64-linux-gnu architecture, most
likely, because it's a stack-grows-up architecture.

Fix this buglet, by zero-initializing the buf[] array. 
Alternatively, strncmp() could be used instead of memcmp().

Signed-off-by: Helge Deller <deller@gmx.de>

--------------090905090306030103070305
Content-Type: text/x-patch;
 name="sendfile08.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="sendfile08.patch"

--- ./testcases/kernel/syscalls/sendfile/sendfile08.c.org	2013-11-06 17:07:47.000000000 +0100
+++ ./testcases/kernel/syscalls/sendfile/sendfile08.c	2013-11-06 17:09:09.000000000 +0100
@@ -74,6 +74,8 @@ int main(int argc, char *argv[])
 		if (ret == -1)
 			tst_brkm(TBROK | TERRNO, cleanup, "lseek %s failed",
 				 out_file);
+
+		memset(buf, 0, BUFSIZ);
 		ret = read(out_fd, buf, BUFSIZ);
 		if (ret == -1)
 			tst_brkm(TBROK | TERRNO, cleanup, "read %s failed",

--------------090905090306030103070305
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
November Webinars for C, C++, Fortran Developers
Accelerate application performance with scalable programming models. Explore
techniques for threading, error checking, porting, and tuning. Get the most 
from the latest Intel processors and coprocessors. See abstracts and register
http://pubads.g.doubleclick.net/gampad/clk?id=60136231&iu=/4140/ostg.clktrk
--------------090905090306030103070305
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------090905090306030103070305--

