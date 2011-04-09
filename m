Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <phan@redhat.com>) id 1Q8Oj0-0002jV-Ve
	for ltp-list@lists.sourceforge.net; Sat, 09 Apr 2011 03:20:38 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1Q8Oiz-0007RD-Jk
	for ltp-list@lists.sourceforge.net; Sat, 09 Apr 2011 03:20:38 +0000
Date: Sat, 9 Apr 2011 11:23:25 +0800
From: Han Pingtian <phan@redhat.com>
Message-ID: <20110409032325.GA2578@epc900.nay.redhat.com>
References: <20110225103620.GA10350@hpt.nay.redhat.com>
	<BANLkTimC1VXcu1DTfR+nOK5sx5vvKguZkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
In-Reply-To: <BANLkTimC1VXcu1DTfR+nOK5sx5vvKguZkQ@mail.gmail.com>
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


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx1.redhat.com id
	p393KUI2009926

I have updated the patch based on your suggestions. Please review.

Thanks.

Han Pingtian
On Wed, Apr 06, 2011 at 11:57:51PM -0700, Garrett Cooper wrote:
> I'm going to be more anal retentive with this review than I was previou=
sly.
>=20
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
> >
> > So I recommend to run it as 'thp01 -I xxx'.
> > +static option_t options[] =3D {
> > + =A0 =A0 =A0 {NULL, NULL, NULL}
> > +};
> > +
> > +static void usage(void)
> > +{
> > + =A0 =A0return;
> > +}
> > +
> > +int main(int argc, char **argv) {
> > + =A0 =A0 =A0 int i, lc, st;
> > + =A0 =A0 =A0 pid_t pid;
> > + =A0 =A0 =A0 char *msg;
> > + =A0 =A0 =A0 char *c[257];
> > + =A0 =A0 =A0 char cc[32*4096];
> > + =A0 =A0 =A0 struct rlimit rl =3D {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .rlim_cur =3DRLIM_INFINITY,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .rlim_max=3DRLIM_INFINITY,
> > + =A0 =A0 =A0 };
> > +
> > + =A0 =A0 =A0 msg =3D parse_opts(argc, argv, options, usage);
> > + =A0 =A0 =A0 if (msg !=3D NULL)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_brkm(TBROK, NULL, "OPTION PARSING E=
RROR - %s", msg);
> > +
> > + =A0 =A0 =A0 for (lc =3D 0; TEST_LOOPING(lc); lc++) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 switch (pid =3D fork()) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 case -1:
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_brk=
m(TBROK|TERRNO, NULL, "fork");
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 0:
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 memset(=
cc, 'c', 32*4096-1);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i=3D=
0;i<256;i++)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 c[i] =3D cc;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (set=
rlimit(RLIMIT_STACK, &rl) =3D=3D -1)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 tst_brkm(TBROK|TERRNO, NULL, "setrlimit");
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (exe=
cve("/bin/true", c, c) =3D=3D -1)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 tst_brkm(TBROK|TERRNO, NULL, "execve");
>=20
> I would just do perror("execve"), etc, because this is a child process
> and according to the style guide you shouldn't use tst_resm in child
> processes (I recommended that in the style guide for a very good
> reason that you should understand).
>=20
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 default:
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (wai=
tpid(pid, &st, 0) =3D=3D -1)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 tst_brkm(TBROK|TERRNO, NULL, "waitpid");
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (! W=
IFEXITED(st))
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 tst_brkm(TBROK, NULL, "child exit status is %d", WEXITSTATUS(st)=
);
>=20
> I agree with what Cyril said before about whitespace.
>=20
> ...
>=20
> -Garrett
>=20
> -----------------------------------------------------------------------=
-------
> Xperia(TM) PLAY
> It's a major breakthrough. An authentic gaming
> smartphone on the nation's most reliable network.
> And it wants your games.
> http://p.sf.net/sfu/verizon-sfdev
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-thp-testcase-come-from-CVE-reproducer.patch"

From 0e226273edd93e50afdf5d698bfc000cc9823a8c Mon Sep 17 00:00:00 2001
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
 testcases/kernel/mem/thp/Makefile |   23 ++++++++
 testcases/kernel/mem/thp/thp01.c  |  102 +++++++++++++++++++++++++++++++++++++
 3 files changed, 127 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/mem/thp/Makefile
 create mode 100644 testcases/kernel/mem/thp/thp01.c

diff --git a/runtest/mm b/runtest/mm
index f2d50d6..dded529 100644
--- a/runtest/mm
+++ b/runtest/mm
@@ -78,3 +78,5 @@ oom01 oom01
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
index 0000000..4c94031
--- /dev/null
+++ b/testcases/kernel/mem/thp/thp01.c
@@ -0,0 +1,102 @@
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
+int main(int argc, char **argv)
+{
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
+				cc[32*4096-1] = '\0';
+
+				for (i=0;i<256;i++)
+					c[i] = cc;
+				if (setrlimit(RLIMIT_STACK, &rl) == -1) {
+					perror("setrlimit");
+					exit(1);
+				}
+				if (execve("/bin/true", c, c) == -1) {
+					perror("execve");
+					exit(2);
+				}
+			default:
+				if (waitpid(pid, &st, 0) == -1)
+					tst_brkm(TBROK|TERRNO, NULL, "waitpid");
+
+				if (!WIFEXITED(st))
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
1.7.4.2


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Xperia(TM) PLAY
It's a major breakthrough. An authentic gaming
smartphone on the nation's most reliable network.
And it wants your games.
http://p.sf.net/sfu/verizon-sfdev
--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--J2SCkAp4GZ/dPZZf--

