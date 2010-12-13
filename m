Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PS4gG-0006fd-BT
	for ltp-list@lists.sourceforge.net; Mon, 13 Dec 2010 09:26:52 +0000
Received: from mail-ww0-f53.google.com ([74.125.82.53])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PS4gF-0005vS-4C
	for ltp-list@lists.sourceforge.net; Mon, 13 Dec 2010 09:26:52 +0000
Received: by wwi18 with SMTP id 18so5774448wwi.10
	for <ltp-list@lists.sourceforge.net>;
	Mon, 13 Dec 2010 01:26:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <576205689.821211292220129860.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
References: <1520798229.821161292220083283.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<576205689.821211292220129860.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Date: Mon, 13 Dec 2010 01:26:45 -0800
Message-ID: <AANLkTinqt9kk50wM0BVO1agoZ9b3NYaLhWOGfgGkEbc4@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH v1] add a testcase to test
 /proc/sys/vm/nr_hugepages vm tunable
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
To: Zhouping Liu <zliu@redhat.com>
Cc: ltp-list@lists.sourceforge.net

General comments:

1. No runtest entry.
2. If your test requires root, use tst_require_root() from libltp.
3. Use TERRNO liberally if you want to provide a sensible error back
to the user in the event of a libcall or syscall failure with a
predefined error.

More comments inline.

On Sun, Dec 12, 2010 at 10:02 PM, Zhouping Liu <zliu@redhat.com> wrote:
> hi,I'd like to add several testcases to test vm tunable(/proc/sys/vm/*).
> the patch is designed to test nr_hugepages vm tunable, and I will add
> more to test other vm tunables.
>
> Signed-off-by: Zhouping Liu <zliu@redhat.com>
> ---
> =A0testcases/kernel/mem/vmtunabe/Makefile =A0 =A0 =A0 | =A0 31 +++++
> =A0testcases/kernel/mem/vmtunabe/nr_hugepages.c | =A0166 ++++++++++++++++=
++++++++++
> =A02 files changed, 197 insertions(+), 0 deletions(-)
> =A0create mode 100644 testcases/kernel/mem/vmtunabe/Makefile
> =A0create mode 100644 testcases/kernel/mem/vmtunabe/nr_hugepages.c
>
> diff --git a/testcases/kernel/mem/vmtunabe/Makefile b/testcases/kernel/me=
m/vmtunabe/Makefile
> new file mode 100644
> index 0000000..3e7f888
> --- /dev/null
> +++ b/testcases/kernel/mem/vmtunabe/Makefile
> @@ -0,0 +1,31 @@
> +#
> +# Copyright (C) 2010 =A0Red Hat, Inc.
> +#
> +# This program is free software; you can redistribute it and/or
> +# modify it under the terms of version 2 of the GNU General Public
> +# License as published by the Free Software Foundation.
> +#
> +# This program is distributed in the hope that it would be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> +#
> +# Further, this software is distributed without any warranty that it
> +# is free of the rightful claim of any third person regarding
> +# infringement or the like. =A0Any license provided herein, whether
> +# implied or otherwise, applies only to this software file. =A0Patent
> +# licenses, if any, provided herein do not apply to combinations of
> +# this program with other software, or any other product whatsoever.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program; if not, write the Free Software
> +# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> +# 02110-1301, USA.
> +#
> +
> +top_srcdir =A0 =A0 =A0 =A0 =A0 =A0 ?=3D ../../../..
> +
> +include $(top_srcdir)/include/mk/env_pre.mk
> +

gcooper> Delete blank line.

> +include $(top_srcdir)/include/mk/generic_trunk_target.mk

gcooper> Delete above line.

> +include $(top_srcdir)/include/mk/testcases.mk
> diff --git a/testcases/kernel/mem/vmtunabe/nr_hugepages.c b/testcases/ker=
nel/mem/vmtunabe/nr_hugepages.c
> new file mode 100644
> index 0000000..3c139a6
> --- /dev/null
> +++ b/testcases/kernel/mem/vmtunabe/nr_hugepages.c
> @@ -0,0 +1,166 @@
> +/*
> + * vm tunable test
> + *
> + * ********************************************************************
> + * Copyright (C) 2010 Red Hat, Inc.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of version 2 of the GNU General Public
> + * License as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it would be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> + *
> + * Further, this software is distributed without any warranty that it
> + * is free of the rightful claim of any third person regarding
> + * infringement or the like. =A0Any license provided herein, whether
> + * implied or otherwise, applies only to this software file. =A0Patent
> + * licenses, if any, provided herein do not apply to combinations of
> + * this program with other software, or any other product whatsoever.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write the Free Software
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> + * 02110-1301, USA.
> + *
> + * ********************************************************************
> + *
> + * File Name: nr_hugepage.c
> + * Author: Zhouping Liu <zliu@redhat.com>
> + * Description:
> + * The program is designed to test /proc/sys/vm/nr_hugepages.
> + * set the different values to nr_hugepages and watch this operations
> + * work normally. if you set nr_hugepages, you can see this change in
> + * /proc/meminfo: HugePages_Total
> + *
> + */
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <errno.h>
> +#include <unistd.h>
> +#include <fcntl.h>
> +#include <stdint.h>
> +#include <sys/stat.h>
> +#include <sys/mman.h>
> +#include <sys/types.h>
> +
> +#include "test.h"
> +#include "usctest.h"
> +char *TCID=3D"nr_hugepages";
> +#define BUFFER_SIZE 256
> +/* why I set HUGEPAGES 30, I think this value is appropriate,
> + * In general, all the systems can provide about 30 hugepages if they
> + * support hugepage, if you make a much larger value, it will cause
> + * shortage memory.
> + */
> +#define HUGEPAGES 30
> +
> +int TST_TOTAL=3D1;

gcooper> Need spaces between `=3D'.

> +/* set hugepages */
> +int set_hugepages(int nr_hugepages);
> +/* get the total of hugepages and surplus hugepages */
> +int get_hugepages(int *nr_hugepages);
> +
> +/* check whether the /proc/sys/vm/nr_hugepages file exist
> + * if not, then the test can't run continue.
> + * */
> +int check_system();
> +
> +/* make some clean work. */
> +void cleanup();
> +
> +int old_hugepages =3D 0; /* save the old nr_hugepages value */
> +
> +int main(int argc, char *argv[])
> +{
> + =A0 =A0 =A0 int lc =3D 0; /* loop counter */
> + =A0 =A0 =A0 char *msg; /* message returned from parse_opts */
> + =A0 =A0 =A0 int counter =3D 0;
> + =A0 =A0 =A0 int nr =3D 10;
> + =A0 =A0 =A0 int hugepages =3D 0;
> +
> + =A0 =A0 =A0 /* if check_system() return zero,
> + =A0 =A0 =A0 =A0* the system can't support this test.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (!check_system()) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TFAIL, "Can't test nr_hugepages an=
d \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 nr_overcomm=
it_hugepages,no such file");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_exit();

gcooper> Use tst_brkm with TCONF|TERRNO.

> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if ( (msg =3D parse_opts(argc, argv, NULL, NULL)) !=3D NULL=
 ) {

gcooper> Remove spurious spaces in enclosure.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_brkm(TBROK, cleanup, "OPTION PARSING ER=
ROR -%s ", msg);
> + =A0 =A0 =A0 }
> +
> +
> + =A0 =A0 =A0 get_hugepages(&old_hugepages);
> + =A0 =A0 =A0 tst_resm(TINFO, "the old nr_hugepages is %d\n",old_hugepage=
s);
> +
> + =A0 =A0 =A0 for ( lc =3D 0; TEST_LOOPING(lc); lc++ ) {

gcooper> This TEST_LOOPING stuff in all of the tests is garbage. I
don't see why it needs to exist. Delete outer loop and dedent please.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for ( counter =3D 0; counter < nr; counter+=
+ ) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_hugepages(HUGEPAGES + c=
ounter);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TINFO, "set nr_hug=
epages %d",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 HUGEPAGES +=
 counter);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 get_hugepages(&hugepages);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ( hugepages !=3D HUGEPAG=
ES + counter ) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_hugepag=
es(old_hugepages); /* recover the original value */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_brkm(TF=
AIL, cleanup, "nr_hugepages error");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 set_hugepages(old_hugepages); /* recover the primary value =
*/
> + =A0 =A0 =A0 tst_resm(TPASS, "nr_hugepages");
> + =A0 =A0 =A0 cleanup();
> + =A0 =A0 =A0 return 0;
> +}
> +
> +int get_hugepages(int *nr_hugepages)
> +{
> + =A0 =A0 =A0 FILE *f;
> + =A0 =A0 =A0 int retcode =3D 0;
> + =A0 =A0 =A0 char buff[BUFFER_SIZE];

gcooper> Fix alignment.

> + =A0 =A0 =A0 f =3D fopen("/proc/meminfo", "r");
> + =A0 =A0 =A0 if (!f) {

gcooper> Do `f =3D=3D NULL'

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_brkm(TFAIL, cleanup, "Please run the te=
st using root user.");

gcooper> Message is FUD. Fix.

> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 while (fgets(buff,BUFFER_SIZE, f) !=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if((retcode =3D sscanf(buff, "HugePages_Tot=
al: %d ", nr_hugepages)) =3D=3D 1)

gcooper> What if this value wasn't scanned?

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 fclose(f);
> + =A0 =A0 =A0 return 0;
> +}
> +
> +int set_hugepages(int nr_hugepages)
> +{
> + =A0 =A0 =A0 FILE *f ;
> + =A0 =A0 =A0 f =3D fopen("/proc/sys/vm/nr_hugepages","w");
> + =A0 =A0 =A0 if (!f) {

gcooper> Do `f =3D=3D NULL'.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_brkm(TFAIL, NULL, "No permission, using=
 root user.");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_exit();
> + =A0 =A0 =A0 }

gcooper> Message is FUD. Fix.

> + =A0 =A0 =A0 /* write nr_hugepages to /proc/sys/vm/nr_hugepages */
> + =A0 =A0 =A0 fprintf(f, "%d", nr_hugepages);

Don't you care if this was written out?

> + =A0 =A0 =A0 fclose(f);
> + =A0 =A0 =A0 return 0;
> +}
> +
> +int check_system()
> +{
> + =A0 =A0 =A0 int flag =3D -1;
> + =A0 =A0 =A0 flag =3D access("/proc/sys/vm/nr_hugepages",F_OK);

gcooper> Missing space between comma and constant.

> + =A0 =A0 =A0 if (flag =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 }
> +}
> +
> +void cleanup(void)
> +{
> + =A0 =A0 =A0 set_hugepages(old_hugepages);
> + =A0 =A0 =A0 tst_exit();
> +}

---------------------------------------------------------------------------=
---
Oracle to DB2 Conversion Guide: Learn learn about native support for PL/SQL,
new data types, scalar functions, improved concurrency, built-in packages, =

OCI, SQL*Plus, data movement tools, best practices and more.
http://p.sf.net/sfu/oracle-sfdev2dev =

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
