Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1X9DYR-00006S-U3
	for ltp-list@lists.sourceforge.net; Mon, 21 Jul 2014 13:22:59 +0000
Received: from mx6-phx2.redhat.com ([209.132.183.39])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1X9DYQ-0007SF-1n
	for ltp-list@lists.sourceforge.net; Mon, 21 Jul 2014 13:22:59 +0000
Date: Mon, 21 Jul 2014 09:22:51 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1347769361.12788938.1405948971664.JavaMail.zimbra@redhat.com>
In-Reply-To: <1405939298-8195-1-git-send-email-mmarhefk@redhat.com>
References: <1405939298-8195-1-git-send-email-mmarhefk@redhat.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] containers: added pidns/pidns03.c
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
To: Matus Marhefka <mmarhefk@redhat.com>
Cc: ltp-list@lists.sourceforge.net



----- Original Message -----
> From: "Matus Marhefka" <mmarhefk@redhat.com>
> To: ltp-list@lists.sourceforge.net
> Sent: Monday, 21 July, 2014 12:41:38 PM
> Subject: [LTP] [PATCH] containers: added pidns/pidns03.c
> 
> * Clones a new child process with CLONE_NEWPID flag - the new child
> * process mounts procfs to a "/proc2" directory and checks if it belongs
> * to a new pid namespace by:
> * 1. reading value of a symbolic link "/proc2/self"
> * 2. comparing read value (PID) with "1"
> 
> Signed-off-by: Matus Marhefka <mmarhefk@redhat.com>
> Signed-off-by: Jiri Jaburek <jjaburek@redhat.com>
> ---
>  testcases/kernel/containers/pidns/pidns03.c | 111
>  ++++++++++++++++++++++++++++
>  1 file changed, 111 insertions(+)
>  create mode 100644 testcases/kernel/containers/pidns/pidns03.c
> 
> diff --git a/testcases/kernel/containers/pidns/pidns03.c
> b/testcases/kernel/containers/pidns/pidns03.c
> new file mode 100644
> index 0000000..203b67b
> --- /dev/null
> +++ b/testcases/kernel/containers/pidns/pidns03.c
> @@ -0,0 +1,111 @@
> +/* Copyright (c) 2014 Red Hat, Inc. All rights reserved.
> + *
> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of version 2 the GNU General Public License as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + ***********************************************************************
> + * File: pidns03.c
> + *
> + * Description:
> + * Clones a new child process with CLONE_NEWPID flag - the new child
> + * process mounts procfs to a "/proc2" directory and checks if it belongs
> + * to a new pid namespace by:
> + * 1. reading value of a symbolic link "/proc2/self"
> + * 2. comparing read value (PID) with "1"
> + */
> +
> +#define _GNU_SOURCE
> +#include <sys/wait.h>
> +#include <sys/mount.h>
> +#include <sys/stat.h>

Hi,

Is header sys/stat.h used for anything?

> +#include <sys/types.h>
> +#include <stdio.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <errno.h>
> +#include "usctest.h"
> +#include "test.h"
> +#include "safe_macros.h"
> +#include "libclone.h"
> +
> +
> +char *TCID	= "pidns03";
> +int TST_TOTAL	= 1;
> +
> +
> +static void cleanup(void)
> +{
> +	umount("/proc2");
> +	rmdir("/proc2");

I'd prefer this to be just "proc2" inside temporary directory created by
"tst_tmpdir()" in setup() and cleaned up by "tst_rmdir()" in cleanup().

> +}
> +
> +static void setup(void)
> +{
> +	tst_require_root(NULL);
> +}
> +
> +int childFunc(void *arg)
> +{
> +	char buf[10];
> +	int result = 1;
> +
> +	SAFE_MKDIR(cleanup, "/proc2", 0555);

You shouldn't use tst_ and SAFE macros in child process.
See "2.2.7" in doc/test-writing-guidelines.txt about possible consequences.

One option is to move SAFE_MKDIR to setup() and keep rmdir in cleanup().

> +
> +	if (mount("none", "/proc2", "proc", MS_RDONLY, NULL) == -1)
> +		tst_brkm(TFAIL | TERRNO, cleanup, "mount");
> +
        ^^^^^^^^ There is some unnecessary whitespace here.

> +	if (readlink("/proc2/self", buf, sizeof(buf)) == -1)
> +		tst_brkm(TFAIL | TERRNO, cleanup, "readlink");

I'd move umount() here. 

> +
> +	/* child should have PID 1 in a new pid namespace - if true
> +	 * procfs belongs to the new pid namespace */
> +	if (!strcmp(buf, "1"))
> +		result = 0;

It would be useful to print buf value if this check fails.

> +
> +	return result;
> +}
> +
> +static void test(void)
> +{
> +	int status;
> +	int ret;
> +
> +	ret = do_clone_tests(CLONE_NEWPID, childFunc, NULL, NULL, NULL);
> +
> +	if (ret == -1) {
> +		tst_brkm(TFAIL | TTERRNO, cleanup, "clone failed");

I'd expect "TBROK | TERRNO" here. TTERRNO is using TEST_ERRNO, which I can't see
being set anywhere in libclone.c or lib/cloner.c.

Braces {} are not necessary for single line statements.

> +	} else if ((wait(&status)) == -1) {
> +		tst_brkm(TWARN | TERRNO, cleanup, "wait failed");

same as above, TBROK | TERRNO

> +	}
> +
> +	if (WIFEXITED(status) && WEXITSTATUS(status) != 0) {
> +		tst_resm(TFAIL, "mounting procfs in a new namespace");
> +	} else if (WIFSIGNALED(status)) {
> +		tst_resm(TFAIL, "child was killed with signal = %d",
> +			 WTERMSIG(status));
> +	} else {
> +		tst_resm(TPASS, "mounting procfs in a new namespace");
> +	}
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	const char *msg;
> +	if ((msg = parse_opts(argc, argv, NULL, NULL)))
> +		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
> +
> +	setup();
> +

You are missing TEST_LOOPING here:

        for (lc = 0; TEST_LOOPING(lc); lc++)
                test();

Regards,
Jan

> +	test();
> +
> +	cleanup();
> +	tst_exit();
> +}
> --
> 1.8.3.1
> 
>

------------------------------------------------------------------------------
Want fast and easy access to all the code in your enterprise? Index and
search up to 200,000 lines of code with a free copy of Black Duck
Code Sight - the same software that powers the world's largest code
search on Ohloh, the Black Duck Open Hub! Try it now.
http://p.sf.net/sfu/bds
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
