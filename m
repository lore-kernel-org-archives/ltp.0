Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30653C001B0
	for <ltp@archiver.kernel.org>; Wed, 26 Jul 2023 13:13:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 58C0D3CD73A
	for <ltp@archiver.kernel.org>; Wed, 26 Jul 2023 15:13:14 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 338CB3C4BC7
 for <ltp@lists.linux.it>; Wed, 26 Jul 2023 15:13:03 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0BC11600713
 for <ltp@lists.linux.it>; Wed, 26 Jul 2023 15:13:01 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1811421CF7;
 Wed, 26 Jul 2023 13:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1690377181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AJh0GEwwPM+86KvplR/0AnVqN98ly1yb/DcOtFyKSOs=;
 b=UEagZ9eYJflJKpiBvU+vlJRODXsaK/xX8rtT3jeqngoq0Zoo3pe+3IjOW/SAuMb5W4N5H1
 JC0grLdbo2vkABJ66VSF4zPFs/c4GW3aIJA+4Gf6SrQ8KUM866goeI717Mk8p42t/GIkXE
 KXBxl8G0eC825DFIcMH9Ei6V05bC9nI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1690377181;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AJh0GEwwPM+86KvplR/0AnVqN98ly1yb/DcOtFyKSOs=;
 b=9U+c9clkqpNoWIlBVFn6BZd7Js4pqKky6Q9klyqNW6uiFqDMaH5u/1l+10hDpXhRJ2WAbL
 31WLbg5tcKWzBACg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EEC56139BD;
 Wed, 26 Jul 2023 13:13:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id j9mKNtwbwWQbXwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 26 Jul 2023 13:13:00 +0000
Date: Wed, 26 Jul 2023 15:14:03 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <ZMEcGyqDgzIe0vPs@yuki>
References: <1689760756-865-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1689760756-865-3-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1689760756-865-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] syscalls/getgroups03: Convert to new API
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
There is a typo in the subject which got me confused for a while
s/getgroups/setgroups/

> 1.merge setgroups04 to setgroups03
> 2.use safe_macro macro
> =

> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  runtest/syscalls                                  |   2 -
>  testcases/kernel/syscalls/setgroups/.gitignore    |   2 -
>  testcases/kernel/syscalls/setgroups/setgroups03.c | 251 ++++++----------=
------
>  testcases/kernel/syscalls/setgroups/setgroups04.c | 163 --------------
>  4 files changed, 61 insertions(+), 357 deletions(-)
>  delete mode 100644 testcases/kernel/syscalls/setgroups/setgroups04.c
> =

> diff --git a/runtest/syscalls b/runtest/syscalls
> index b291511..150ddbd 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -1325,8 +1325,6 @@ setgroups02 setgroups02
>  setgroups02_16 setgroups02_16
>  setgroups03 setgroups03
>  setgroups03_16 setgroups03_16
> -setgroups04 setgroups04
> -setgroups04_16 setgroups04_16
>  =

>  sethostname01 sethostname01
>  sethostname02 sethostname02
> diff --git a/testcases/kernel/syscalls/setgroups/.gitignore b/testcases/k=
ernel/syscalls/setgroups/.gitignore
> index 0649a34..9de9282 100644
> --- a/testcases/kernel/syscalls/setgroups/.gitignore
> +++ b/testcases/kernel/syscalls/setgroups/.gitignore
> @@ -4,5 +4,3 @@
>  /setgroups02_16
>  /setgroups03
>  /setgroups03_16
> -/setgroups04
> -/setgroups04_16
> diff --git a/testcases/kernel/syscalls/setgroups/setgroups03.c b/testcase=
s/kernel/syscalls/setgroups/setgroups03.c
> index 490b069..c12d612 100644
> --- a/testcases/kernel/syscalls/setgroups/setgroups03.c
> +++ b/testcases/kernel/syscalls/setgroups/setgroups03.c
> @@ -1,222 +1,93 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
> - *
> - *   Copyright (c) International Business Machines  Corp., 2001
> - *
> - *   This program is free software;  you can redistribute it and/or modi=
fy
> - *   it under the terms of the GNU General Public License as published by
> - *   the Free Software Foundation; either version 2 of the License, or
> - *   (at your option) any later version.
> - *
> - *   This program is distributed in the hope that it will be useful,
> - *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
> - *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> - *   the GNU General Public License for more details.
> - *
> - *   You should have received a copy of the GNU General Public License
> - *   along with this program;  if not, write to the Free Software
> - *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110=
-1301 USA
> + * Copyright (c) International Business Machines  Corp., 2001
> + * Copyright (c) Linux Test Project, 2003-2023
> + * 07/2001 Ported by Wayne Boyer
> + * 05/2002 Ported by Andr=E9 Merlier
>   */
>  =

> -/*
> - * Test Name: setgroups03
> - *
> - * Test Description:
> - *  Verify that,
> - *   1. setgroups() fails with -1 and sets errno to EINVAL if the size
> - *      argument value is > NGROUPS
> - *   2. setgroups() fails with -1 and sets errno to EPERM if the
> - *	calling process is not super-user.
> - *
> - * Expected Result:
> - *  setgroups() should fail with return value -1 and set expected errno.
> - *
> - * Algorithm:
> - *  Setup:
> - *   Setup signal handling.
> - *   Pause for SIGUSR1 if option specified.
> +/*\
> + * [Description]
>   *
> - *  Test:
> - *   Loop if the proper options are given.
> - *   Execute system call
> - *   Check return code, if system call failed (return=3D-1)
> - *   	if errno set =3D=3D expected errno
> - *   		Issue sys call fails with expected return value and errno.
> - *   	Otherwise,
> - *		Issue sys call fails with unexpected errno.
> - *   Otherwise,
> - *	Issue sys call returns unexpected value.
> + * Test for EINVAL, EPERM, EFAULT errors.
>   *
> - *  Cleanup:
> - *   Print errno log and/or timing stats if options given
> + * 1) setgroups() fails with EINVAL if the size argument value is > NGRO=
UPS.
>   *
> - * Usage:  <for command-line>
> - *  setgroups03 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
> - *     where,  -c n : Run n copies concurrently.
> - *             -f   : Turn off functionality Testing.
> - *	       -i n : Execute test n times.
> - *	       -I x : Execute test for x seconds.
> - *	       -P x : Pause for x seconds between iterations.
> - *	       -t   : Turn on syscall timing.
> - *
> - * HISTORY
> - *	07/2001 Ported by Wayne Boyer
> - *
> - * RESTRICTIONS:
> - *  This test should be executed by 'non-super-user' only.
> + * 2) setgroups() fails with EPERM if the calling process is not super-u=
ser.
>   *
> + * 3) setgroups() fails with EFAULT if the list has an invalid address.
>   */
> -#include <limits.h>
> -#include <sys/types.h>
> -#include <unistd.h>
> -#include <errno.h>
> -#include <pwd.h>
> -#include <grp.h>
>  =

> -#include "test.h"
> +#include <pwd.h>
> +#include <stdlib.h>
>  =

> -#include "compat_16.h"
> +#include "tst_test.h"
> +#include "compat_tst_16.h"
>  =

>  #define TESTUSER	"nobody"
>  =

> -char nobody_uid[] =3D "nobody";
> -struct passwd *ltpuser;
> +static GID_T *glist1, *glist2, *glist3;
>  =

> -TCID_DEFINE(setgroups03);
> -int TST_TOTAL =3D 2;
> +static struct tcase {
> +	int gsize;
> +	GID_T **glist;
> +	int exp_errno;
> +} tcases[] =3D {
> +	{NGROUPS + 1, &glist1, EINVAL},
> +	{NGROUPS, &glist2, EPERM},
> +	{NGROUPS, &glist3, EFAULT},
> +};
>  =

> -GID_T *groups_list;		/* Array to hold gids for getgroups() */
> +static void change_uid(void)
> +{
> +	struct passwd *ltpuser, *user_info;
>  =

> -int setup1();			/* setup function to test error EPERM */
> -void setup();			/* setup function for the test */
> -void cleanup();			/* cleanup function for the test */
> +	ltpuser =3D SAFE_GETPWNAM(TESTUSER);
> +	SAFE_SETEUID(ltpuser->pw_uid);
>  =

> -struct test_case_t {		/* test case struct. to hold ref. test cond's */
> -	size_t gsize_add;
> -	int list;
> -	char *desc;
> -	int exp_errno;
> -	int (*setupfunc) ();
> -} Test_cases[] =3D {
> -	{
> -	1, 1, "Size is > sysconf(_SC_NGROUPS_MAX)", EINVAL, NULL}, {
> -	0, 2, "Permission denied, not super-user", EPERM, setup1}
> -};
> +	user_info =3D SAFE_GETPWNAM(TESTUSER);

We usually get the user entry once in the test setup and save it for
later use...

> +	GID16_CHECK(user_info->pw_gid, getpwnam);
> +	glist2 =3D (GID_T *)&(user_info->pw_gid);
> +}
>  =

> -int main(int ac, char **av)
> +static void restore_uid(void)
>  {
> -	int lc;
> -	int gidsetsize;		/* total no. of groups */
> -	int i;
> -	char *test_desc;	/* test specific error message */
> -	int ngroups_max =3D sysconf(_SC_NGROUPS_MAX);	/* max no. of groups in t=
he current system */
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	groups_list =3D malloc(ngroups_max * sizeof(GID_T));
> -	if (groups_list =3D=3D NULL) {
> -		tst_brkm(TBROK, NULL, "malloc failed to alloc %zu errno "
> -			 " %d ", ngroups_max * sizeof(GID_T), errno);
> -	}
> -
> -	setup();
> -
> -	for (lc =3D 0; TEST_LOOPING(lc); lc++) {
> -
> -		tst_count =3D 0;
> -
> -		for (i =3D 0; i < TST_TOTAL; i++) {
> -			if (Test_cases[i].setupfunc !=3D NULL) {
> -				Test_cases[i].setupfunc();
> -			}
> -
> -			gidsetsize =3D ngroups_max + Test_cases[i].gsize_add;
> -			test_desc =3D Test_cases[i].desc;
> -
> -			/*
> -			 * Call setgroups() to test different test conditions
> -			 * verify that it fails with -1 return value and
> -			 * sets appropriate errno.
> -			 */
> -			TEST(SETGROUPS(cleanup, gidsetsize, groups_list));
> -
> -			if (TEST_RETURN !=3D -1) {
> -				tst_resm(TFAIL, "setgroups(%d) returned %ld, "
> -					 "expected -1, errno=3D%d", gidsetsize,
> -					 TEST_RETURN, Test_cases[i].exp_errno);
> -				continue;
> -			}
> -
> -			if (TEST_ERRNO =3D=3D Test_cases[i].exp_errno) {
> -				tst_resm(TPASS,
> -					 "setgroups(%d) fails, %s, errno=3D%d",
> -					 gidsetsize, test_desc, TEST_ERRNO);
> -			} else {
> -				tst_resm(TFAIL, "setgroups(%d) fails, %s, "
> -					 "errno=3D%d, expected errno=3D%d",
> -					 gidsetsize, test_desc, TEST_ERRNO,
> -					 Test_cases[i].exp_errno);
> -			}
> -		}
> -
> -	}
> -
> -	cleanup();
> -
> -	tst_exit();
> +	struct passwd *root_info;
> +
> +	root_info =3D SAFE_GETPWNAM("root");
> +	SAFE_SETEUID(root_info->pw_uid);
>  }
>  =

> -/*
> - * setup() - performs all ONE TIME setup for this test.
> - *
> - *  Call individual test specific setup functions.
> - */
> -void setup(void)
> +static void verify_setgroups(unsigned int i)
>  {
> -	tst_require_root();
> +	struct tcase *tc =3D &tcases[i];
>  =

> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> +	if (tc->exp_errno =3D=3D EPERM)
> +		change_uid();
>  =

> -	TEST_PAUSE;
> +	TST_EXP_FAIL(SETGROUPS(tc->gsize, *tc->glist), tc->exp_errno,
> +		     "setgroups(%d, groups_list)", tc->gsize);
>  =

> +	if (tc->exp_errno =3D=3D EPERM)
> +		restore_uid();
>  }
>  =

> -/*
> - * setup1 -  Setup function to test setgroups() which returns -1
> - *	     and sets errno to EPERM.
> - *
> - *  Get the user info. from /etc/passwd file.
> - *  This function returns 0 on success.
> - */
> -int setup1(void)
> +static void setup(void)
>  {
> -	struct passwd *user_info;	/* struct. to hold test user info */
> -
> -/* Switch to nobody user for correct error code collection */
> -	ltpuser =3D getpwnam(nobody_uid);
> -	if (seteuid(ltpuser->pw_uid) =3D=3D -1) {
> -		tst_resm(TINFO, "setreuid failed to "
> -			 "to set the effective uid to %d", ltpuser->pw_uid);
> -		perror("setreuid");
> -	}
> -
> -	if ((user_info =3D getpwnam(TESTUSER)) =3D=3D NULL) {
> -		tst_brkm(TFAIL, cleanup, "getpwnam(2) of %s Failed", TESTUSER);
> -	}
> -
> -	if (!GID_SIZE_CHECK(user_info->pw_gid)) {
> -		tst_brkm(TBROK,
> -			 cleanup,
> -			 "gid returned from getpwnam is too large for testing setgroups16");
> -	}
> -	groups_list[0] =3D user_info->pw_gid;
> -	return 0;
> +	glist1 =3D SAFE_MALLOC(NGROUPS * sizeof(GID_T));

I guess that technically this should be (NGROUPS+1) * sizeof(GID_T) even
though in reality kernel will return error even before it attempts to
access the buffer.

> +	glist3 =3D sbrk(0);

tst_get_bad_addr() please.


Otherwise it looks good.


-- =

Cyril Hrubis
chrubis@suse.cz

-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
