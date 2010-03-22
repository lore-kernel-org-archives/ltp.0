Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1NtbOh-0000ur-18
	for ltp-list@lists.sourceforge.net; Mon, 22 Mar 2010 06:45:59 +0000
Received: from e5.ny.us.ibm.com ([32.97.182.145])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NtbOf-00021x-I3
	for ltp-list@lists.sourceforge.net; Mon, 22 Mar 2010 06:45:59 +0000
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e5.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o2M6VSM8007662
	for <ltp-list@lists.sourceforge.net>; Mon, 22 Mar 2010 02:31:28 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o2M6jpH01818802
	for <ltp-list@lists.sourceforge.net>; Mon, 22 Mar 2010 02:45:51 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o2M6jpdw001046
	for <ltp-list@lists.sourceforge.net>; Mon, 22 Mar 2010 02:45:51 -0400
Date: Mon, 22 Mar 2010 12:15:46 +0530
From: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Message-ID: <20100322064546.GC20606@linux.vnet.ibm.com>
References: <20100320154817.GA13351@us.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20100320154817.GA13351@us.ibm.com>
Subject: Re: [LTP] [PATCH ltp] fix up filecaps and cap_bound testcases
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
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

On Sat, Mar 20, 2010 at 10:48:17AM -0500, Serge E. Hallyn wrote:
> Here's an attempt at fixing up and simplifying the autoconf for
> detecting libcap and prctl support.  After this, make autotools
> etc work fine on my f12 system, and runltp -f cap_bounds passes.
> the filecaps tests refuse to run claiming to be unable to find
> setcap, which I'll worry about next week.
> 
> (I'm sure there is an AC_ macro for finding a command)
> 
> Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>

Applied to next. Will merge soon to master once i/someone get a chance to test
on multiple boxes.

-Thanks
Rishi
> ---
>  configure.ac                                       |    1 +
>  m4/ltp-cap.m4                                      |   16 +----
>  m4/ltp-prctl.m4                                    |   31 ++++++++++
>  testcases/kernel/security/cap_bound/cap_bounds_r.c |   44 +++++++-------
>  .../kernel/security/cap_bound/cap_bounds_rw.c      |   58 +++++++++++--------
>  .../security/cap_bound/cap_bset_inh_bounds.c       |   61 ++++----------------
>  testcases/kernel/security/cap_bound/check_pe.c     |   20 ++-----
>  testcases/kernel/security/cap_bound/dummy.c        |   26 +++------
>  .../kernel/security/cap_bound/exec_with_inh.c      |   34 ++---------
>  .../kernel/security/cap_bound/exec_without_inh.c   |   35 ++---------
>  testcases/kernel/security/filecaps/c.c             |   44 ++++++++++++++
>  .../kernel/security/filecaps/check_simple_capset.c |   11 +---
>  testcases/kernel/security/filecaps/inh_capped.c    |   12 +---
>  testcases/kernel/security/filecaps/print_caps.c    |    2 +-
>  .../kernel/security/filecaps/verify_caps_exec.c    |   21 +------
>  15 files changed, 182 insertions(+), 234 deletions(-)
>  create mode 100644 m4/ltp-prctl.m4
>  create mode 100644 testcases/kernel/security/filecaps/c.c
> 
> diff --git a/configure.ac b/configure.ac
> index 8a2ebe2..3dd9829 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -61,6 +61,7 @@ AC_CONFIG_SUBDIRS([ \
>  ])
> 
>  LTP_CHECK_CAPABILITY_SUPPORT
> +LTP_CHECK_PRCTL_SUPPORT
>  LTP_CHECK_CRYPTO
>  LTP_CHECK_LINUX_PTRACE
>  LTP_CHECK_SELINUX
> diff --git a/m4/ltp-cap.m4 b/m4/ltp-cap.m4
> index 5f8d969..28d998d 100644
> --- a/m4/ltp-cap.m4
> +++ b/m4/ltp-cap.m4
> @@ -23,21 +23,11 @@ dnl LTP_CHECK_CAPABILITY_SUPPORT
>  dnl ----------------------------
>  dnl
>  AC_DEFUN([LTP_CHECK_CAPABILITY_SUPPORT],[
> +AH_TEMPLATE(HAVE_LIBCAP,
> +[Define to 1 if you have libcap-2 installed.])
>  AC_CHECK_HEADERS(sys/capability.h,[
> -	AC_CHECK_HEADERS(attr/xattr.h)
>  	LTP_CAPABILITY_SUPPORT=yes
> -	AC_CHECK_LIB(cap,cap_free,[
> -		AC_CHECK_LIB(cap,cap_from_text,[
> -			AC_CHECK_LIB(cap,cap_set_proc,[
> -				AC_CHECK_LIB(cap,cap_compare,[
> -					CAP_LIBS="-lcap"
> -				])
> -			])
> -		])
> -	])
> -	AC_CHECK_DECLS([CAP_BSET_DROP, CAP_BSET_READ, PR_CAPBSET_READ, cap_compare, cap_free, cap_from_text, cap_get_proc, cap_set_file, cap_set_flag, cap_set_proc, cap_to_text],[],[],[dnl
> -#include <sys/capability.h>
> -]) dnl AC_CHECK_DECLS
> +	AC_CHECK_LIB(cap,cap_compare,[AC_DEFINE(HAVE_LIBCAP) CAP_LIBS="-lcap"], [CAP_LIBS=""])
>  ])]
>  AC_SUBST(CAP_LIBS)
>  )
> diff --git a/m4/ltp-prctl.m4 b/m4/ltp-prctl.m4
> new file mode 100644
> index 0000000..51edb08
> --- /dev/null
> +++ b/m4/ltp-prctl.m4
> @@ -0,0 +1,31 @@
> +dnl
> +dnl Copyright (c) Cisco Systems Inc., 2009
> +dnl
> +dnl This program is free software;  you can redistribute it and/or modify
> +dnl it under the terms of the GNU General Public License as published by
> +dnl the Free Software Foundation; either version 2 of the License, or
> +dnl (at your option) any later version.
> +dnl
> +dnl This program is distributed in the hope that it will be useful,
> +dnl but WITHOUT ANY WARRANTY;  without even the implied warranty of
> +dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> +dnl the GNU General Public License for more details.
> +dnl
> +dnl You should have received a copy of the GNU General Public License
> +dnl along with this program;  if not, write to the Free Software
> +dnl Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
> +dnl
> +dnl Author: Garrett Cooper <yanegomi@gmail.com>
> +dnl
> +
> +dnl
> +dnl LTP_CHECK_PRCTL_SUPPORT
> +dnl ----------------------------
> +dnl
> +AC_DEFUN([LTP_CHECK_PRCTL_SUPPORT],[
> +AC_CHECK_HEADERS(sys/prctl.h,[
> +	AC_CHECK_DECLS([PR_CAPBSET_DROP, PR_CAPBSET_READ], [],[],[dnl
> +#include <sys/prctl.h>
> +]) dnl AC_CHECK_DECLS
> +])]
> +)
> diff --git a/testcases/kernel/security/cap_bound/cap_bounds_r.c b/testcases/kernel/security/cap_bound/cap_bounds_r.c
> index 917d889..0b1c5b3 100644
> --- a/testcases/kernel/security/cap_bound/cap_bounds_r.c
> +++ b/testcases/kernel/security/cap_bound/cap_bounds_r.c
> @@ -32,21 +32,6 @@
>  #include <sys/prctl.h>
>  #include <test.h>
> 
> -#ifndef CAP_LAST_CAP
> -#warning out-of-date capability.h does not define CAP_LAST_CAP
> -#define CAP_LAST_CAP 28  /* be ultra-conservative */
> -#endif
> -
> -#ifndef CAP_BSET_READ
> -#warning CAP_BSET_READ not defined
> -#define CAP_BSET_READ 23
> -#endif
> -
> -#ifndef CAP_BSET_DROP
> -#warning CAP_BSET_DROP not defined
> -#define CAP_BSET_DROP 24
> -#endif
> -
>  char *TCID = "cap_bounds_r";
>  int TST_TOTAL=1;
> 
> @@ -59,17 +44,27 @@ int main(int argc, char *argv[])
>  	int i;
> 
>  	for (i=0; i<=CAP_LAST_CAP; i++) {
> -		ret = prctl(CAP_BSET_READ, i);
> +#if HAVE_DECL_PR_CAPBSET_READ
> +		ret = prctl(PR_CAPBSET_READ, i);
> +#else
> +		errno = ENOSYS;
> +		ret = -1;
> +#endif
>  		if (ret != 1) {
> -			tst_resm(TFAIL, "prctl(CAP_BSET_READ, %d) returned %d\n", i, ret);
> +			tst_resm(TFAIL, "prctl(PR_CAPBSET_READ, %d) returned %d\n", i, ret);
>  			if (ret == -1)
>  				tst_resm(TINFO, "errno was %d\n", errno);
>  			tst_exit();
>  		}
>  	}
> -	ret = prctl(CAP_BSET_READ, -1);
> +#if HAVE_DECL_PR_CAPBSET_READ
> +	ret = prctl(PR_CAPBSET_READ, -1);
> +#else
> +	errno = ENOSYS;
> +	ret = -1;
> +#endif
>  	if (ret != -1) {
> -		tst_resm(TFAIL, "prctl(CAP_BSET_READ, -1) returned %d\n", -1, ret);
> +		tst_resm(TFAIL, "prctl(PR_CAPBSET_READ, -1) returned %d\n", ret);
>  		tst_exit();
>  	}
> 
> @@ -79,13 +74,18 @@ int main(int argc, char *argv[])
>  	 * testing...  So let's take an insanely high value */
>  #define INSANE 63
>  #define max(x,y) (x > y ? x : y)
> -	ret = prctl(CAP_BSET_READ, max(INSANE,CAP_LAST_CAP+1));
> +#if HAVE_DECL_PR_CAPBSET_READ
> +	ret = prctl(PR_CAPBSET_READ, max(INSANE,CAP_LAST_CAP+1));
> +#else
> +	errno = ENOSYS;
> +	ret = -1;
> +#endif
>  	if (ret != -1) {
> -		tst_resm(TFAIL, "prctl(CAP_BSET_READ, %d) returned %d\n", CAP_LAST_CAP+1, ret);
> +		tst_resm(TFAIL, "prctl(PR_CAPBSET_READ, %d) returned %d\n", CAP_LAST_CAP+1, ret);
>  		tst_resm(TINFO, " %d is CAP_LAST_CAP+1 and should not exist\n", CAP_LAST_CAP+1);
>  		tst_exit();
>  	}
> -	tst_resm(TPASS, "CAP_BSET_READ tests passed\n");
> +	tst_resm(TPASS, "PR_CAPBSET_READ tests passed\n");
>  #else
>  	tst_resm(TCONF, "System doesn't have POSIX capabilities.");
>  #endif
> diff --git a/testcases/kernel/security/cap_bound/cap_bounds_rw.c b/testcases/kernel/security/cap_bound/cap_bounds_rw.c
> index 9129c4e..827a305 100644
> --- a/testcases/kernel/security/cap_bound/cap_bounds_rw.c
> +++ b/testcases/kernel/security/cap_bound/cap_bounds_rw.c
> @@ -31,21 +31,6 @@
>  #include <sys/prctl.h>
>  #include <test.h>
> 
> -#ifndef CAP_LAST_CAP
> -#warning out-of-date capability.h does not define CAP_LAST_CAP
> -#define CAP_LAST_CAP 28  /* be ultra-conservative */
> -#endif
> -
> -#ifndef CAP_BSET_READ
> -#warning CAP_BSET_READ not defined
> -#define CAP_BSET_READ 23
> -#endif
> -
> -#ifndef CAP_BSET_DROP
> -#warning CAP_BSET_DROP not defined
> -#define CAP_BSET_DROP 24
> -#endif
> -
>  char *TCID = "cap_bounds_rw";
>  int TST_TOTAL=1;
> 
> @@ -57,7 +42,12 @@ int check_remaining_caps(int lastdropped)
>  	int ret;
> 
>  	for (i=0; i <= lastdropped; i++) {
> -		ret = prctl(CAP_BSET_READ, i);
> +#if HAVE_DECL_PR_CAPBSET_READ
> +		ret = prctl(PR_CAPBSET_READ, i);
> +#else
> +		errno = ENOSYS;
> +		ret = -1;
> +#endif
>  		if (ret == -1) {
>  			tst_resm(TBROK, "Failed to read bounding set during sanity check\n");
>  			tst_exit();
> @@ -68,7 +58,12 @@ int check_remaining_caps(int lastdropped)
>  		}
>  	}
>  	for (; i<=CAP_LAST_CAP; i++) {
> -		ret = prctl(CAP_BSET_READ, i);
> +#if HAVE_DECL_PR_CAPBSET_READ
> +		ret = prctl(PR_CAPBSET_READ, i);
> +#else
> +		errno = ENOSYS;
> +		ret = -1;
> +#endif
>  		if (ret == -1) {
>  			tst_resm(TBROK, "Failed to read bounding set during sanity check\n");
>  			tst_exit();
> @@ -86,9 +81,14 @@ int main(int argc, char *argv[])
>  	int ret = 1;
>  	int i;
> 
> -	ret = prctl(CAP_BSET_DROP, -1);
> +#if HAVE_DECL_PR_CAPBSET_DROP
> +	ret = prctl(PR_CAPBSET_READ, -1);
> +#else
> +	errno = ENOSYS;
> +	ret = -1;
> +#endif
>  	if (ret != -1) {
> -		tst_resm(TFAIL, "prctl(CAP_BSET_DROP, -1) returned %d\n", ret);
> +		tst_resm(TFAIL, "prctl(PR_CAPBSET_DROP, -1) returned %d\n", ret);
>  		tst_exit();
>  	}
>  	/* Ideally I'd check CAP_LAST_CAP+1, but userspace
> @@ -97,16 +97,26 @@ int main(int argc, char *argv[])
>  	 * testing...  So let's take an insanely high value */
>  #define INSANE 63
>  #define max(x,y) (x > y ? x : y)
> -	ret = prctl(CAP_BSET_DROP, max(INSANE,CAP_LAST_CAP+1));
> +#if HAVE_DECL_PR_CAPBSET_DROP
> +	ret = prctl(PR_CAPBSET_DROP, max(INSANE,CAP_LAST_CAP+1));
> +#else
> +	errno = ENOSYS;
> +	ret = -1;
> +#endif
>  	if (ret != -1) {
> -		tst_resm(TFAIL, "prctl(CAP_BSET_DROP, %d) returned %d\n", max(INSANE, CAP_LAST_CAP+1), ret);
> +		tst_resm(TFAIL, "prctl(PR_CAPBSET_DROP, %d) returned %d\n", max(INSANE, CAP_LAST_CAP+1), ret);
>  		tst_resm(TINFO, " %d is should not exist\n", max(INSANE, CAP_LAST_CAP+1));
>  		tst_exit();
>  	}
>  	for (i=0; i<=CAP_LAST_CAP; i++) {
> -		ret = prctl(CAP_BSET_DROP, i);
> +#if HAVE_DECL_PR_CAPBSET_DROP
> +		ret = prctl(PR_CAPBSET_DROP, i);
> +#else
> +		errno = ENOSYS;
> +		ret = -1;
> +#endif
>  		if (ret != 0) {
> -			tst_resm(TFAIL, "prctl(CAP_BSET_DROP, %d) returned %d\n", i, ret);
> +			tst_resm(TFAIL, "prctl(PR_CAPBSET_DROP, %d) returned %d\n", i, ret);
>  			if (ret == -1)
>  				tst_resm(TINFO, "errno was %d\n", errno);
>  			tst_exit();
> @@ -122,6 +132,6 @@ int main(int argc, char *argv[])
>  			tst_exit();
>  		}
>  	}
> -	tst_resm(TPASS, "CAP_BSET_DROP tests passed\n");
> +	tst_resm(TPASS, "PR_CAPBSET_DROP tests passed\n");
>  	tst_exit();
>  }
> diff --git a/testcases/kernel/security/cap_bound/cap_bset_inh_bounds.c b/testcases/kernel/security/cap_bound/cap_bset_inh_bounds.c
> index 894e0a5..c6c34c0 100644
> --- a/testcases/kernel/security/cap_bound/cap_bset_inh_bounds.c
> +++ b/testcases/kernel/security/cap_bound/cap_bset_inh_bounds.c
> @@ -39,9 +39,11 @@ int TST_TOTAL=2;
> 
>  int errno;
> 
> +#if HAVE_SYS_CAPABILITY_H
> +#if HAVE_DECL_PR_CAPBSET_READ && HAVE_DECL_PR_CAPBSET_DROP
> +#ifdef HAVE_LIBCAP
>  int main(int argc, char *argv[])
>  {
> -#if HAVE_SYS_CAPABILITY_H
>  	int ret = 1;
>  	cap_value_t v[1];
>  	cap_flag_value_t f;
> @@ -49,12 +51,7 @@ int main(int argc, char *argv[])
> 
>  	/* We pick a random capability... let's use CAP_SYS_ADMIN */
>  	/* make sure we have the capability now */
> -#if HAVE_DECL_CAP_BSET_READ
> -	ret = prctl(CAP_BSET_READ, CAP_SYS_ADMIN);
> -#else
> -	errno = ENOSYS;
> -	ret = -1;
> -#endif
> +	ret = prctl(PR_CAPBSET_READ, CAP_SYS_ADMIN);
>  	if (ret != 1) {
>  		tst_resm(TBROK, "Not starting with CAP_SYS_ADMIN\n");
>  		tst_exit();
> @@ -66,47 +63,23 @@ int main(int argc, char *argv[])
>  		tst_resm(TBROK, "Failed to create cap_sys_admin+i cap_t (errno %d)\n", errno);
>  		tst_exit();
>  	}
> -#if HAVE_DECL_CAP_SET_PROC
>  	ret = cap_set_proc(cur);
> -#else
> -	errno = ENOSYS;
> -	ret = -1;
> -#endif
>  	if (ret) {
>  		tst_resm(TBROK, "Failed to cap_set_proc with cap_sys_admin+i (ret %d errno %d)\n",
>  			ret, errno);
>  		tst_exit();
>  	}
> -#if HAVE_DECL_CAP_FREE
>  	cap_free(cur);
> -#endif
> -#if HAVE_DECL_CAP_GET_FLAG
> -#if HAVE_DECL_CAP_GET_PROC
>  	cur = cap_get_proc();
>  	ret = cap_get_flag(cur, CAP_SYS_ADMIN, CAP_INHERITABLE, &f);
> -#else
> -	errno = ENOSYS;
> -	ret = -1;
> -#endif
> -#else
> -	errno = ENOSYS;
> -	ret = -1;
> -#endif
>  	if (ret || f != CAP_SET) {
>  		tst_resm(TBROK, "Failed to add CAP_SYS_ADMIN to pI\n");
>  		tst_exit();
>  	}
> -#if HAVE_DECL_CAP_FREE
>  	cap_free(cur);
> -#endif
> 
>  	/* drop the capability from bounding set */
> -#if HAVE_DECL_CAP_BSET_DROP
> -	ret = prctl(CAP_BSET_DROP, CAP_SYS_ADMIN);
> -#else
> -	errno = ENOSYS;
> -	ret = -1;
> -#endif
> +	ret = prctl(PR_CAPBSET_DROP, CAP_SYS_ADMIN);
>  	if (ret) {
>  		tst_resm(TFAIL, "Failed to drop CAP_SYS_ADMIN from bounding set.\n");
>  		tst_resm(TINFO, "(ret=%d, errno %d)\n", ret, errno);
> @@ -114,18 +87,8 @@ int main(int argc, char *argv[])
>  	}
> 
>  	/* test 1: is CAP_SYS_ADMIN still in pI? */
> -#if HAVE_DECL_CAP_GET_FLAG
> -#if HAVE_DECL_CAP_GET_PROC
>  	cur = cap_get_proc();
>  	ret = cap_get_flag(cur, CAP_SYS_ADMIN, CAP_INHERITABLE, &f);
> -#else
> -	errno = ENOSYS;
> -	ret = -1;
> -#endif
> -#else
> -	errno = ENOSYS;
> -	ret = -1;
> -#endif
>  	if (ret || f != CAP_SET) {
>  		tst_resm(TFAIL, "CAP_SYS_ADMIN not in pI after dropping from bounding set\n");
>  		tst_exit();
> @@ -144,24 +107,24 @@ int main(int argc, char *argv[])
>  		tst_resm(TFAIL, "Failed to drop CAP_SYS_ADMIN from pI\n");
>  		tst_exit();
>  	}
> -#if HAVE_DECL_CAP_FREE
>  	cap_free(tmpcap);
> -#endif
>  	/* test 2: can we put it back in pI? */
> -#if HAVE_DECL_CAP_SET_PROC
>  	ret = cap_set_proc(cur);
> -#endif
>  	if (ret == 0) { /* success means pI was not bounded by X */
>  		tst_resm(TFAIL, "Managed to put CAP_SYS_ADMIN back into pI though not in X\n");
>  		tst_exit();
>  	}
> -#if HAVE_DECL_CAP_FREE
>  	cap_free(cur);
> -#endif
> 
>  	tst_resm(TPASS, "Couldn't put CAP_SYS_ADMIN back into pI when not in bounding set\n");
> -#else
> +#else /* HAVE_LIBCAP */
>  	tst_resm(TCONF, "System doesn't have POSIX capabilities.");
>  #endif
> +#else /* HAVE_DECL_PR_CAPBSET_READ && HAVE_DECL_PR_CAPBSET_DROP */
> +	tst_resm(TCONF, "System doesn't have CAPBSET prctls.");
> +#endif
> +#else /* HAVE_SYS_CAPABILITY_H */
> +	tst_resm(TCONF, "System doesn't have sys/capability.h.");
> +#endif
>  	tst_exit();
>  }
> diff --git a/testcases/kernel/security/cap_bound/check_pe.c b/testcases/kernel/security/cap_bound/check_pe.c
> index 2e0451a..f621e70 100644
> --- a/testcases/kernel/security/cap_bound/check_pe.c
> +++ b/testcases/kernel/security/cap_bound/check_pe.c
> @@ -40,9 +40,10 @@ int TST_TOTAL=1;
> 
>  int errno;
> 
> +#if HAVE_SYS_CAPABILITY_H
> +#ifdef HAVE_LIBCAP
>  int main(int argc, char *argv[])
>  {
> -#if HAVE_SYS_CAPABILITY_H
>  	int ret = 1;
>  	cap_flag_value_t f;
>  	cap_t cur;
> @@ -58,26 +59,14 @@ int main(int argc, char *argv[])
>  		tst_exit();
>  	}
> 
> -#if HAVE_DECL_CAP_GET_FLAG
> -#if HAVE_DECL_CAP_GET_PROC
>  	cur = cap_get_proc();
>  	ret = cap_get_flag(cur, CAP_SYS_ADMIN, CAP_EFFECTIVE, &f);
> -#else
> -	ret = -1;
> -	errno = ENOSYS;
> -#endif
> -#else
> -	ret = -1;
> -	errno = ENOSYS;
> -#endif
>  	if (ret) {
>  		tst_resm(TBROK, "cap_get_flag failed (errno %d)\n", errno);
>  		tst_exit();
>  	}
> 
> -#if HAVE_DECL_CAP_FREE
>  	cap_free(cur);
> -#endif
>  	if (n == 1) {
>  		if (f == CAP_SET) {
>  			tst_resm(TPASS, "cap is in pE\n");
> @@ -91,8 +80,11 @@ int main(int argc, char *argv[])
>  		tst_exit();
>  	}
>  	tst_resm(TFAIL, "Cap is in pE\n");
> -#else
> +#else /* libcap */
>  	tst_resm(TCONF, "System doesn't have POSIX capabilities.");
>  #endif
> +#else /* capability_h */
> +	tst_resm(TCONF, "System doesn't have sys/capability.h");
> +#endif
>  	tst_exit();
>  }
> diff --git a/testcases/kernel/security/cap_bound/dummy.c b/testcases/kernel/security/cap_bound/dummy.c
> index ad65007..e882940 100644
> --- a/testcases/kernel/security/cap_bound/dummy.c
> +++ b/testcases/kernel/security/cap_bound/dummy.c
> @@ -5,31 +5,21 @@
>  #include <sys/capability.h>
>  #endif
> 
> -#define END \
> -	printf("System doesn't support POSIX capabilities.\n"); \
> -	return 1
> -
>  int main()
>  {
>  #if HAVE_SYS_CAPABILITY_H
> +#ifdef HAVE_LIBCAP
>  	cap_t cur;
> -#if HAVE_DECL_CAP_SET_PROC
> -#if HAVE_DECL_CAP_FROM_TEXT
>  	cur = cap_from_text("all=eip");
>  	cap_set_proc(cur);
> -#else
> -	END;
> -#endif
> -#else
> -	END;
> -#endif
> -#if HAVE_DECL_CAP_FREE
>  	cap_free(cur);
> -#else
> -	END;
> +	return 0;
> +#else /* libcap */
> +	printf("System doesn't support POSIX capabilities.\n");
> +	return 1;
>  #endif
> -#else
> -	END;
> +#else /* capability_h */
> +	printf("System doesn't support sys/capability.h\n");
> +	return 1;
>  #endif
> -	return 0;
>  }
> diff --git a/testcases/kernel/security/cap_bound/exec_with_inh.c b/testcases/kernel/security/cap_bound/exec_with_inh.c
> index 21c60fd..123f665 100644
> --- a/testcases/kernel/security/cap_bound/exec_with_inh.c
> +++ b/testcases/kernel/security/cap_bound/exec_with_inh.c
> @@ -42,59 +42,34 @@ int errno;
>  int main(int argc, char *argv[])
>  {
>  #if HAVE_SYS_CAPABILITY_H
> +#ifdef HAVE_LIBCAP
>  	int ret = 1;
>  	cap_flag_value_t f;
>  	cap_t cur = 0;
> 
>  	/* Make sure CAP_SYS_ADMIN is in pI */
> -#if HAVE_DECL_CAP_FROM_TEXT
>  	cur = cap_from_text("all=eip");
> -#endif
>  	if (!cur) {
>  		tst_resm(TBROK, "Failed to create cap_sys_admin+i cap_t (errno %d)\n", errno);
>  		tst_exit();
>  	}
> -#if HAVE_DECL_CAP_SET_PROC
>  	ret = cap_set_proc(cur);
> -#else
> -	ret = -1;
> -	errno = ENOSYS;
> -#endif
>  	if (ret) {
>  		tst_resm(TBROK, "Failed to cap_set_proc with cap_sys_admin+i (ret %d errno %d)\n",
>  			ret, errno);
>  		tst_exit();
>  	}
> -#if HAVE_DECL_CAP_FREE
>  	cap_free(cur);
> -#endif
> -#if HAVE_DECL_CAP_GET_FLAG
> -#if HAVE_DECL_CAP_GET_PROC
>  	cur = cap_get_proc();
>  	ret = cap_get_flag(cur, CAP_SYS_ADMIN, CAP_INHERITABLE, &f);
> -#else
> -	ret = -1;
> -	errno = ENOSYS;
> -#endif
> -#else
> -	ret = -1;
> -	errno = ENOSYS;
> -#endif
>  	if (ret || f != CAP_SET) {
>  		tst_resm(TBROK, "Failed to add CAP_SYS_ADMIN to pI\n");
>  		tst_exit();
>  	}
> -#if HAVE_DECL_CAP_FREE
>  	cap_free(cur);
> -#endif
> 
>  	/* drop the capability from bounding set */
> -#if HAVE_DECL_CAP_BSET_DROP
> -	ret = prctl(CAP_BSET_DROP, CAP_SYS_ADMIN);
> -#else
> -	errno = ENOSYS;
> -	ret = -1;
> -#endif
> +	ret = prctl(PR_CAPBSET_DROP, CAP_SYS_ADMIN);
>  	if (ret) {
>  		tst_resm(TFAIL, "Failed to drop CAP_SYS_ADMIN from bounding set.\n");
>  		tst_resm(TINFO, "(ret=%d, errno %d)\n", ret, errno);
> @@ -104,8 +79,11 @@ int main(int argc, char *argv[])
>  	/* execute "check_pe 1" */
>  	execl("check_pe", "check_pe", "1", NULL);
>  	tst_resm(TBROK, "Failed to execute check_pe (errno %d)\n", errno);
> -#else
> +#else /* HAVE_LIBCAP */
>  	tst_resm(TCONF, "System doesn't have POSIX capabilities.");
>  #endif
> +#else /* HAVE_SYS_CAPABILITY_H */
> +	tst_resm(TCONF, "System doesn't have sys/capability.h.");
> +#endif
>  	tst_exit();
>  }
> diff --git a/testcases/kernel/security/cap_bound/exec_without_inh.c b/testcases/kernel/security/cap_bound/exec_without_inh.c
> index 81216f3..df3c4d9 100644
> --- a/testcases/kernel/security/cap_bound/exec_without_inh.c
> +++ b/testcases/kernel/security/cap_bound/exec_without_inh.c
> @@ -42,39 +42,20 @@ int errno;
>  int main(int argc, char *argv[])
>  {
>  #if HAVE_SYS_CAPABILITY_H
> +#ifdef HAVE_LIBCAP
>  	int ret = 1;
>  	cap_flag_value_t f;
>  	cap_value_t v[1];
>  	cap_t cur;
> 
>  	/* Make sure CAP_SYS_ADMIN is not in pI */
> -#if HAVE_DECL_CAP_GET_FLAG
> -#if HAVE_DECL_CAP_GET_PROC
>  	cur = cap_get_proc();
>  	ret = cap_get_flag(cur, CAP_SYS_ADMIN, CAP_INHERITABLE, &f);
> -#else
> -	ret = -1;
> -	errno = ENOSYS;
> -#endif
> -#else
> -	ret = -1;
> -	errno = ENOSYS;
> -#endif
>  	if (f == CAP_SET) {
>  		v[0] = CAP_SYS_ADMIN;
> -#if HAVE_DECL_CAP_SET_FLAG
>  		ret = cap_set_flag(cur, CAP_INHERITABLE, 1, v, CAP_CLEAR);
> -#else
> -		ret = -1;
> -		errno = ENOSYS;
> -#endif
> -#if HAVE_DECL_CAP_SET_PROC
>  		if (!ret)
>  			ret = cap_set_proc(cur);
> -#else
> -		ret = -1;
> -		errno = ENOSYS;
> -#endif
>  		if (ret) {
>  			tst_resm(TBROK, "Failed to drop cap_sys_admin from pI\n");
>  			tst_exit();
> @@ -83,17 +64,10 @@ int main(int argc, char *argv[])
>  		tst_brkm(TBROK | TERRNO, tst_exit, "Failed to add \
>  			CAP_SYS_ADMIN to pI");
>  	}
> -#if HAVE_DECL_CAP_FREE
>  	cap_free(cur);
> -#endif
> 
>  	/* drop the capability from bounding set */
> -#if HAVE_DECL_CAP_BSET_DROP
> -	ret = prctl(CAP_BSET_DROP, CAP_SYS_ADMIN);
> -#else
> -	errno = ENOSYS;
> -	ret = -1;
> -#endif
> +	ret = prctl(PR_CAPBSET_DROP, CAP_SYS_ADMIN);
>  	if (ret) {
>  		tst_resm(TFAIL, "Failed to drop CAP_SYS_ADMIN from bounding set.\n");
>  		tst_resm(TINFO, "(ret=%d, errno %d)\n", ret, errno);
> @@ -103,8 +77,11 @@ int main(int argc, char *argv[])
>  	/* execute "check_pe 0" */
>  	execl("check_pe", "check_pe", "0", NULL);
>  	tst_resm(TBROK, "Failed to execute check_pe (errno %d)\n", errno);
> -#else
> +#else /* libcap */
>  	tst_resm(TCONF, "System doesn't have POSIX capabilities.");
>  #endif
> +#else /* capability_h */
> +	tst_resm(TCONF, "System doesn't have sys/capability.h.");
> +#endif
>  	tst_exit();
>  }
> diff --git a/testcases/kernel/security/filecaps/c.c b/testcases/kernel/security/filecaps/c.c
> new file mode 100644
> index 0000000..ee6cf05
> --- /dev/null
> +++ b/testcases/kernel/security/filecaps/c.c
> @@ -0,0 +1,44 @@
> +/******************************************************************************/
> +/*                                                                            */
> +/* Copyright (c) International Business Machines  Corp., 2008                 */
> +/*                                                                            */
> +/* This program is free software;  you can redistribute it and/or modify      */
> +/* it under the terms of the GNU General Public License as published by       */
> +/* the Free Software Foundation; either version 2 of the License, or          */
> +/* (at your option) any later version.                                        */
> +/*                                                                            */
> +/* This program is distributed in the hope that it will be useful,            */
> +/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
> +/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
> +/* the GNU General Public License for more details.                           */
> +/*                                                                            */
> +/* You should have received a copy of the GNU General Public License          */
> +/* along with this program;  if not, write to the Free Software               */
> +/* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    */
> +/*                                                                            */
> +/******************************************************************************/
> +
> +
> +#include <stdio.h>
> +#include <sys/capability.h>
> +
> +int main()
> +{
> +	cap_t caps, caps2;
> +	int ret;
> +
> +#ifdef HAVE_LIBCAP
> +	caps = cap_from_text("cap_setpcap+ep");
> +	caps2 = cap_from_text("cap_setpcap+ep");
> +	ret = cap_set_proc(caps);
> +	ret = cap_compare(caps, caps2);
> +	printf("Caps were %sthe same\n", ret ? "not " : "");
> +
> +	cap_free(caps);
> +	cap_free(caps2);
> +	return ret;
> +#else
> +	printf("System doesn't support full POSIX capabilities.\n");
> +	return 1;
> +#endif
> +}
> diff --git a/testcases/kernel/security/filecaps/check_simple_capset.c b/testcases/kernel/security/filecaps/check_simple_capset.c
> index 7851e01..6c7790d 100644
> --- a/testcases/kernel/security/filecaps/check_simple_capset.c
> +++ b/testcases/kernel/security/filecaps/check_simple_capset.c
> @@ -27,28 +27,21 @@
> 
>  int main()
>  {
> -#if HAVE_SYS_CAPABILITY_H
> +#ifdef HAVE_LIBCAP
>  	cap_t caps, caps2;
>  	int ret;
> 
> -#if HAVE_DECL_CAP_FROM_TEXT && HAVE_DECL_CAP_SET_PROC && HAVE_DECL_CAP_COMPARE
>  	caps = cap_from_text("cap_setpcap+ep");
>  	caps2 = cap_from_text("cap_setpcap+ep");
>  	ret = cap_set_proc(caps);
>  	ret = cap_compare(caps, caps2);
> -#else
> -	printf("System doesn't support full POSIX capabilities.\n");
> -	return 1;
> -#endif
>  	printf("Caps were %sthe same\n", ret ? "not " : "");
> 
> -#if HAVE_DECL_CAP_FREE
>  	cap_free(caps);
>  	cap_free(caps2);
> -#endif
>  	return ret;
>  #else
> -	printf("System doesn't support POSIX capabilities.\n");
> +	printf("System doesn't support full POSIX capabilities.\n");
>  	return 1;
>  #endif
>  }
> diff --git a/testcases/kernel/security/filecaps/inh_capped.c b/testcases/kernel/security/filecaps/inh_capped.c
> index 513fcb9..794e8b1 100644
> --- a/testcases/kernel/security/filecaps/inh_capped.c
> +++ b/testcases/kernel/security/filecaps/inh_capped.c
> @@ -34,21 +34,17 @@
>  char *TCID = "filecaps";
>  int TST_TOTAL=1;
> 
> +#ifdef HAVE_LIBCAP
>  void debug_print_caps(char *when)
>  {
> -#ifdef DEBUG
>  	char buf[2000];
>  	tst_resm(TINFO, "%s", when);
> -#if HAVE_DECL_SET_CAP_TO_TEXT
>  	snprintf(buf, 2000, "%s", cap_to_text(cap_get_proc(), NULL));
> -#endif
>  	tst_resm(TINFO, "%s", buf);
> -#endif
>  }
> 
>  int set_caps_from_text(char *capstr)
>  {
> -#if HAVE_SYS_CAPABILITY_H && HAVE_DECL_SET_CAP_SET_PROC && HAVE_DECL_SET_CAP_FREE
>  	cap_t caps = cap_from_text(capstr);
>  	int ret;
> 
> @@ -59,14 +55,12 @@ int set_caps_from_text(char *capstr)
>  	ret = cap_set_proc(caps);
>  	cap_free(caps);
>  	return ret;
> -#else
> -	return -1;
> -#endif
>  }
> +#endif
> 
>  int main()
>  {
> -#if HAVE_SYS_CAPABILITY_H && HAVE_DECL_SET_CAPS_FROM_TEXT
> +#ifdef HAVE_LIBCAP
>  	int ret;
> 
>  	debug_print_caps("start");
> diff --git a/testcases/kernel/security/filecaps/print_caps.c b/testcases/kernel/security/filecaps/print_caps.c
> index 188856e..f0e9bce 100644
> --- a/testcases/kernel/security/filecaps/print_caps.c
> +++ b/testcases/kernel/security/filecaps/print_caps.c
> @@ -40,7 +40,7 @@
> 
>  int main(int argc, char *argv[])
>  {
> -#if HAVE_SYS_CAPABILITY_H && HAVE_DECL_CAP_FREE && HAVE_DECL_CAP_GET_PROC && HAVE_DECL_CAP_TO_TEXT
> +#ifdef HAVE_LIBCAP
>  	cap_t cap = cap_get_proc();
>  	int fd;
>  	int seqno = 0;
> diff --git a/testcases/kernel/security/filecaps/verify_caps_exec.c b/testcases/kernel/security/filecaps/verify_caps_exec.c
> index 16fcc0f..5250007 100644
> --- a/testcases/kernel/security/filecaps/verify_caps_exec.c
> +++ b/testcases/kernel/security/filecaps/verify_caps_exec.c
> @@ -60,20 +60,18 @@ void usage(char *me)
>  #define DROP_PERMS 0
>  #define KEEP_PERMS 1
> 
> +#ifdef HAVE_LIBCAP
>  void print_my_caps()
>  {
> -#if HAVE_SYS_CAPABILITY_H && HAVE_DECL_CAP_FREE && HAVE_DECL_CAP_GET_PROC && HAVE_DECL_CAP_TO_TEXT
>  	cap_t cap = cap_get_proc();
>  	char *txt = cap_to_text(cap, NULL);
>  	tst_resm(TINFO, "\ncaps are %s\n", txt);
>  	cap_free(cap);
>  	cap_free(txt);
> -#endif
>  }
> 
>  int drop_root(int keep_perms)
>  {
> -#if HAVE_SYS_CAPABILITY_H && HAVE_DECL_CAP_FREE && HAVE_DECL_CAP_FROM_TEXT && HAVE_DECL_CAP_SET_PROC
>  	int ret;
> 
>  	if (keep_perms)
> @@ -89,15 +87,11 @@ int drop_root(int keep_perms)
>  		cap_set_proc(cap);
>  		cap_free(cap);
>  	}
> -#else
> -	tst_resm(TCONF, "System doesn't have full POSIX capabilities support.\n");
> -#endif
>  	tst_exit();
>  }
> 
>  int perms_test(void)
>  {
> -#if HAVE_SYS_CAPABILITY_H && HAVE_DECL_CAP_FREE && HAVE_DECL_CAP_SET_FILE
>  	int ret;
>  	cap_t cap;
> 
> @@ -118,9 +112,6 @@ int perms_test(void)
> 
>  	cap_free(cap);
>  	return ret;
> -#else
> -	return -1;
> -#endif
>  }
> 
>  #define FIFOFILE "caps_fifo"
> @@ -160,7 +151,6 @@ void read_from_fifo(char *buf)
>  	close(fd);
>  }
> 
> -#if HAVE_SYS_CAPABILITY_H && HAVE_DECL_CAP_COMPARE && HAVE_DECL_CAP_FREE && HAVE_DECL_CAP_TO_TEXT
>  int fork_drop_and_exec(int keepperms, cap_t expected_caps)
>  {
> 
> @@ -219,12 +209,9 @@ int fork_drop_and_exec(int keepperms, cap_t expected_caps)
>  	}
>  	return ret;
>  }
> -#endif
> 
>  int caps_actually_set_test(void)
>  {
> -
> -#if HAVE_SYS_CAPABILITY_H && HAVE_DECL_PR_CAPBSET_READ
>  	int  whichcap, finalret = 0, ret;
>  	cap_t fcap, pcap, cap_fullpi;
>  	cap_value_t capvalue[1];
> @@ -399,17 +386,15 @@ int caps_actually_set_test(void)
>  	cap_free(cap_fullpi);
> 
>  	return finalret;
> -#else
> -	return -1;
> -#endif
>  }
> +#endif
> 
>  int main(int argc, char *argv[])
>  {
> +#ifdef HAVE_LIBCAP
>  	if (argc < 2)
>  		usage(argv[0]);
> 
> -#if HAVE_SYS_CAPABILITY_H
>  	int ret = 0;
> 
>  	switch(atoi(argv[1])) {
> -- 
> 1.6.0.6
> 
> 
> ------------------------------------------------------------------------------
> Download Intel&#174; Parallel Studio Eval
> Try the new software tools for yourself. Speed compiling, find bugs
> proactively, and fine-tune applications for parallel performance.
> See why Intel Parallel Studio got high marks during beta.
> http://p.sf.net/sfu/intel-sw-dev
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

-- 
Thanks & Regards
Rishi
LTP Maintainer
IBM, LTC, Bangalore
Please join IRC #ltp @ irc.freenode.net

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
