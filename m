Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <michal.simek@petalogix.com>) id 1MMGpA-0006Bv-7q
	for ltp-list@lists.sourceforge.net; Thu, 02 Jul 2009 07:35:16 +0000
Received: from mail-fx0-f208.google.com ([209.85.220.208])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MMGp6-0006fK-8j
	for ltp-list@lists.sourceforge.net; Thu, 02 Jul 2009 07:35:16 +0000
Received: by fxm4 with SMTP id 4so295378fxm.10
	for <ltp-list@lists.sourceforge.net>;
	Thu, 02 Jul 2009 00:35:06 -0700 (PDT)
Message-ID: <4A4C6328.6060405@petalogix.com>
Date: Thu, 02 Jul 2009 09:35:04 +0200
From: Michal Simek <michal.simek@petalogix.com>
MIME-Version: 1.0
Subject: [LTP] getpeername01, getsockname01, socketpair01
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
To: subrata@linux.vnet.ibm.com, LTP <ltp-list@lists.sourceforge.net>

Hi,

Can someone explain me why is in that subject tests for invalid pointer
choose
address 1 (or 7 in socketpair01)? I did some tests on Microblaze and for
this address I am getting segfault.
That's the reason why I think that problem is in glibc or ltp test. All
tests test reaction for invalid pointer address.

The interesting is that any address from 1 to 999 9999 caused segfault.
Address above not.
Below is memory map but first segment starts at 0x1000 0000 not 1000
0000 which is in patches below and works.

# cat /proc/66/maps
10000000-10001000 r-xp 00000000 00:01 394        /opcoded
10001000-10002000 rw-p 00000000 00:01 394        /opcoded
48000000-4801c000 r-xp 00000000 00:01 389        /lib/ld-2.3.3.so
4801c000-4801e000 rw-p 0001b000 00:01 389        /lib/ld-2.3.3.so
4801e000-4817c000 r-xp 00000000 00:01 379        /lib/libc-2.3.3.so
4817c000-4817f000 r--p 0015d000 00:01 379        /lib/libc-2.3.3.so
4817f000-48181000 rw-p 00160000 00:01 379        /lib/libc-2.3.3.so
48181000-48186000 rw-p 00000000 00:00 0
bfc15000-bfc2a000 rwxp 00000000 00:00 0          [stack]


Below are my changes which jump over segfault but they are still invalid
pointer.
Has someone ever met with this problem before?

Patches below are on this link too.
http://developer.petalogix.com/git/gitweb.cgi?p=ltp-microblaze.git;a=commitdiff;h=45f4cd783ce8b94f1267bb87c0c46e8536f62eca

Thanks,
Michal


diff --git a/testcases/kernel/syscalls/getpeername/getpeername01.c
b/testcases/kernel/syscalls/getpeername/getpeername01.c
index 55d349a..3ae015d 100644 (file)
--- a/testcases/kernel/syscalls/getpeername/getpeername01.c
+++ b/testcases/kernel/syscalls/getpeername/getpeername01.c
@@ -93,7 +93,7 @@ struct test_case_t {          /* test case structure */
                    &sinlen, -1, EFAULT, setup2, cleanup1,
                    "invalid socket buffer"}, {
        PF_UNIX, SOCK_STREAM, 0, (struct sockaddr *)&fsin1,
-                   (socklen_t *) 1, -1, EFAULT, setup2, cleanup1,
+                   (socklen_t *) 10000000, -1, EFAULT, setup2, cleanup1,
                    "invalid salen"},
 #endif
 };

diff --git a/testcases/kernel/syscalls/getsockname/getsockname01.c
b/testcases/kernel/syscalls/getsockname/getsockname01.c
index 6159847..2020230 100644 (file)
--- a/testcases/kernel/syscalls/getsockname/getsockname01.c
+++ b/testcases/kernel/syscalls/getsockname/getsockname01.c
@@ -90,7 +90,7 @@ struct test_case_t {          /* test case structure */
                    &sinlen, -1, EFAULT, setup1, cleanup1,
                    "invalid socket buffer"}, {
        PF_INET, SOCK_STREAM, 0, (struct sockaddr *)&fsin1,
-                   (socklen_t *) 1, -1, EFAULT, setup1, cleanup1,
+                   (socklen_t *) 1000000, -1, EFAULT, setup1, cleanup1,
                    "invalid salen"},
 #endif
 };

diff --git a/testcases/kernel/syscalls/socketpair/socketpair01.c
b/testcases/kernel/syscalls/socketpair/socketpair01.c
index fc90529..f8c29c0 100644 (file)
--- a/testcases/kernel/syscalls/socketpair/socketpair01.c
+++ b/testcases/kernel/syscalls/socketpair/socketpair01.c
@@ -81,7 +81,7 @@ struct test_case_t {          /* test case structure */
            /* Skip since uClinux does not implement memory protection */
        {
        PF_UNIX, SOCK_STREAM, 0, 0, -1, EFAULT, "bad pointer"}, {
-       PF_UNIX, SOCK_STREAM, 0, (int *)7, -1, EFAULT, "bad pointer"},
+       PF_UNIX, SOCK_STREAM, 0, (int *)10000000, -1, EFAULT, "bad
pointer"},
 #endif
        {
        PF_INET, SOCK_DGRAM, 17, sv, -1, EOPNOTSUPP, "UDP socket"}, {


-- 
Michal Simek, Ing. (M.Eng)
PetaLogix - Linux Solutions for a Reconfigurable World
w: www.petalogix.com p: +61-7-30090663,+42-0-721842854 f: +61-7-30090663


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
