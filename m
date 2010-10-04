Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1P2lJy-0005UW-VN
	for ltp-list@lists.sourceforge.net; Mon, 04 Oct 2010 13:43:14 +0000
Received: from mail-gy0-f174.google.com ([209.85.160.174])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1P2lJx-0007fF-Ru
	for ltp-list@lists.sourceforge.net; Mon, 04 Oct 2010 13:43:14 +0000
MIME-Version: 1.0
In-Reply-To: <20100929135647.GA4587@hallyn.com>
References: <20100929135647.GA4587@hallyn.com>
Date: Mon, 4 Oct 2010 06:43:08 -0700
Message-ID: <AANLkTikGmyHTu8ncUROKraoSffkbHqeNOAe7U3nAkU65@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] securebits: add secure_keepcaps testcases
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
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: ltp-list@lists.sf.net, Subrata Modak1 <subrata.modak@in.ibm.com>

Hi Serge,
    Some comments about your provided code.
Thanks!
-Garrett

On Wed, Sep 29, 2010 at 6:56 AM, Serge E. Hallyn <serge@hallyn.com> wrote:
> This adds basic tests of the keepcaps securebits settings.
>
> Lots more securebits tests to come (see my email from one
> or 1.5 years ago, and, heck, write them if you have time :).
>
> Signed-off-by: Serge E. Hallyn <serge.hallyn@canonical.com>
> ---
> =A0m4/ltp-securebits.m4 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 | =A0 24 +++
> =A0runtest/securebits =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 | =A0 =A02 +
> =A0testcases/kernel/security/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =
=A0 =A05 +-
> =A0testcases/kernel/security/securebits/Makefile =A0 =A0 =A0| =A0 28 ++++
> =A0.../kernel/security/securebits/check_keepcaps.c =A0 =A0| =A0161 ++++++=
++++++++++++++
> =A0.../kernel/security/securebits/run_securebits.sh =A0 | =A0 20 +++
> =A06 files changed, 239 insertions(+), 1 deletions(-)
> =A0create mode 100644 m4/ltp-securebits.m4
> =A0create mode 100644 runtest/securebits
> =A0create mode 100644 testcases/kernel/security/securebits/Makefile
> =A0create mode 100644 testcases/kernel/security/securebits/check_keepcaps=
.c
> =A0create mode 100644 testcases/kernel/security/securebits/run_securebits=
.sh
>
> diff --git a/m4/ltp-securebits.m4 b/m4/ltp-securebits.m4
> new file mode 100644
> index 0000000..6407eb8
> --- /dev/null
> +++ b/m4/ltp-securebits.m4
> @@ -0,0 +1,24 @@
> +dnl
> +dnl Copyright (c) Serge Hallyn (2010)
> +dnl
> +dnl This program is free software; =A0you can redistribute it and/or mod=
ify
> +dnl it under the terms of the GNU General Public License as published by
> +dnl the Free Software Foundation; either version 2 of the License, or
> +dnl (at your option) any later version.
> +dnl
> +dnl This program is distributed in the hope that it will be useful,
> +dnl but WITHOUT ANY WARRANTY; =A0without even the implied warranty of
> +dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See
> +dnl the GNU General Public License for more details.
> +dnl
> +dnl You should have received a copy of the GNU General Public License
> +dnl along with this program; =A0if not, write to the Free Software
> +dnl Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 =
USA
> +dnl
> +
> +
> +AC_DEFUN([LTP_CHECK_SECUREBITS],
> +AC_CHECK_HEADERS(linux/securebits.h,[
> + =A0 =A0 =A0 LTP_SECUREBITS=3Dyes
> +])
> +)

Some checks should probably be added for versioning as well as symbols
that get passed to prctl(2) (I'm not sure if checking for the symbols
that get passed to prctl(2) here is the correct way to go about things
though).

> diff --git a/runtest/securebits b/runtest/securebits
> new file mode 100644
> index 0000000..d78a66f
> --- /dev/null
> +++ b/runtest/securebits
> @@ -0,0 +1,2 @@
> +#DESCRIPTION:securebits tests
> +Securebits =A0 =A0 run_securebits.sh
> diff --git a/testcases/kernel/security/Makefile b/testcases/kernel/securi=
ty/Makefile
> index 52b8d06..a877836 100644
> --- a/testcases/kernel/security/Makefile
> +++ b/testcases/kernel/security/Makefile
> @@ -27,11 +27,14 @@ include =A0 =A0 $(top_srcdir)/include/mk/env_pre.mk
> =A0# For broken compilers and toolchains, like Montavista, that improperl=
y detect
> =A0# system headers when running autoconf -_-... bleh.
> =A0ifeq ($(strip $(CAP_LIBS)),)
> -FILTER_OUT_DIRS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0:=3D cap_bound filecaps
> +FILTER_OUT_DIRS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0:=3D cap_bound filecaps s=
ecurebits
> =A0endif
> =A0ifeq ($(HAVE_SETCAP),false)
> =A0FILTER_OUT_DIRS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D filecaps
> =A0endif
> +ifeq ($(LTP_SECUREBITS),false)
> +FILTER_OUT_DIRS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D securebits
> +endif
>
> =A0# XXX (garrcoop): avoid compilation failures on RHEL 5.4, as reported =
by
> =A0# Mitani-san, because of policy versioning issues...
> diff --git a/testcases/kernel/security/securebits/Makefile b/testcases/ke=
rnel/security/securebits/Makefile
> new file mode 100644
> index 0000000..a76f2e0
> --- /dev/null
> +++ b/testcases/kernel/security/securebits/Makefile
> @@ -0,0 +1,28 @@
> +########################################################################=
########
> +## =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0##
> +## Copyright (c) International Business Machines =A0Corp., 2009 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 ##
> +## =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0##
> +## This program is free software; =A0you can redistribute it and#or modi=
fy =A0 =A0 =A0##
> +## it under the terms of the GNU General Public License as published by =
=A0 =A0 =A0 ##
> +## the Free Software Foundation; either version 2 of the License, or =A0=
 =A0 =A0 =A0 =A0## ## (at your option) any later version. =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0##
> +## =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0##
> +## This program is distributed in the hope that it will be useful, but =
=A0 =A0 =A0 =A0##
> +## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTAB=
ILITY ##
> +## or FITNESS FOR A PARTICULAR PURPOSE. =A0See the GNU General Public Li=
cense =A0 ##
> +## for more details. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0##
> +## =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0##
> +## You should have received a copy of the GNU General Public License =A0=
 =A0 =A0 =A0 =A0##
> +## along with this program; =A0if not, write to the Free Software =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 ##
> +## Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 U=
SA =A0 =A0##
> +## =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0##
> +########################################################################=
########
> +
> +top_srcdir =A0 =A0 =A0 =A0 =A0 =A0 ?=3D ../../../..
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +
> +LDLIBS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D $(CAP_LIBS)
> +
> +INSTALL_TARGETS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0:=3D *.sh
> +
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/security/securebits/check_keepcaps.c b/test=
cases/kernel/security/securebits/check_keepcaps.c
> new file mode 100644
> index 0000000..e969ae4
> --- /dev/null
> +++ b/testcases/kernel/security/securebits/check_keepcaps.c
> @@ -0,0 +1,161 @@
> +#include <errno.h>
> +#include "config.h"
> +#if HAVE_SYS_CAPABILITY_H
> +#include <sys/capability.h>
> +#endif
> +#include <sys/prctl.h>
> +#include <linux/securebits.h>
> +#include <test.h>
> +
> +int errno;
> +
> +/* Tests:
> + =A0 =A0 =A0 1. drop capabilities at setuid if KEEPCAPS is not set and
> + =A0 =A0 =A0 =A0 =A0new user is nonroot
> + =A0 =A0 =A0 2. keep capabilities if set and new user is nonroot
> + =A0 =A0 =A0 =A0 =A0a. do with prctl(PR_SET_KEEPCAPS)
> + =A0 =A0 =A0 =A0 =A0(call this test 2)
> + =A0 =A0 =A0 =A0 =A0b. do with prctl(PR_SET_SECUREBITS, SECURE_KEEP_CAPS)
> + =A0 =A0 =A0 =A0 =A0(call this test 3)
> + =A0 TODO: test that exec clears KEEPCAPS
> + =A0 =A0 =A0 (just create a simple executable that checks PR_GET_KEEPCAPS
> + =A0 =A0 =A0 =A0results, and execute that as test 4 after doing PR_SET_K=
EEPCAPS).
> + =A0 TODO: all of the other securebits tests.
> + */
> +
> +char *TCID =3D "keepcaps";
> +int TST_TOTAL=3D1;
> +
> +#ifdef HAVE_LIBCAP
> +static int eff_caps_empty(cap_t c)
> +{
> + =A0 =A0 =A0 int i, ret, v, empty=3D1;
> +
> + =A0 =A0 =A0 for (i =3D 0; i < CAP_LAST_CAP; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D cap_get_flag(c, i, CAP_PERMITTED, &=
v);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret || v)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 empty =3D 0;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return empty;
> +}
> +
> +static int am_privileged(void)
> +{
> + =A0 =A0 =A0 int am_privileged =3D 1;
> +
> + =A0 =A0 =A0 cap_t cap =3D cap_get_proc();
> + =A0 =A0 =A0 if (eff_caps_empty(cap))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 am_privileged =3D 0;
> + =A0 =A0 =A0 cap_free(cap);
> +
> + =A0 =A0 =A0 return am_privileged;
> +}
> +#else
> +static int am_privileged(void)
> +{
> + =A0 =A0 =A0 tst_resm(TBROK, "libcap not installed.");
> + =A0 =A0 =A0 tst_exit();
> +}
> +#endif
> +
> +#define EXPECT_NOPRIVS 0
> +#define EXPECT_PRIVS 1
> +static void do_setuid(int expect_privs)
> +{
> + =A0 =A0 =A0 int ret;
> + =A0 =A0 =A0 int have_privs;
> +
> + =A0 =A0 =A0 ret =3D setuid(1000);
> + =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TERRNO | TFAIL, "setuid failed");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_exit();
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 have_privs =3D am_privileged();
> + =A0 =A0 =A0 if (have_privs && expect_privs =3D=3D EXPECT_PRIVS) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TPASS, "kept privs as expected");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_exit();
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (!have_privs && expect_privs =3D=3D EXPECT_PRIVS) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TFAIL, "expected to keep privs but=
 did not");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_exit();
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (!have_privs && expect_privs =3D=3D EXPECT_NOPRIVS) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TPASS, "dropped privs as expected"=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_exit();
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* have_privs && EXPECT_NOPRIVS */
> + =A0 =A0 =A0 tst_resm(TFAIL, "expected to drop privs but did not");
> + =A0 =A0 =A0 tst_exit();
> +}
> +
> +static int am_root(void)
> +{
> + =A0 =A0 =A0 uid_t uid =3D getuid();
> + =A0 =A0 =A0 if (uid !=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 if (!am_privileged())
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 return 1;
> +}
> +
> +int main(int argc, char *argv[])
> +{
> + =A0 =A0 =A0 int ret, whichtest;
> +
> + =A0 =A0 =A0 ret =3D prctl(PR_GET_KEEPCAPS);
> + =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TBROK, "keepcaps was already set?\=
n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_exit();
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (!am_root()) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TBROK, "Run me as root and privile=
ged\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_exit();
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (argc < 2) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TBROK, "Usage: %s <tescase_num>", =
argv[0]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_exit();
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 whichtest =3D atoi(argv[1]);
> + =A0 =A0 =A0 if (whichtest < 1 || whichtest > 3) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TFAIL, "Valid tests are 1-3\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_exit();
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 switch(whichtest) {
> + =A0 =A0 =A0 case 1:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 do_setuid(EXPECT_NOPRIVS); /* does not retu=
rn */
> + =A0 =A0 =A0 case 2:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D prctl(PR_SET_KEEPCAPS, 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret =3D=3D -1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TFAIL|TERRNO, "PR_=
SET_KEEPCAPS failed\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_exit();
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D prctl(PR_GET_KEEPCAPS);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TFAIL|TERRNO, "PR_=
SET_KEEPCAPS did not set keepcaps\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_exit();
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 do_setuid(EXPECT_PRIVS); /* does not return=
 */
> + =A0 =A0 =A0 case 3:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D prctl(PR_GET_SECUREBITS);

What if this call fails?

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D prctl(PR_SET_SECUREBITS, ret | SECB=
IT_KEEP_CAPS);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret =3D=3D -1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TFAIL|TERRNO, "PR_=
SET_SECUREBITS failed\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_exit();
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D prctl(PR_GET_KEEPCAPS);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TFAIL|TERRNO, "PR_=
SET_SECUREBITS did not set keepcaps\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_exit();
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 do_setuid(EXPECT_PRIVS); /* does not return=
 */
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TFAIL, "should not reach here\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_exit();
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 tst_resm(TFAIL, "should not reach here\n");
> + =A0 =A0 =A0 tst_exit();
> +}
> diff --git a/testcases/kernel/security/securebits/run_securebits.sh b/tes=
tcases/kernel/security/securebits/run_securebits.sh
> new file mode 100644
> index 0000000..4d9e272
> --- /dev/null
> +++ b/testcases/kernel/security/securebits/run_securebits.sh
> @@ -0,0 +1,20 @@
> +#!/bin/sh
> +
> +echo "testing keepcaps"
> +check_keepcaps 1
> +tmp=3D$?
> +if [ $tmp -ne 0 ]; then
> + =A0 =A0 =A0 exit_code=3D$tmp
> +fi
> +check_keepcaps 2
> +tmp=3D$?
> +if [ $tmp -ne 0 ]; then
> + =A0 =A0 =A0 exit_code=3D$tmp
> +fi
> +check_keepcaps 3
> +tmp=3D$?
> +if [ $tmp -ne 0 ]; then
> + =A0 =A0 =A0 exit_code=3D$tmp
> +fi
> +
> +exit $exit_code

What if (for instance) test 1 fails, and tests 2 or 3 pass?

---------------------------------------------------------------------------=
---
Virtualization is moving to the mainstream and overtaking non-virtualized
environment for deploying applications. Does it make network security =

easier or more difficult to achieve? Read this whitepaper to separate the =

two and get a better understanding.
http://p.sf.net/sfu/hp-phase2-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
