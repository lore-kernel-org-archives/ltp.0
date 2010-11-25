Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PLhql-0002r9-9Z
	for ltp-list@lists.sourceforge.net; Thu, 25 Nov 2010 19:51:23 +0000
Received: from mail-ww0-f53.google.com ([74.125.82.53])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PLhqk-0001n1-5g
	for ltp-list@lists.sourceforge.net; Thu, 25 Nov 2010 19:51:23 +0000
Received: by wwb39 with SMTP id 39so4515wwb.10
	for <ltp-list@lists.sourceforge.net>;
	Thu, 25 Nov 2010 11:51:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1163307688.229311290511451623.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
References: <197804608.229291290511437013.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<1163307688.229311290511451623.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Date: Thu, 25 Nov 2010 11:51:15 -0800
Message-ID: <AANLkTin0d_pskgoJ7otHc-nsYcYsT6ZJocNS83t38u6F@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] mbind_range() vma merge
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: caiqian@redhat.com
Cc: ltp-list <ltp-list@lists.sourceforge.net>

    Comments are prefixed by gcooper>.
Thanks,
-Garrett

Please do an inline and patch submit next time. Patch reviewing that
isn't inline in the email body is a bit annoying...

On Tue, Nov 23, 2010 at 3:24 AM,  <caiqian@redhat.com> wrote:
> This is a reproducer from mainline commit
> 9d8cebd4bcd7c3878462fdfda34bbcdeb4df7ef4:
>
> "Strangely, current mbind() doesn't merge vma with neighbor vma although
> it's possible. =A0Unfortunately, many vma can reduce performance..."

 testcases/kernel/mem/mbind/Makefile  |   25 ++++++
 testcases/kernel/mem/mbind/mbind01.c |  158 ++++++++++++++++++++++++++++++=
++++
 2 files changed, 183 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/mem/mbind/Makefile
 create mode 100644 testcases/kernel/mem/mbind/mbind01.c

diff --git a/testcases/kernel/mem/mbind/Makefile
b/testcases/kernel/mem/mbind/Makefile
new file mode 100644
index 0000000..11aa2f9
--- /dev/null
+++ b/testcases/kernel/mem/mbind/Makefile
@@ -0,0 +1,25 @@
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
+top_srcdir              ?=3D ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
+
+LDLIBS 			+=3D -lnuma

gcooper> Do $(NUMA_LIBS) instead.

+#include <numaif.h>
+#include <numa.h>
+#include <sys/mman.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <string.h>
+#include "test.h"
+#include "usctest.h"

gcooper> This will cause breakage on systems without proper numa lib
support *cues some RHEL users from Ryobi on the list :)...*

+char *TCID =3D "mbind01";
+int TST_TOTAL =3D 1;
+extern int Tst_count;
+static unsigned long pagesize;
+static int opt_node;
+static char *opt_nodestr;
+
+static option_t options[] =3D {
+	{ "n:", &opt_node,	&opt_nodestr},
+	{ NULL, NULL,		NULL}
+};
+
+static void usage(void);

gcooper> Get rid of this function please (unused).

+int main(int argc, char** argv)
+{
+	FILE *fp;
+	void* addr;
+	int node;
+	struct bitmask *nmask =3D numa_allocate_nodemask();
+	int err;
+	char buf[BUFSIZ];
+	char start[BUFSIZ];
+	char end[BUFSIZ];
+	char string[BUFSIZ];
+	char *p;
+
+	/* message returned from parse_opts */
+	char *msg;
+
+	/* loop counter */
+	int lc;
+
+	msg =3D parse_opts(argc, argv, options, usage);
+	if (msg !=3D NULL) {
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+		tst_exit();
+	}
+	if (opt_node) {
+		node =3D strtol(optarg, NULL, 0);

gcooper> This is wrong. The value that gets passed into node is an
unsigned integer, not a long. Also, what if the value passed in was
invalid (say -1)?

+		numa_bitmask_setbit(nmask, node);
+	} else
+		numa_bitmask_setbit(nmask, 0);
+
+	pagesize =3D getpagesize();
+
+	/* Check looping state if -i option given */
+	for (lc =3D 0; TEST_LOOPING(lc); lc++) {
+		/* Reset Tst_count in case we are looping. */
+		Tst_count =3D 0;
+
+		addr =3D mmap(NULL, pagesize*3, PROT_READ|PROT_WRITE,
+			MAP_ANON|MAP_PRIVATE, 0, 0);
+		if (addr =3D=3D MAP_FAILED)
+			tst_brkm(TBROK|TERRNO, NULL, "mmap"), exit(1);

gcooper> Remove exit(1) please...

+		tst_resm(TINFO, "pid =3D %d", getpid());
+		tst_resm(TINFO, "addr =3D %p", addr);

gcooper> Consolidate to one call please (also, do you _really_ need to
print out the pid info?).

+		/* make page populate */
+		memset(addr, 0, pagesize*3);
+
+		/* first mbind */
+		err =3D mbind(addr+pagesize, pagesize, MPOL_BIND,
+			nmask->maskp, nmask->size, MPOL_MF_MOVE_ALL);
+		if (err)

gcooper> For the sake of correctness this should be -1.

+			tst_brkm(TBROK|TERRNO, NULL, "mbind1");
+
+		/* second mbind */
+		err =3D mbind(addr, pagesize*3, MPOL_DEFAULT, NULL, 0, 0);
+		if (err)

gcooper> Same as above.

+			tst_brkm(TBROK|TERRNO, NULL, "mbind2 ");
+
+		/* /proc/%d/maps in the form of
+		   "00400000-00406000 r-xp 00000000". */
+		sprintf(buf, "/proc/%d/maps", getpid());
+		sprintf(string, "%lx", (long)addr);

gcooper> I know it may seem a bit obtuse, but couldn't do you %p
instead, and increment the pointer to the buffer by 2 to achieve the
same result? The point I'm driving at is that this casting is probably
going to be incorrect in some cases.

+		fp =3D fopen(buf, "r");
+		if (fp =3D=3D NULL)
+			tst_brkm(TBROK|TERRNO, NULL, "fopen");

gcooper> Please describe what file you were trying to open that failed.

+		while (fgets(buf, BUFSIZ, fp) !=3D NULL) {
+			/* Find out the 1st VMA. */
+			p =3D strtok(buf, "-");
+			if (p =3D=3D NULL)
+				continue;
+			=

+			strcpy(start, p);
+			if (strcmp(string, start) !=3D 0)
+				continue;
+
+			/* Get the end range of the 2nd VMA. */
+			p =3D strtok(NULL, " ");

gcooper> What if this token isn't found?

+			strcpy(end, p);
+
+			/* Find out the second VMA. */
+			if (fgets(buf, BUFSIZ, fp) =3D=3D NULL)
+				tst_brkm(TBROK|TERRNO, NULL, "fgets");
+
+			p =3D strtok(buf, "-");
+			if (p =3D=3D NULL || strcmp(p, end) !=3D 0)
+				tst_resm(TPASS, "only 1 VMA.");
+			else
+				tst_resm(TFAIL, "more than 1 VMA.");
+		}
+		if (fclose(fp) =3D=3D EOF)
+			tst_brkm(TWARN|TERRNO, NULL, "fclose");

gcooper> I wouldn't worry about the fclose failing, because this could
invariably turn into noise.

+		if (munmap(addr, pagesize*3) =3D=3D -1)
+			tst_brkm(TWARN|TERRNO, NULL, "munmap");

gcooper> This is correct though.

+	}
+	return 0;
+}
+
+void usage(void)
+{
+	printf("  -n      Number of NUMA nodes\n");
+}

gcooper> Get rid of this function please (unused).

---------------------------------------------------------------------------=
---
Increase Visibility of Your 3D Game App & Earn a Chance To Win $500!
Tap into the largest installed PC base & get more eyes on your game by
optimizing for Intel(R) Graphics Technology. Get started today with the
Intel(R) Software Partner Program. Five $500 cash prizes are up for grabs.
http://p.sf.net/sfu/intelisp-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
