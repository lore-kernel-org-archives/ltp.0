From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 11 May 2021 10:52:54 +0200
Subject: [LTP] [RFC PATCH v2 1/1] netns_netlink: Rewrite into new API
In-Reply-To: <20210401141210.9536-1-pvorel@suse.cz>
References: <20210401141210.9536-1-pvorel@suse.cz>
Message-ID: <YJpF5mq0oftICi+u@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Remove check for iproute 100519 (v2.6.34 => old enough to drop this check).

I guess that this is fine, it seems to be more than 10 years old now.

> Remove check for unshare() CLONE_NEWNET support (since 2.6.24, old enough).

Actually there are CONFIG_FOO_NS variables in kernel .config and
individual namespaces can be turned on/off. So we have to check if
network namespaces have been compiled into kernel or not. I guess that
simplest solution here would be adding .needs_kconfig field with
"CONFIG_NET_NS=y".

>  .../kernel/containers/netns/netns_helper.h    |  80 -----------
>  .../kernel/containers/netns/netns_netlink.c   | 127 +++++++-----------
>  2 files changed, 46 insertions(+), 161 deletions(-)
>  delete mode 100644 testcases/kernel/containers/netns/netns_helper.h
> 
> diff --git a/testcases/kernel/containers/netns/netns_helper.h b/testcases/kernel/containers/netns/netns_helper.h
> deleted file mode 100644
> index 8b876454f..000000000
> --- a/testcases/kernel/containers/netns/netns_helper.h
> +++ /dev/null
> @@ -1,80 +0,0 @@
> -/*
> - * Copyright (c) International Business Machines Corp., 2008
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
> - * the GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> - *
> - * Author: Veerendra C <vechandr@in.ibm.com>
> - *
> - * Net namespaces were introduced around 2.6.25.  Kernels before that,
> - * assume they are not enabled.  Kernels after that, check for -EINVAL
> - * when trying to use CLONE_NEWNET and CLONE_NEWNS.
> - ***************************************************************************/
> -
> -#define _GNU_SOURCE
> -#include <sched.h>
> -#include "config.h"
> -#include "libclone.h"
> -#include "lapi/syscalls.h"
> -#include "test.h"
> -#include "safe_macros.h"
> -
> -#ifndef CLONE_NEWNS
> -#define CLONE_NEWNS -1
> -#endif
> -
> -static void check_iproute(unsigned int spe_ipver)
> -{
> -	FILE *ipf;
> -	int n;
> -	unsigned int ipver = 0;
> -
> -	ipf = popen("ip -V", "r");
> -	if (ipf == NULL)
> -		tst_brkm(TCONF, NULL,
> -				"Failed while opening pipe for iproute check");
> -
> -	n = fscanf(ipf, "ip utility, iproute2-ss%u", &ipver);
> -	if (n < 1) {
> -		tst_brkm(TCONF, NULL,
> -			"Failed while obtaining version for iproute check");
> -	}
> -	if (ipver < spe_ipver) {
> -		tst_brkm(TCONF, NULL, "The commands in iproute tools do "
> -			"not support required objects");
> -	}
> -
> -	pclose(ipf);
> -}
> -
> -static int dummy(void *arg)
> -{
> -	(void) arg;
> -	return 0;
> -}
> -
> -static void check_netns(void)
> -{
> -	int pid, status;
> -	/* Checking if the kernel supports unshare with netns capabilities. */
> -	if (CLONE_NEWNS == -1)
> -		tst_brkm(TCONF | TERRNO, NULL, "CLONE_NEWNS (%d) not supported",
> -			 CLONE_NEWNS);
> -
> -	pid = do_clone_unshare_test(T_UNSHARE, CLONE_NEWNET | CLONE_NEWNS,
> -	                            dummy, NULL);
> -	if (pid == -1)
> -		tst_brkm(TCONF | TERRNO, NULL,
> -				"unshare syscall smoke test failed");
> -
> -	SAFE_WAIT(NULL, &status);
> -}
> diff --git a/testcases/kernel/containers/netns/netns_netlink.c b/testcases/kernel/containers/netns/netns_netlink.c
> index 47e8235d6..8ed285eb4 100644
> --- a/testcases/kernel/containers/netns/netns_netlink.c
> +++ b/testcases/kernel/containers/netns/netns_netlink.c
> @@ -1,34 +1,27 @@
> -/* Copyright (c) 2014 Red Hat, Inc.
> - *
> - * This program is free software: you can redistribute it and/or modify
> - * it under the terms of version 2 the GNU General Public License as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> - ***********************************************************************
> - * File: netns_netlink.c
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2014 Red Hat, Inc.
> + * Copyright (c) 2021 Petr Vorel <pvorel@suse.cz>
> + */
> +
> +/*\
> + * [DESCRIPTION]
>   *
>   * Tests a netlink interface inside a new network namespace.
> - * Description:
> - * 1. Unshares a network namespace (so network related actions
> - *    have no effect on a real system)
> - * 2. Forks a child which creates a NETLINK_ROUTE netlink socket
> - *    and listens to RTMGRP_LINK (network interface create/delete/up/down)
> - *    multicast group.
> - * 4. Child then waits for parent approval to receive data from socket
> - * 3. Parent creates a new TAP interface (dummy0) and immediately
> - *    removes it (which should generate some data in child's netlink socket).
> - *    Then it allows child to continue.
> - * 4. As the child was listening to RTMGRP_LINK multicast group, it should
> - *    detect the new interface creation/deletion (by reading data from netlink
> - *    socket), if so, the test passes, otherwise it fails.
> - */
> + *
> + * - Unshares a network namespace (so network related actions
> + *   have no effect on a real system).
> + * - Forks a child which creates a NETLINK_ROUTE netlink socket
> + *   and listens to RTMGRP_LINK (network interface create/delete/up/down)
> + *   multicast group.
> + * - Child then waits for parent approval to receive data from socket
> + * - Parent creates a new TAP interface (dummy0) and immediately
> + *   removes it (which should generate some data in child's netlink socket).
> + *   Then it allows child to continue.
> + * - As the child was listening to RTMGRP_LINK multicast group, it should
> + *   detect the new interface creation/deletion (by reading data from netlink
> + *   socket), if so, the test passes, otherwise it fails.
> +\*/
>  
>  #define _GNU_SOURCE
>  #include <sys/wait.h>
> @@ -40,29 +33,13 @@
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <errno.h>
> -#include "netns_helper.h"
> -#include "test.h"
> -#include "safe_macros.h"
> -
> -#define MAX_TRIES 1000
> -#define IP_TUNTAP_MIN_VER 100519
> +#include <sched.h>
>  
> -char *TCID	= "netns_netlink";
> -int TST_TOTAL	= 1;
> -
> -static void cleanup(void)
> -{
> -	tst_rmdir();
> -}
> +#include "tst_test.h"
> +#include "tst_safe_macros.h"
> +#include "lapi/namespaces_constants.h"
>  
> -static void setup(void)
> -{
> -	tst_require_root();
> -	check_iproute(IP_TUNTAP_MIN_VER);
> -	check_netns();
> -	tst_tmpdir();
> -	TST_CHECKPOINT_INIT(tst_rmdir);
> -}
> +#define MAX_TRIES 1000
>  
>  int child_func(void)

static int child_func(void)

>  {
> @@ -71,8 +48,7 @@ int child_func(void)
>  	char buffer[4096];
>  	struct nlmsghdr *nlh;
>  
> -	/* child will listen to a network interface create/delete/up/down
> -	 * events */
> +	/* child will listen to a network interface create/delete/up/down events */
>  	memset(&sa, 0, sizeof(sa));
>  	sa.nl_family = AF_NETLINK;
>  	sa.nl_groups = RTMGRP_LINK;
> @@ -89,7 +65,7 @@ int child_func(void)
>  	}
>  
>  	/* waits for parent to create an interface */
> -	TST_SAFE_CHECKPOINT_WAIT(NULL, 0);
> +	TST_CHECKPOINT_WAIT(0);
>  
>  	/* To get rid of "resource temporarily unavailable" errors
>  	 * when testing with -i option */
> @@ -121,60 +97,49 @@ int child_func(void)
>  	return 0;
>  }


We can simplify the code here by using SAFE_MACROS() which is allowed in
new library.

> -static void test(void)
> +static void test_netns_netlink(void)
>  {
>  	pid_t pid;
>  	int status;
>  
>  	/* unshares the network namespace */
> -	if (unshare(CLONE_NEWNET) == -1)
> -		tst_brkm(TBROK | TERRNO, cleanup, "unshare failed");
> +	SAFE_UNSHARE(CLONE_NEWNET);
>  
> -	pid = tst_fork();
> -	if (pid < 0) {
> -		tst_brkm(TBROK | TERRNO, cleanup, "fork failed");
> -	}
> +	pid = SAFE_FORK();
>  	if (pid == 0) {
>  		_exit(child_func());

No need for _exit() here, _exit() is to be used from signal handlers.

>  	}
>  
>  	/* creates TAP network interface dummy0 */
>  	if (WEXITSTATUS(system("ip tuntap add dev dummy0 mode tap")))
> -		tst_brkm(TBROK, cleanup, "system() failed");
> +		tst_brk(TBROK, "system() failed");
>  
>  	/* removes previously created dummy0 device */
>  	if (WEXITSTATUS(system("ip tuntap del mode tap dummy0")))
> -		tst_brkm(TBROK, cleanup, "system() failed");
> +		tst_brk(TBROK, "system() failed");
>  
>  	/* allow child to continue */
> -	TST_SAFE_CHECKPOINT_WAKE(cleanup, 0);
> -
> +	TST_CHECKPOINT_WAKE(0);
>  
> -	SAFE_WAITPID(cleanup, pid, &status, 0);
> +	SAFE_WAITPID(pid, &status, 0);
>  	if (WIFEXITED(status) && WEXITSTATUS(status) != 0) {
> -		tst_resm(TFAIL, "netlink interface fail");
> +		tst_res(TFAIL, "netlink interface fail");
>  		return;
>  	}

We can also get rid of this result propagation as we can:

- use SAFE_MACROS in child
- use tst_res() in child as:

static void child_func(void)
{
	...

	if (event_found)
		tst_res(TPASS, "...");
	else
		tst_res(TFAIL, "...");

	exit(0);
}

And with that all we have to do is a call to tst_reap_children()

>  	if (WIFSIGNALED(status)) {
> -		tst_resm(TFAIL, "child was killed with signal %s",
> +		tst_res(TFAIL, "child was killed with signal %s",
>  			 tst_strsig(WTERMSIG(status)));
>  		return;
>  	}
>  
> -	tst_resm(TPASS, "netlink interface pass");
> +	tst_res(TPASS, "netlink interface pass");
>  }
>  
> -int main(int argc, char *argv[])
> -{
> -	int lc;
> -
> -	tst_parse_opts(argc, argv, NULL, NULL);
> -
> -	setup();
>  
> -	for (lc = 0; TEST_LOOPING(lc); lc++)
> -		test();
> -
> -	cleanup();
> -	tst_exit();
> -}
> +static struct tst_test test = {
> +	.test_all = test_netns_netlink,
> +	.needs_checkpoints = 1,
> +	.needs_tmpdir = 1,
> +	.needs_root = 1,
> +	.forks_child = 1,
> +};
> -- 
> 2.30.2
> 

-- 
Cyril Hrubis
chrubis@suse.cz
