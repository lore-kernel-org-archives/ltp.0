Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <chrubis@suse.de>) id 1QFT44-000437-IM
	for ltp-list@lists.sourceforge.net; Thu, 28 Apr 2011 15:23:36 +0000
Date: Thu, 28 Apr 2011 17:49:13 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110428154913.GA30341@saboteur.suse.cz>
References: <BANLkTimHzFEY8-ECzh7++oK97oboW31zdQ@mail.gmail.com>
	<4568ba43493b4cdedfa0ccb3a3b2cdb746ea2147.1303875548.git.czhang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4568ba43493b4cdedfa0ccb3a3b2cdb746ea2147.1303875548.git.czhang@redhat.com>
Subject: Re: [LTP] [PATCH v3] thp testcase come from CVE reproducer
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
To: Caspar Zhang <czhang@redhat.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

Hi!
> +#include <sys/types.h>
> +#include <sys/resource.h>
> +#include <sys/wait.h>
> +#include <stdio.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include "test.h"
> +#include "usctest.h"
> +#include "config.h"
> +
> +char *TCID = "thp01";
> +int TST_TOTAL = 1;
> +
> +#define ARRAY_SZ	256
> +
> +static int ps;
> +static long length;
> +static char *array[ARRAY_SZ];
> +static char *arg;
> +
> +struct rlimit rl = {
> +	.rlim_cur = RLIM_INFINITY,
> +	.rlim_max = RLIM_INFINITY,
> +};

Perhaps static struct rlimit just to be consistent.

> +static void setup(void);
> +static void cleanup(void);
> +
> +int main(int argc, char **argv)
> +{
> +	int i, lc, st;
> +	pid_t pid;
> +	char *msg;
> +
> +	msg = parse_opts(argc, argv, NULL, NULL);
> +	if (msg != NULL)
> +		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
> +
> +	setup();
> +
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +		switch (pid = fork()) {
> +		case -1:
> +			tst_brkm(TBROK|TERRNO, cleanup, "fork");
> +		case 0:
> +			memset(arg, 'c', length - 1);
> +			arg[length - 1] = '\0';
> +			for (i = 0; i < ARRAY_SZ; i++)
> +				array[i] = arg;
> +			if (setrlimit(RLIMIT_STACK, &rl) == -1) {
> +				perror("setrlimit");
> +				exit(1);
> +			}
> +			if (execve("/bin/true", array, array) == -1) {
> +				perror("execve");
> +				exit(1);
> +			}
> +		default:
> +			if (waitpid(pid, &st, 0) == -1)
> +				tst_brkm(TBROK|TERRNO, cleanup, "waitpid");
> +			if (!WIFEXITED(st) || WEXITSTATUS(st) != 0)
> +				tst_brkm(TBROK, cleanup,
> +					"child exited abnormally");
> +		}
> +	}
> +	tst_resm(TPASS, "system didn't crash, pass.");
> +	cleanup();
> +	tst_exit();
> +}
> +
> +static void setup()
> +{

Please void into prototypes here as well eg: static void setup(void)

> +	if (access("/bin/true", F_OK) == -1)
> +		tst_brkm(TBROK, NULL, "/bin/true not exist");

Should rather be "/bin/true does not exists" and maybe TCONF rather than
TBROK.

> +	ps = sysconf(_SC_PAGESIZE);
> +	length = 32 * ps;
> +	arg = malloc(length * sizeof(char));

sizeof(char) is 1 by definition

> +	if (arg == NULL)
> +		tst_brkm(TBROK|TERRNO, NULL, "malloc");
> +
> +	tst_sig(FORK, DEF_HANDLER, cleanup);
> +	TEST_PAUSE;
> +}
> +
> +static void cleanup()

Here void as vell.

> +{
> +	TEST_CLEANUP;
> +}

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
WhatsUp Gold - Download Free Network Management Software
The most intuitive, comprehensive, and cost-effective network 
management toolset available today.  Delivers lowest initial 
acquisition cost and overall TCO of any competing solution.
http://p.sf.net/sfu/whatsupgold-sd
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
