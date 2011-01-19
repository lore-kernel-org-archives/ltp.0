Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PfTnN-000543-2Y
	for ltp-list@lists.sourceforge.net; Wed, 19 Jan 2011 08:53:37 +0000
Received: from mail-ww0-f53.google.com ([74.125.82.53])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.72) id 1PfTnL-0004H5-W6
	for ltp-list@lists.sourceforge.net; Wed, 19 Jan 2011 08:53:37 +0000
Received: by wwi18 with SMTP id 18so591152wwi.10
	for <ltp-list@lists.sourceforge.net>;
	Wed, 19 Jan 2011 00:53:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1169511902.56392.1295425114163.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
References: <2045541013.56386.1295425108264.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<1169511902.56392.1295425114163.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Date: Wed, 19 Jan 2011 00:53:29 -0800
Message-ID: <AANLkTikpDFh3yoWuwrkCbfJGCn5TZZnKiBKZL7O29=0M@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH 3/4] ksm04: KSM for Memory Resource Controller and
	NUMA
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
To: CAI Qian <caiqian@redhat.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

On Wed, Jan 19, 2011 at 12:18 AM, CAI Qian <caiqian@redhat.com> wrote:
> Signed-off-by: CAI Qian <caiqian@redhat.com>
> ---
> =A0testcases/kernel/mem/ksm/ksm04.c | =A0141 ++++++++++++++++++++++++++++=
++++++++++
> =A01 files changed, 141 insertions(+), 0 deletions(-)
> =A0create mode 100644 testcases/kernel/mem/ksm/ksm04.c
>
> diff --git a/testcases/kernel/mem/ksm/ksm04.c b/testcases/kernel/mem/ksm/=
ksm04.c
> new file mode 100644
> index 0000000..8bb791e
> --- /dev/null
> +++ b/testcases/kernel/mem/ksm/ksm04.c
> @@ -0,0 +1,141 @@
> +/*
> + * Kernel Samepage Merging (KSM) for Memory Resource Controller and NUMA
> + *
> + * Basic tests were to start several programs with same and different
> + * memory contents and ensure only to merge the ones with the same
> + * contents. When changed the content of one of merged pages in a
> + * process and to the mode "unmerging", it should discard all merged
> + * pages there. Also tested it is possible to disable KSM. There are
> + * also command-line options to specify the memory allocation size, and
> + * number of processes have same memory contents so it is possible to
> + * test more advanced things like KSM + OOM etc.
> + *
> + * Prerequisites:
> + *
> + * 1) ksm and ksmtuned daemons need to be disabled. Otherwise, it could
> + * =A0 =A0distrub the testing as they also change some ksm tunables depe=
nds
> + * =A0 =A0on current workloads.
> + *
> + * The test steps are:
> + * - Check ksm feature and backup current run setting.
> + * - Change run setting to 1 - merging.
> + * - 3 memory allocation programs have the memory contents that 2 of
> + * =A0 them are all 'a' and one is all 'b'.
> + * - Check ksm statistics and verify the content.
> + * - 1 program changes the memory content from all 'a' to all 'b'.
> + * - Check ksm statistics and verify the content.
> + * - All programs change the memory content to all 'd'.
> + * - Check ksm statistics and verify the content.
> + * - Change one page of a process.
> + * - Check ksm statistics and verify the content.
> + * - Change run setting to 2 - unmerging.
> + * - Check ksm statistics and verify the content.
> + * - Change run setting to 0 - stop.
> + *
> + * Copyright (C) 2010 =A0Red Hat, Inc.
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
> + */
> +#include "test.h"
> +#include "usctest.h"
> +#include "config.h"
> +
> +char *TCID =3D "ksm04";
> +int TST_TOTAL =3D 1;
> +
> +#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
> + =A0 =A0 =A0 && HAVE_MPOL_CONSTANTS
> +#include <sys/stat.h>
> +#include <sys/types.h>
> +#include <fcntl.h>
> +#include <signal.h>
> +#include <unistd.h>
> +#include <stdio.h>
> +#include <errno.h>
> +#include <numaif.h>
> +#include "../include/mem.h"
> +
> +option_t ksm_options[] =3D {
> + =A0 =A0 =A0 =A0{ "n:", &opt_num, =A0 =A0 =A0 &opt_numstr},
> + =A0 =A0 =A0 =A0{ "s:", &opt_size, =A0 =A0 =A0&opt_sizestr},
> + =A0 =A0 =A0 =A0{ "u:", &opt_unit, =A0 =A0 =A0&opt_unitstr},
> + =A0 =A0 =A0 =A0{ NULL, NULL, =A0 =A0 =A0 =A0 =A0 NULL}
> +};
> +
> +int main(int argc, char *argv[])
> +{
> + =A0 =A0 =A0 int lc;
> + =A0 =A0 =A0 char *msg;
> + =A0 =A0 =A0 int size =3D 128, num =3D 3, unit =3D 1;
> + =A0 =A0 =A0 unsigned long nnodes =3D 1;
> + =A0 =A0 =A0 unsigned long nmask =3D 2;
> +
> + =A0 =A0 =A0 msg =3D parse_opts(argc, argv, ksm_options, ksm_usage);
> + =A0 =A0 =A0 if (msg !=3D NULL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_brkm(TBROK, NULL, "OPTION PARSING ERROR=
 - %s", msg);
> +
> + =A0 =A0 =A0 nnodes =3D count_numa();
> + =A0 =A0 =A0 if (count_numa() =3D=3D 1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_brkm(TCONF, NULL, "required a NUMA syst=
em.");
> +
> + =A0 =A0 =A0 setup();
> +
> + =A0 =A0 =A0 for (lc =3D 0; TEST_LOOPING(lc); lc++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 Tst_count =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 check_ksm_options(&size, &num, &unit);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 write_memcg();
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (set_mempolicy(MPOL_BIND, &nmask, MAXNOD=
ES) =3D=3D -1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_brkm(TBROK|TERRNO, clea=
nup, "set_mempolicy");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 create_same_memory(size, num, unit);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 write_cpusets();
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 create_same_memory(size, num, unit);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 cleanup();
> + =A0 =A0 =A0 tst_exit();
> +}
> +
> +void cleanup(void)
> +{
> + =A0 =A0 =A0 umount_mem(CPATH, CPATH_NEW);
> + =A0 =A0 =A0 umount_mem(MEMCG_PATH, MEMCG_PATH_NEW);
> + =A0 =A0 =A0 TEST_CLEANUP;
> +}
> +
> +void setup(void)
> +{
> + =A0 =A0 =A0 tst_require_root(NULL);
> +
> + =A0 =A0 =A0 tst_sig(FORK, DEF_HANDLER, cleanup);
> + =A0 =A0 =A0 TEST_PAUSE;
> + =A0 =A0 =A0 mount_mem("cpuset", "cpuset", NULL, CPATH, CPATH_NEW);
> + =A0 =A0 =A0 mount_mem("memcg", "cgroup", "memory", MEMCG_PATH, MEMCG_PA=
TH_NEW);
> +}
> +
> +#else /* no NUMA */
> +int main(void)
> +{
> + =A0 =A0 =A0 tst_resm(TCONF, "no NUMA development packages installed.");
> + =A0 =A0 =A0 tst_exit();
> +}
> +#endif

Commit pending.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Protect Your Site and Customers from Malware Attacks
Learn about various malware tactics and how to avoid them. Understand =

malware threats, the impact they can have on your business, and how you =

can protect your company and customers by using code signing.
http://p.sf.net/sfu/oracle-sfdevnl
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
