Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <czhang@redhat.com>) id 1NIYVy-000256-F7
	for ltp-list@lists.sourceforge.net; Thu, 10 Dec 2009 02:12:22 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NIYVq-0004LZ-HN
	for ltp-list@lists.sourceforge.net; Thu, 10 Dec 2009 02:12:22 +0000
Received: from int-mx03.intmail.prod.int.phx2.redhat.com
	(int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id nBA2C8gp022442
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 9 Dec 2009 21:12:08 -0500
Received: from mail04.corp.redhat.com (zmail04.collab.prod.int.phx2.redhat.com
	[10.5.5.44])
	by int-mx03.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP
	id nBA2C8mJ017262
	for <ltp-list@lists.sourceforge.net>; Wed, 9 Dec 2009 21:12:08 -0500
Date: Wed, 9 Dec 2009 21:12:07 -0500 (EST)
From: Caspar Zhang <czhang@redhat.com>
Message-ID: <1515718228.139261260411127991.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1035224881.139201260410991274.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_5639_1217896255.1260411127990"
Subject: [LTP] [PATCH]fix compile error on ppc64 in RHEL5
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

------=_Part_5639_1217896255.1260411127990
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi all,
=20
When I compile ltp-full-20091130 on ppc64 machine which system is
RHEL5(kernel 2.6.18), I met compile error as follows:

[...]
ptrace04.c: In function =E2=80=98compare_registers=E2=80=99:
ptrace04.c:59: error: =E2=80=98PTRACE_GETREGS=E2=80=99 undeclared (first us=
e in this function)
ptrace04.c:59: error: (Each undeclared identifier is reported only once
ptrace04.c:59: error: for each function it appears in.)
make[5]: *** [ptrace04] Error 1
[...]

It seems like there's no PTRACE_GETREGS in /usr/include/asm/ptrace.h
in old kernels, so I copy the definitions from new version of the
head file and my ltp on ppc64, RHEL5 works.

Thanks,
Caspar
------=_Part_5639_1217896255.1260411127990
Content-Type: application/octet-stream;
	name=rhel5-ppc-PTRACE_GETREGS-compile-err.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=rhel5-ppc-PTRACE_GETREGS-compile-err.patch

diff --git a/testcases/kernel/syscalls/ptrace/ptrace.h b/testcases/kernel/syscalls/ptrace/ptrace.h
index a0d2708..e3fcbb2 100644
--- a/testcases/kernel/syscalls/ptrace/ptrace.h
+++ b/testcases/kernel/syscalls/ptrace/ptrace.h
@@ -37,4 +37,27 @@ typedef struct user_regs_struct ptrace_regs;
 #undef HAVE_STRUCT_PTRACE_REGS
 #endif
 
+/* old kernel doesn't have PTRACE_GETREGS on ppc64 */
+/* (new) PTRACE requests using the same numbers as x86 and the same
+ * argument ordering. Additionally, they support more registers too
+ */
+#ifndef PTRACE_GETREGS
+# define PTRACE_GETREGS            12
+#endif
+#ifndef PTRACE_SETREGS
+# define PTRACE_SETREGS            13
+#endif
+#ifndef PTRACE_GETFPREGS
+# define PTRACE_GETFPREGS          14
+#endif
+#ifndef PTRACE_SETFPREGS
+# define PTRACE_SETFPREGS          15
+#endif
+#ifndef PTRACE_GETREGS64
+# define PTRACE_GETREGS64          22
+#endif
+#ifndef PTRACE_SETREGS64
+# define PTRACE_SETREGS64          23
+#endif
+
 #endif

------=_Part_5639_1217896255.1260411127990
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Return on Information:
Google Enterprise Search pays you back
Get the facts.
http://p.sf.net/sfu/google-dev2dev

------=_Part_5639_1217896255.1260411127990
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_5639_1217896255.1260411127990--

