Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangli5665@gmail.com>) id 1XifDa-0007hr-Ig
	for ltp-list@lists.sourceforge.net; Mon, 27 Oct 2014 07:59:58 +0000
Received: from mail-oi0-f52.google.com ([209.85.218.52])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1XifDZ-0008IA-Bj
	for ltp-list@lists.sourceforge.net; Mon, 27 Oct 2014 07:59:58 +0000
Received: by mail-oi0-f52.google.com with SMTP id a3so2884996oib.25
	for <ltp-list@lists.sourceforge.net>;
	Mon, 27 Oct 2014 00:59:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1414144932-14710-1-git-send-email-liwang@redhat.com>
References: <1414144932-14710-1-git-send-email-liwang@redhat.com>
Date: Mon, 27 Oct 2014 15:59:51 +0800
Message-ID: <CAE1O6mjbcba91hvNJAodZB4iGW5m7OEtUakmiWVqhOxgVgw8Xg@mail.gmail.com>
From: Li Wang <wangli.ahau@gmail.com>
Subject: Re: [LTP] [PATCH] /kenel/syscalls/prctl: add prctl03
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
To: ltp-list@lists.sourceforge.net

On 24 October 2014 18:02, Li Wang <liwang@redhat.com> wrote:
> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>  runtest/syscalls                          |   1 +
>  testcases/kernel/syscalls/.gitignore      |   1 +
>  testcases/kernel/syscalls/prctl/prctl03.c | 160 ++++++++++++++++++++++++++++++
>  3 files changed, 162 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/prctl/prctl03.c
>
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 6b8de24..daa72ea 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -752,6 +752,7 @@ ppoll01 ppoll01
>
>  prctl01 prctl01
>  prctl02 prctl02
> +prctl03 prctl03
>
>  pread01 pread01
>  pread01_64 pread01_64
> diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
> index 41fec07..442cacc 100644
> --- a/testcases/kernel/syscalls/.gitignore
> +++ b/testcases/kernel/syscalls/.gitignore
> @@ -630,6 +630,7 @@
>  /ppoll/ppoll01
>  /prctl/prctl01
>  /prctl/prctl02
> +/prctl/prctl03
>  /pread/pread01
>  /pread/pread01_64
>  /pread/pread02
> diff --git a/testcases/kernel/syscalls/prctl/prctl03.c b/testcases/kernel/syscalls/prctl/prctl03.c
> new file mode 100644
> index 0000000..c91f1d7
> --- /dev/null
> +++ b/testcases/kernel/syscalls/prctl/prctl03.c
> @@ -0,0 +1,160 @@
> +/*
> + * Copyright (C) 2014 Linux Test Project
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
> + * infringement or the like.  Any license provided herein, whether
> + * implied or otherwise, applies only to this software file.  Patent
> + * licenses, if any, provided herein do not apply to combinations of
> + * this program with other software, or any other product whatsoever.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write the Free Software
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> + * 02110-1301, USA.
> + */
> +
> +/*
> + * Dummy test program to do basic validation for RH BZ #1056347
> + *  -> https://bugzilla.redhat.com/show_bug.cgi?id=1056347
> + *
> + * 1. The CAPBSET test drops CAP_DAC_OVERRIDE; the output should show
> + * it missing from the bounding set.
> + * 2. The SECUREBITS test sets the NOROOT bit; the output should show
> + * the "secure-noroot" bit set.
> + * 3. The KEEPCAPS test sets/checks the KEEPCAPS bit; the output should
> + * show the value changing from zero to one.
> + *
> + */
> +
> +#include <errno.h>
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <linux/capability.h>
> +#include <linux/securebits.h>
> +#include <sys/prctl.h>
> +
> +#include "test.h"
> +#include "usctest.h"
> +
> +static void setup(void);
> +static void cleanup(void);
> +
> +static void test_capbset(void);
> +static void test_securebits(void);
> +static void test_keepcaps(void);
> +
> +char *TCID = "prctl03";
> +int TST_TOTAL = 1;
> +
> +int main(int ac, char **av)
> +{
> +       int lc, i;
My apologies for the useless  variable "i" here.

> +       const char *msg;
> +       pid_t pid;
> +
> +       if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
> +               tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
> +
> +       setup();
> +
> +       for (lc = 0; TEST_LOOPING(lc); lc++){
> +
> +               tst_count = 0;
> +
> +               tst_resm(TINFO, "Testing CAPBSET");
> +               pid = fork();
> +               if (pid == 0) {
> +                       test_capbset();
> +               } else if (pid < 0)
> +                       tst_brkm(TBROK | TERRNO, cleanup, "the pid[%d] is invalid", pid);
> +               if (waitpid(pid, NULL, 0) != pid)
> +                       tst_brkm(TBROK | TERRNO, cleanup, "waitpid[%d]", pid);
> +               tst_resm(TPASS, "Test Passed.\n");
From my re-test, these codes print TPASS even if  the failure occur
above, so we should reconsider the process structure again.

> +
> +               tst_resm(TINFO, "Testing SECUREBITS");
> +               pid = fork();
> +               if (pid == 0) {
> +                       test_securebits();
> +               } else if (pid < 0)
> +                       tst_brkm(TBROK | TERRNO, cleanup, "the pid[%d] is invalid", pid);
> +               if (waitpid(pid, NULL, 0) != pid)
> +                       tst_brkm(TBROK | TERRNO, cleanup, "waitpid[%d]", pid);
> +               tst_resm(TPASS, "Test Passed.\n");
> +
> +               tst_resm(TINFO, "Testing KEEPCAPS");
> +               pid = fork();
> +               if (pid == 0) {
> +                       test_keepcaps();
> +               } else if (pid < 0)
> +                       tst_brkm(TBROK | TERRNO, cleanup, "the pid[%d] is invalid", pid);
> +               if (waitpid(pid, NULL, 0) != pid)
> +                       tst_brkm(TBROK | TERRNO, cleanup, "waitpid[%d]", pid);
> +               tst_resm(TPASS, "Test Passed.\n");
> +       }
> +
> +       cleanup();
> +       tst_exit();
> +}
> +
> +static void test_capbset(void)
> +{
> +       int rc;
> +
> +       rc = prctl(PR_CAPBSET_DROP, CAP_DAC_OVERRIDE, 0, 0, 0);
> +       if (rc)
> +               tst_brkm(TBROK | TERRNO, NULL, "test failue rc = %d", rc);
> +       if (prctl(PR_CAPBSET_READ, CAP_DAC_OVERRIDE, 0, 0, 0) != 0)
> +               tst_brkm(TBROK | TERRNO, NULL, "unknow test failure");
> +       execl("/usr/sbin/capsh", "capsh", "--print", NULL);
> +       exit(0);
> +}
> +
> +static void test_securebits(void)
> +{
> +       int rc;
> +
> +       rc = prctl(PR_SET_SECUREBITS, SECBIT_NOROOT, 0, 0, 0);
> +       if (rc)
> +               tst_brkm(TBROK | TERRNO, NULL, "test failue rc = %d", rc);
> +       rc = prctl(PR_GET_SECUREBITS, 0, 0, 0, 0);
> +       if (!(rc & SECBIT_NOROOT))
> +               tst_brkm(TBROK | TERRNO, NULL, "unknow test failure");
> +       execl("/usr/sbin/capsh", "capsh", "--print", NULL);
> +       exit(0);
> +}
> +
> +static void test_keepcaps(void)
> +{
> +       int rc;
> +
> +       rc = prctl(PR_GET_KEEPCAPS, 0, 0, 0, 0);
> +       tst_resm(TINFO, "pr_get_keepcaps(orig) = %d", rc);
> +       rc = prctl(PR_SET_KEEPCAPS, 1, 0, 0, 0);
> +       if (rc)
> +               tst_brkm(TBROK | TERRNO, NULL, "test failue rc = %d", rc);
> +       rc = prctl(PR_GET_KEEPCAPS, 0, 0, 0, 0);
> +       tst_resm(TINFO, "pr_get_keepcaps(test) = %d", rc);
> +       exit(0);
> +}
> +
> +
> +static void setup(void)
> +{
Seems the case require_root permission.

Okay, please ignore this testcase directly, i will push new one for LTP.

> +       tst_sig(FORK, DEF_HANDLER, cleanup);
> +       TEST_PAUSE;
> +}
> +
> +static void cleanup(void)
> +{
> +       TEST_CLEANUP;
> +}
> --
> 1.9.3
>



-- 
Regards,
Li Wang
Email: wangli.ahau@gmail.com

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
