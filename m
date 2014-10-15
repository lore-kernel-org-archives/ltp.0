Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XeO7p-0004ci-Mw
	for ltp-list@lists.sourceforge.net; Wed, 15 Oct 2014 12:56:21 +0000
Date: Wed, 15 Oct 2014 14:56:01 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141015125601.GG5006@rei.suse.cz>
References: <1409153560-10176-1-git-send-email-mmarhefk@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1409153560-10176-1-git-send-email-mmarhefk@redhat.com>
Subject: Re: [LTP] [PATCH] containers: added netns/netns_interfaces.c
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

Hi!
> +#define _GNU_SOURCE
> +#include <sys/wait.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <errno.h>
> +#include "usctest.h"
> +#include "test.h"
> +#include "safe_macros.h"
> +#include "netns_helper.h"
> +
> +
> +/* by convention a named network namespace is an object
> + * at /var/run/netns/NAME that can be opened. (man 8 ip-netns) */
> +#define NETNS     "/var/run/netns"
> +char *TCID	= "netns_sendintf";
> +int TST_TOTAL	= 3;
> +int pipefd[2];
> +
> +
> +static void cleanup(void)
> +{
> +	close(pipefd[0]);
> +	close(pipefd[1]);

This should be ported to the checkpoint interface.

> +	/* removes veth0 device (which also removes paired veth1 device) */
> +	if (WEXITSTATUS(system("ip link delete veth0")))
> +		perror("system");
> +	/* removes the network namespace myns */
> +	if (WEXITSTATUS(system("ip netns del myns")))
> +		perror("system");
> +}
> +
> +static void setup(void)
> +{
> +	tst_require_root(NULL);
> +	check_netns();
> +}
> +
> +int child_func(void)
> +{
> +	int status, fd;
> +	char c;
> +
> +	fd = open(NETNS"/myns", O_RDONLY);
> +	if (fd == -1) {
> +		perror("open");
> +		return 1;
> +	}
> +
> +	/* associates child with the namespace referred by fd (myns) */
> +	if (setns(fd, 0) == -1) {
> +		perror("setns");
> +		return 1;
> +	}
> +
> +	/* setup for veth1 device */
> +	if (WEXITSTATUS(system("ip address add 192.168.0.2/24 dev veth1"))) {
> +		perror("system");
> +		return 1;
> +	}
> +	if (WEXITSTATUS(system("ip link set dev veth1 up"))) {
> +		perror("system");
> +		return 1;
> +	}
> +
> +	/* waits for parent to confirm that veth0 device setup is done */
> +	if (read(pipefd[0], &c, 1) == -1) {
> +		perror("read");
> +		return 1;
> +	}
> +
> +	/* ping veth0 address through veth1 device */
> +	if (WEXITSTATUS(
> +	    system("ping -q -c 2 -I veth1 192.168.0.1 &>/dev/null")))
> +		return 1;
> +
> +	return 0;
> +}
> +
> +static void test(void)
> +{
> +	pid_t pid;
> +	int status, ret = 0;
> +
> +	/* creates a pipe for synchronization between parent and child */
> +	SAFE_PIPE(cleanup, pipefd);
> +
> +	/* unshares a network and a mount namespace */
> +	if (unshare(CLONE_NEWNET|CLONE_NEWNS) == -1)
> +		tst_brkm(TBROK | TERRNO, cleanup, "unshare failed");
> +
> +
> +	/* TEST CASE #1 */
> +	/* creates a pair of virtual ethernet devices */
> +	if (WEXITSTATUS(system("ip link add veth0 type veth peer name veth1")))
> +		tst_brkm(TBROK | TERRNO, cleanup, "system failed");
> +	/* creates a new network namespace "myns" (man 8 ip-netns) */
> +	if (WEXITSTATUS(system("ip netns add myns")))
> +		tst_brkm(TBROK | TERRNO, cleanup, "system failed");
> +	/* adds device veth1 to myns namespace */
> +	if (WEXITSTATUS(system("ip link set veth1 netns myns")))
> +		tst_brkm(TBROK | TERRNO, cleanup, "system failed");
> +
> +
> +	pid = fork();
> +	if (pid < 0) {  /* error */
> +		tst_brkm(TBROK | TERRNO, cleanup, "fork failed");
> +	}
> +	if (pid == 0) { /* child */
> +		_exit(child_func());
> +	}
> +
> +	/* parent */

And also freed from trivial comments like these.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Comprehensive Server Monitoring with Site24x7.
Monitor 10 servers for $9/Month.
Get alerted through email, SMS, voice calls or mobile push notifications.
Take corrective actions from your mobile device.
http://p.sf.net/sfu/Zoho
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
