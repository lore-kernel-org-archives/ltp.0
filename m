Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XWjQc-0006kS-W4
	for ltp-list@lists.sourceforge.net; Wed, 24 Sep 2014 10:04:07 +0000
Date: Wed, 24 Sep 2014 12:03:47 +0200
From: chrubis@suse.cz
Message-ID: <20140924100347.GA23961@rei>
References: <1409837612-27052-1-git-send-email-mmarhefk@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1409837612-27052-1-git-send-email-mmarhefk@redhat.com>
Subject: Re: [LTP] [PATCH 1/3] containers: added sysvipc/shm_comm.c
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
> --- /dev/null
> +++ b/testcases/kernel/containers/sysvipc/shm_comm.c
> @@ -0,0 +1,215 @@
> +/* Copyright (c) 2014 Red Hat, Inc.
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
> + * File: shm_comm.c
> + *
> + * Description:
> + * 1. Clones two child processes with CLONE_NEWIPC flag, each child
> + *    allocates System V shared memory segment (shm) with the _identical_
> + *    key and attaches that segment into its address space.
> + * 2. Child1 writes into the shared memory segment.
> + * 3. Child2 writes into the shared memory segment.
> + * 4. Writes to the shared memory segment with the identical key but from
> + *    two different IPC namespaces should not interfere with each other
> + *    and so child1 checks whether its shared segment wasn't changed
> + *    by child2, if it wasn't test passes, otherwise test fails.
> + */
> +
> +#define _GNU_SOURCE
> +#include <sys/ipc.h>
> +#include <sys/shm.h>
> +#include <sys/types.h>
> +#include <sys/wait.h>
> +#include <stdio.h>
> +#include <errno.h>
> +#include "usctest.h"
> +#include "test.h"
> +#include "safe_macros.h"
> +#include "libclone.h"
> +#include "ipcns_helper.h"
> +
> +
> +#define TESTKEY 124426L
> +#define SHMSIZE 50
> +char *TCID	= "shm_comm";
> +int TST_TOTAL	= 1;
> +int p1[2];
> +int p2[2];
> +
> +
> +static void setup(void)
> +{
> +	tst_require_root(NULL);
> +	check_newipc();
> +}
> +
> +int chld1_shm(void *arg)
> +{
> +	int id, rval = 0;
> +	char *shmem, buf;
> +
> +	close(p1[0]);
> +	close(p2[1]);
> +
> +	/* allocate a System V shared memory segment */
> +	id = shmget(TESTKEY, SHMSIZE, IPC_CREAT);
> +	if (id == -1) {
> +		perror("shmget");
> +		close(p1[1]);
> +		close(p2[0]);
> +		return 2;
> +	}
> +
> +	/* attach the segment reffered by id into the child1 data space */
> +	if ((shmem = shmat(id, NULL, 0)) == (char *) -1) {
> +		perror("shmat");
> +		close(p1[1]);
> +		close(p2[0]);
> +		shmctl(id, IPC_RMID, NULL);
> +		return 2;
> +	}
> +
> +	/* write to the shared segment */
> +	*shmem = 'A';

The comments here are more or less useless, everybody can see that
shmat() does attach the memory.

> +	/* tell child2 to continue */
> +	write(p1[1], "1", 1);
> +
> +	/* wait for child2 */
> +	read(p2[0], &buf, 1);

Please use the CHECKPOINT interface instead.

> +	/* if child1 shared segment has changed (by child2) report fail */
> +	if (*shmem != 'A')
> +		rval = 1;
> +
> +	/* tell child2 to continue */
> +	write(p1[1], "1", 1);
> +
> +	close(p1[1]);
> +	close(p2[0]);
> +
> +	/* detaches the shared memory segment */
> +	shmdt(shmem);
> +	/* remove the shared memory segment */
> +	shmctl(id, IPC_RMID, NULL);

Here the comments are redundant as well.

> +	return rval;
> +}
> +
> +int chld2_shm(void *arg)
> +{
> +	int id;
> +	char *shmem, buf;
> +
> +	close(p1[1]);
> +	close(p2[0]);
> +
> +	/* allocate a System V shared memory segment */
> +	id = shmget(TESTKEY, SHMSIZE, IPC_CREAT);
> +	if (id == -1) {
> +		perror("shmget");
> +		close(p1[0]);
> +		close(p2[1]);
> +		return 2;
> +	}
> +
> +	/* attach the segment referred by id into the child2 data space */
> +	if ((shmem = shmat(id, NULL, 0)) == (char *) -1) {
> +		perror("shmat");
> +		close(p1[0]);
> +		close(p2[1]);
> +		shmctl(id, IPC_RMID, NULL);
> +		return 2;
> +	}
> +
> +	/* wait for child1 to write to his segment */
> +	read(p1[0], &buf, 1);
> +
> +	/* write to the shared segment */
> +	*shmem = 'B';
> +
> +	/* tell child1 to continue */
> +	write(p2[1], "1", 1);
> +
> +	/* wait for child1 */
> +	read(p1[0], &buf, 1);
> +
> +	close(p1[0]);
> +	close(p2[1]);
> +
> +	/* detaches the shared memory segment */
> +	shmdt(shmem);
> +	/* remove the shared memory segment */
> +	shmctl(id, IPC_RMID, NULL);

Comments and CHECKPOINT interface here as well.

> +	return 0;
> +}
> +
> +static void test(void)
> +{
> +	int status, ret = 0;
> +
> +	SAFE_PIPE(NULL, p1);
> +	SAFE_PIPE(NULL, p2);
> +
> +	ret = do_clone_unshare_test(T_CLONE, CLONE_NEWIPC, chld1_shm, NULL);
> +	if (ret == -1)
> +		tst_brkm(TBROK | TERRNO, NULL, "clone failed");
> +
> +	ret = do_clone_unshare_test(T_CLONE, CLONE_NEWIPC, chld2_shm, NULL);
> +	if (ret == -1)
> +		tst_brkm(TBROK | TERRNO, NULL, "clone failed");
> +
> +	close(p1[0]);
> +	close(p1[1]);
> +	close(p2[0]);
> +	close(p2[1]);
> +
> +	/* wait for child processes */
> +	while (wait(&status) > 0) {
> +		if (WIFEXITED(status) && WEXITSTATUS(status) == 1)
> +			ret = 1;
> +		if (WIFEXITED(status) && WEXITSTATUS(status) == 2)
> +			tst_brkm(TBROK | TERRNO, NULL, "error in child");
> +		if (WIFSIGNALED(status)) {
> +			tst_resm(TFAIL, "child was killed with signal %s",
> +					tst_strsig(WTERMSIG(status)));
> +			return;
> +		}
> +	}
> +
> +	if (ret)
> +		tst_resm(TFAIL, "SysV shm: communication with identical keys"
> +				" between namespaces");
> +	else
> +		tst_resm(TPASS, "SysV shm: communication with identical keys"
> +				" between namespaces");
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	const char *msg;
> +	int lc;
> +
> +	msg = parse_opts(argc, argv, NULL, NULL);
> +	if (msg != NULL)
> +		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
> +
> +	setup();
> +
> +	for (lc = 0; TEST_LOOPING(lc); lc++)
> +		test();
> +
> +	tst_exit();
> +}

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Meet PCI DSS 3.0 Compliance Requirements with EventLog Analyzer
Achieve PCI DSS 3.0 Compliant Status with Out-of-the-box PCI DSS Reports
Are you Audit-Ready for PCI DSS 3.0 Compliance? Download White paper
Comply to PCI DSS 3.0 Requirement 10 and 11.5 with EventLog Analyzer
http://pubads.g.doubleclick.net/gampad/clk?id=154622311&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
