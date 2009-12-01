Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1NFL8S-0007AG-70
	for ltp-list@lists.sourceforge.net; Tue, 01 Dec 2009 05:18:48 +0000
Received: from smtp-gate3.ryobi.co.jp ([210.163.224.134])
	by sfi-mx-3.v28.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1NFL8L-0005Pd-NV
	for ltp-list@lists.sourceforge.net; Tue, 01 Dec 2009 05:18:48 +0000
Received: from 5109496 ([10.113.10.40]) by po.rsoa.ryobi.co.jp
	(Post.Office MTA v4.1.1 release 20090730
	ID# 201-058U1200L1200S0V41J) with ESMTP id jp
	for <ltp-list@lists.sourceforge.net>; Tue, 1 Dec 2009 14:18:27 +0900
From: "Mitani" <mitani@ryobi.co.jp>
Date: Tue, 1 Dec 2009 14:18:26 +0900
Message-ID: <000001ca7245$b829af90$287d0eb0$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: [LTP] build failure with ltp-2009-12-01 cvs
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

I tried to "make" with "ltp-2009-12-01.tar.gz" version.
I tried it in systems as follows:
 (1) kernel 2.6.18-164.el5 - architecture x86 
 (2) kernel 2.6.18-164.el5 - architecture x86_64

But both failed with following message:

------------
[...]
make[3]: Entering directory
`/home/LTP/ltp-2009-12-01/testcases/kernel/containers'
make -C libclone -f
"/home/LTP/ltp-2009-12-01/testcases/kernel/containers/libclone/Makefil
e" all
make[4]: Entering directory
`/home/LTP/ltp-2009-12-01/testcases/kernel/containers/libclone
'
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
-I/home/LTP/ltp-2009-12-01/testcases/k
ernel/include -I../../../../include -I../../../../include  -c -o libclone.o
libclone.c
In file included from libclone.h:31,
                 from libclone.c:17:
/home/LTP/ltp-2009-12-01/testcases/kernel/include/linux_syscall_numbers.h:24
: error: weak
declaration of 'syscall_cleanup_stub' must be public
make[4]: *** [libclone.o] Error 1
make[4]: Leaving directory
`/home/LTP/ltp-2009-12-01/testcases/kernel/containers/libclone'
make[3]: *** [libclone/libclone.a] Error 2
make[3]: Leaving directory
`/home/LTP/ltp-2009-12-01/testcases/kernel/containers'
make[2]: *** [all] Error 2
make[2]: Leaving directory `/home/LTP/ltp-2009-12-01/testcases/kernel'
make[1]: *** [all] Error 2
make[1]: Leaving directory `/home/LTP/ltp-2009-12-01/testcases'
make: *** [testcases-all] Error 2
------------


I tried to avoid this failure by revising "${LTPROOT}/testcases
/kernel/include/linux_syscall_numbers.h".

============
--- linux_syscall_numbers.h.org 2009-12-01 09:52:25.000000000 +0900
+++ linux_syscall_numbers.h     2009-12-01 11:37:10.000000000 +0900
@@ -21,7 +21,7 @@
  * result in compile-time errors and folks get the granularity they desire
  * when writing testcases.
  */
-static void syscall_cleanup_stub(void) __attribute__ ((weakref
("cleanup")));
+void syscall_cleanup_stub(void) __attribute__ ((weakref ("cleanup")));

 static void cleanup(void);

============

After applying this patch, "make" and "make install" succeeded in
both (1) and (2) systems.


Can I get some advice whether my revise above is right?


Thank you--

-Tomonori Mitani



------------------------------------------------------------------------------
Join us December 9, 2009 for the Red Hat Virtual Experience,
a free event focused on virtualization and cloud computing. 
Attend in-depth sessions from your desk. Your couch. Anywhere.
http://p.sf.net/sfu/redhat-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
