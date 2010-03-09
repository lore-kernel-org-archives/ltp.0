Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Np6LG-0000tu-W8
	for ltp-list@lists.sourceforge.net; Tue, 09 Mar 2010 20:47:50 +0000
Received: from mail-iw0-f176.google.com ([209.85.223.176])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Np6LF-0005fM-RM
	for ltp-list@lists.sourceforge.net; Tue, 09 Mar 2010 20:47:50 +0000
Received: by iwn6 with SMTP id 6so4032661iwn.4
	for <ltp-list@lists.sourceforge.net>;
	Tue, 09 Mar 2010 12:47:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <E1Np2Dh-0002cm-OF@sfp-scmshell-1.v30.ch3.sourceforge.com>
References: <E1Np2Dh-0002cm-OF@sfp-scmshell-1.v30.ch3.sourceforge.com>
Date: Tue, 9 Mar 2010 12:47:44 -0800
Message-ID: <364299f41003091247j3b7113dalc3d3e18a177731b9@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [Git] ltp updated.
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
To: Rishi kesh K Rajak <risrajak@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net

On Tue, Mar 9, 2010 at 8:23 AM, Rishi kesh K Rajak
<risrajak@linux.vnet.ibm.com> wrote:
> The branch, master, has been updated
> =A0 =A0 =A0 via =A0c962f51674b971496e14ac4be0cc75da98b75fca (commit)
> =A0 =A0 =A0 via =A017905ceabf2dc20e978dfa4ea3682197ad01bf9a (commit)
> =A0 =A0 =A0 via =A0bdfe0b2a9dd720c3013225cc4aa1628e77888b24 (commit)
> =A0 =A0 =A0 via =A0716d29883b11107c32313b1836bea447fecbaf1e (commit)
> =A0 =A0 =A0 via =A058854395050b8a3bb2fa4e5e4401546925f6aad8 (commit)
> =A0 =A0 =A0 via =A0886918830ae73a7f4b5cc2d9bf8554ee9f393ed8 (commit)
> =A0 =A0 =A0 via =A0039e4bbd522168a5145d236faa4e13f402037390 (commit)
> =A0 =A0 =A0from =A063f0a8f554d28b28b207f41e42182e1b789333b6 (commit)
>
>
> - Log -----------------------------------------------------------------
> commit c962f51674b971496e14ac4be0cc75da98b75fca
> Author: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
> Date: =A0 Tue Mar 9 21:53:25 2010 +0530
>
> =A0 =A0Testing for post-receive-email
>
> =A0 =A0Signed-off-by: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
>
> commit 17905ceabf2dc20e978dfa4ea3682197ad01bf9a
> Author: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
> Date: =A0 Tue Mar 9 14:11:41 2010 +0530
>
> =A0 =A0Merge branches 'next' and 'master'
>
> -----------------------------------------------------------------------
>
> Summary of changes:
> =A0TODO =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A02 +-
> =A0testcases/kernel/containers/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 =A02 +
> =A0.../check_netns_enabled.c =3D> check_for_unshare.c} =A0| =A0 60 ++++++=
+++++---------
> =A0.../kernel/controllers/freezer/run_freezer.sh =A0 =A0 =A0| =A0 =A03 +-
> =A0testcases/kernel/syscalls/libevent/Makefile.in =A0 =A0 | =A0 =A03 +-
> =A05 files changed, 40 insertions(+), 30 deletions(-)
> =A0copy testcases/kernel/containers/{netns/check_netns_enabled.c =3D> che=
ck_for_unshare.c} (52%)
>
> diff --git a/TODO b/TODO
> index 9eec828..1756168 100644
> --- a/TODO
> +++ b/TODO
> @@ -1,4 +1,4 @@
> -The following things need to be rewritten // fixed:
> +The following things need to be rewritten // fixed
>
> =A0get_mempolicy01 // mbind01: They're using numa v1 calls which means th=
at all
> =A0versions of Linux / numa as of a few years ago aren't compatible with =
the API
> diff --git a/testcases/kernel/containers/Makefile b/testcases/kernel/cont=
ainers/Makefile
> index 6a7810e..26f1856 100644
> --- a/testcases/kernel/containers/Makefile
> +++ b/testcases/kernel/containers/Makefile
> @@ -26,6 +26,8 @@ FILTER_OUT_DIRS =A0 =A0 =A0 =A0 =A0 =A0 =A0 :=3D $(LIBD=
IR)
>
> =A0LIB =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0:=3D $(LIBDIR)/libclone.a
>
> +LIB =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0:=3D -ld
> +

Wrong. Should be: LDLIBS +=3D -ldl

> =A0INSTALL_TARGETS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0:=3D *.sh
>
> =A0$(LIBDIR):
> diff --git a/testcases/kernel/containers/netns/check_netns_enabled.c b/te=
stcases/kernel/containers/check_for_unshare.c
> similarity index 52%
> copy from testcases/kernel/containers/netns/check_netns_enabled.c
> copy to testcases/kernel/containers/check_for_unshare.c
> index f6add06..06bdfd7 100644
> --- a/testcases/kernel/containers/netns/check_netns_enabled.c
> +++ b/testcases/kernel/containers/check_for_unshare.c
> @@ -13,37 +13,43 @@
> =A0* along with this program; if not, write to the Free Software
> =A0* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 =
USA
> =A0*
> -* Author: Veerendra C <vechandr@in.ibm.com>
> +************************************************************************=
**/
> +/*
> +* Description:
> +* This program verifies the kernel version to be no later than 2.6.16
> +* And checks if the unshare() system call is defined using dlsym(),
> +* in the Dynamically Linked Libraries.
> =A0*
> -* Net namespaces were introduced around 2.6.25. =A0Kernels before that,
> -* assume they are not enabled. =A0Kernels after that, check for -EINVAL
> -* when trying to use CLONE_NEWNET and CLONE_NEWNS.
> -************************************************************************=
***/
> -#include <stdio.h>
> -#include <sched.h>
> -#include "config.h"
> -#include "libclone.h"
> -#include "linux_syscall_numbers.h"
> -#include "test.h"
> +* Date : 26-11-2008
> +* Author : Veerendra C <vechandr@in.ibm.com>
> +*/
>
> -char *TCID =3D "check_netns_enabled";
> -int TST_COUNT =3D 1;
> -int TST_TOTAL =3D 1;
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <dlfcn.h>
> +#include <linux/version.h>
>
> -#ifndef CLONE_NEWNET
> -#define CLONE_NEWNET -1
> -#endif
> +int main(int argc, char **argv)
> +{
> + =A0 =A0 =A0 void *handle;
> + =A0 =A0 =A0 void *ret;
> + =A0 =A0 =A0 char *error;
> + =A0 =A0 =A0 if (LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 16))
> + =A0 =A0 =A0 return 1;
>
> -#ifndef CLONE_NEWNS
> -#define CLONE_NEWNS -1
> -#endif
> + =A0 =A0 =A0 handle =3D dlopen(NULL, RTLD_LAZY);
> + =A0 =A0 =A0 if (!handle) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fprintf(stderr, "%s\n", dlerror());
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 exit(1);
> + =A0 =A0 =A0 }
>
> -int
> -main()
> -{
> - =A0 =A0 =A0 /* Checking if the kernel supports unshare with netns capab=
ilities. */
> - =A0 =A0 =A0 =A0if (syscall(__NR_unshare, CLONE_NEWNET | CLONE_NEWNS) < =
0) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm (TFAIL | TERRNO, "unshare syscall =
smoke test failed");
> + =A0 =A0 =A0 dlerror(); =A0 =A0/* Clear any existing error */
> + =A0 =A0 =A0 ret =3D dlsym(handle, "unshare");
> + =A0 =A0 =A0 if ((error =3D dlerror()) !=3D NULL) =A0{
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fprintf(stderr, "Error: %s\n", error);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 exit(1);
> =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 tst_exit();
> +
> + =A0 =A0 =A0 dlclose(handle);
> + =A0 =A0 =A0 return 0;
> =A0}

-Garrett

---------------------------------------------------------------------------=
---
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
