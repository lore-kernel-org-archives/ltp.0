Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <phan@redhat.com>) id 1PwUoD-0006iR-2c
	for ltp-list@lists.sourceforge.net; Mon, 07 Mar 2011 07:24:49 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1PwUoB-00048g-TB
	for ltp-list@lists.sourceforge.net; Mon, 07 Mar 2011 07:24:48 +0000
Date: Mon, 7 Mar 2011 15:29:01 +0800
From: Han Pingtian <phan@redhat.com>
Message-ID: <20110307072901.GB2877@hpt.nay.redhat.com>
References: <20110225103620.GA10350@hpt.nay.redhat.com>
	<AANLkTi=_K2Q1iYtN0T6izFmnmeEe1Tyyst1CzRHiN+Yg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
In-Reply-To: <AANLkTi=_K2Q1iYtN0T6izFmnmeEe1Tyyst1CzRHiN+Yg@mail.gmail.com>
Subject: Re: [LTP] [PATCH] thp testcase come from CVE reproducer
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx1.redhat.com id
	p277OfFT026312

On Fri, Mar 04, 2011 at 02:38:51AM -0800, Garrett Cooper wrote:
> On Fri, Feb 25, 2011 at 2:36 AM, Han Pingtian <phan@redhat.com> wrote:
> > This is a reproducer of =A0CVE-2011-0999, which fixed by mainline com=
mit
> > a7d6e4ecdb7648478ddec76d30d87d03d6e22b31:
> >
> > "Transparent hugepages can only be created if rmap is fully
> > functional. So we must prevent hugepages to be created while
> > is_vma_temporary_stack() is true."
> >
> > When running in a loop, it can trigger panic like this, if kernel
> > unpatched:
> >
> > kernel BUG at mm/huge_memory.c:1260!
> > invalid opcode: 0000 [#1] SMP
> > last sysfs file: /sys/devices/system/cpu/cpu23/cache/index2/shared_cp=
u_map
>=20
> ...
>=20
> > +static option_t options[] =3D {
> > + =A0 =A0 =A0 {NULL, NULL, NULL}
> > +};
> > +
> > +static void usage(void)
> > +{
> > + =A0 =A0return;
> > +}
>=20
> You can delete this if you do what I suggest below...
>=20
> ...
>=20
> > + =A0 =A0 =A0 msg =3D parse_opts(argc, argv, options, usage);
> > + =A0 =A0 =A0 if (msg !=3D NULL)
>=20
> `if ((msg =3D parse_opts(argc, argv, NULL, NULL)) !=3D NULL)' is prefer=
red.
Thanks. I have updated this according to your suggestion.
>=20
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (exe=
cve("/bin/true", c, c) =3D=3D -1)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 tst_brkm(TBROK|TERRNO, NULL, "execve");
>=20
> Not all systems have /bin/true. It would be better to do:
>=20
> /bin/sh -c ':'
>=20
> etc, as we have code that depends on this type of shell-required POSIX =
behavior.
>=20
I'm sorry for I cannot figure out how to do this way. I tried, but
cannot crash unpatched kernel anymore. So I think the simple workaround
is checking if /bin/true installed in the program:

+
+                               if (WEXITSTATUS(st) =3D=3D 2)
+                                       tst_brkm(TBROK, NULL, "Do you hav=
e /bin/true installed?");
+

Please review the updated version.
> Thanks,
> -Garrett

--=20
Han Pingtian
Quality Engineer
hpt @ #kernel-qe
Red Hat, Inc
Freedom ... courage ... Commitment ... ACCOUNTABILITY

--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-thp-testcase-come-from-CVE-reproducer.patch"

From 38c3526fdb59c0b18015914745f2d43fc6c6b1a3 Mon Sep 17 00:00:00 2001
From: Han Pingtian <phan@redhat.com>
Date: Fri, 25 Feb 2011 17:51:24 +0800
Subject: [PATCH] thp testcase come from CVE reproducer

This is a reproducer of  CVE-2011-0999, which fixed by mainline commit
a7d6e4ecdb7648478ddec76d30d87d03d6e22b31:

"Transparent hugepages can only be created if rmap is fully
functional. So we must prevent hugepages to be created while
is_vma_temporary_stack() is true."

When running in a loop, it can trigger panic like this, if kernel
unpatched:

kernel BUG at mm/huge_memory.c:1260!
invalid opcode: 0000 [#1] SMP
last sysfs file: /sys/devices/system/cpu/cpu23/cache/index2/shared_cpu_map
....

So I recommend to run it as 'thp01 -I xxx'.

Signed-off-by: Han Pingtian <phan@redhat.com>
---
 runtest/mm                        |    2 +
 testcases/kernel/mem/thp/Makefile |   23 +++++++++
 testcases/kernel/mem/thp/thp01.c  |   95 +++++++++++++++++++++++++++++++++++++
 3 files changed, 120 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/mem/thp/Makefile
 create mode 100644 testcases/kernel/mem/thp/thp01.c

diff --git a/runtest/mm b/runtest/mm
index 1296e59..51cc82d 100644
--- a/runtest/mm
+++ b/runtest/mm
@@ -85,3 +85,5 @@ oom01 oom01
 oom02 oom02
 oom03 oom03
 oom04 oom04
+
+thp01 thp01 -I 600
diff --git a/testcases/kernel/mem/thp/Makefile b/testcases/kernel/mem/thp/Makefile
new file mode 100644
index 0000000..dbfbc1b
--- /dev/null
+++ b/testcases/kernel/mem/thp/Makefile
@@ -0,0 +1,23 @@
+#
+#  Copyright (C) 2010  Red Hat, Inc.
+#
+#  This program is free software; you can redistribute it and/or modify
+#  it under the terms of the GNU General Public License as published by
+#  the Free Software Foundation; either version 2 of the License, or (at
+#  your option) any later version.
+#
+#  This program is distributed in the hope that it will be useful, but
+#  WITHOUT ANY WARRANTY; without even the implied warranty of
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+#  General Public License for more details.
+#
+#  You should have received a copy of the GNU General Public License
+#  along with this program; if not, write to the Free Software
+#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+#  02110-1301, USA.
+#
+
+top_srcdir              ?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/mem/thp/thp01.c b/testcases/kernel/mem/thp/thp01.c
new file mode 100644
index 0000000..0b6ec1a
--- /dev/null
+++ b/testcases/kernel/mem/thp/thp01.c
@@ -0,0 +1,95 @@
+/*
+ * This is a reproducer of  CVE-2011-0999, which fixed by mainline commit
+ * a7d6e4ecdb7648478ddec76d30d87d03d6e22b31:
+ *
+ * "Transparent hugepages can only be created if rmap is fully
+ * functional. So we must prevent hugepages to be created while
+ * is_vma_temporary_stack() is true."
+ *
+ * It will cause a panic something like this, if the patch didn't get applied:
+ *
+ * kernel BUG at mm/huge_memory.c:1260!
+ * invalid opcode: 0000 [#1] SMP
+ * last sysfs file: /sys/devices/system/cpu/cpu23/cache/index2/shared_cpu_map
+ * ....
+ *
+ * Copyright (C) 2010  Red Hat, Inc.
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * Further, this software is distributed without any warranty that it
+ * is free of the rightful claim of any third person regarding
+ * infringement or the like.  Any license provided herein, whether
+ * implied or otherwise, applies only to this software file.  Patent
+ * licenses, if any, provided herein do not apply to combinations of
+ * this program with other software, or any other product whatsoever.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+ * 02110-1301, USA.
+ */
+#include "test.h"
+#include "usctest.h"
+#include "config.h"
+
+char *TCID = "thp01";
+int TST_TOTAL = 1;
+
+#include <stdio.h>
+#include <unistd.h>
+#include <string.h>
+#include <sys/resource.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+
+int main(int argc, char **argv) {
+	int i, lc, st;
+	pid_t pid;
+	char *msg;
+	char *c[257];
+	char cc[32*4096];
+	struct rlimit rl = {
+		.rlim_cur = RLIM_INFINITY,
+		.rlim_max = RLIM_INFINITY,
+	};
+
+	if ((msg = parse_opts(argc, argv, NULL, NULL)) != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		switch (pid = fork()) {
+			case -1:
+				tst_brkm(TBROK|TERRNO, NULL, "fork");
+			case 0:
+				memset(cc, 'c', 32*4096-1);
+				for (i=0;i<256;i++)
+					c[i] = cc;
+				if (setrlimit(RLIMIT_STACK, &rl) == -1)
+					tst_brkm(TBROK|TERRNO, NULL, "setrlimit");
+				if (execve("/bin/true", c, c) == -1)
+					tst_brkm(TBROK|TERRNO, NULL, "execve");
+			default:
+				if (waitpid(pid, &st, 0) == -1)
+					tst_brkm(TBROK|TERRNO, NULL, "waitpid");
+
+				if (! WIFEXITED(st))
+					tst_brkm(TBROK, NULL, "child exits abnormally");
+
+				if (WEXITSTATUS(st) == 2)
+					tst_brkm(TBROK, NULL, "Do you have /bin/true installed?");
+
+				if (WEXITSTATUS(st) != 0)
+					tst_brkm(TBROK, NULL, "chaild exits with non-zero value");
+
+				tst_resm(TPASS, "thp01 pass");
+		}
+	}
+
+        tst_exit();
+}
-- 
1.7.1


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
What You Don't Know About Data Connectivity CAN Hurt You
This paper provides an overview of data connectivity, details
its effect on application quality, and explores various alternative
solutions. http://p.sf.net/sfu/progress-d2d
--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--sm4nu43k4a2Rpi4c--

