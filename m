Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <chrubis@suse.de>) id 1Q7Xtk-0007Oe-LP
	for ltp-list@lists.sourceforge.net; Wed, 06 Apr 2011 18:56:12 +0000
Date: Wed, 6 Apr 2011 21:19:55 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110406191955.GA19123@saboteur.suse.cz>
References: <20110225103620.GA10350@hpt.nay.redhat.com>
	<AANLkTi=_K2Q1iYtN0T6izFmnmeEe1Tyyst1CzRHiN+Yg@mail.gmail.com>
	<20110307072901.GB2877@hpt.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110307072901.GB2877@hpt.nay.redhat.com>
Subject: Re: [LTP] [PATCH] thp testcase come from CVE reproducer
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
To: Han Pingtian <phan@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> > Not all systems have /bin/true. It would be better to do:
> > 
> > /bin/sh -c ':'
> > 
> > etc, as we have code that depends on this type of shell-required POSIX behavior.
> > 
> I'm sorry for I cannot figure out how to do this way. I tried, but
> cannot crash unpatched kernel anymore. So I think the simple workaround
> is checking if /bin/true installed in the program:

It should as simple as execve("/bin/sh -c ':'", c, c), or that didn't work?

What about "/bin/sh -c ''" ?

> +#include <stdio.h>
> +#include <unistd.h>
> +#include <string.h>
> +#include <sys/resource.h>
> +#include <sys/types.h>
> +#include <sys/wait.h>
> +
> +int main(int argc, char **argv) {

The curly bracked should be on new line here.

> +	int i, lc, st;
> +	pid_t pid;
> +	char *msg;
> +	char *c[257];
> +	char cc[32*4096];
> +	struct rlimit rl = {
> +		.rlim_cur = RLIM_INFINITY,
> +		.rlim_max = RLIM_INFINITY,
> +	};
> +
> +	if ((msg = parse_opts(argc, argv, NULL, NULL)) != NULL)
> +		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
> +
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +		switch (pid = fork()) {
> +			case -1:
> +				tst_brkm(TBROK|TERRNO, NULL, "fork");
> +			case 0:
> +				memset(cc, 'c', 32*4096-1);

Hmm should not the cc actually be C string and so terminated with '\0'?

> +				for (i=0;i<256;i++)
> +					c[i] = cc;
> +				if (setrlimit(RLIMIT_STACK, &rl) == -1)
> +					tst_brkm(TBROK|TERRNO, NULL, "setrlimit");
> +				if (execve("/bin/true", c, c) == -1)
> +					tst_brkm(TBROK|TERRNO, NULL, "execve");
> +			default:
> +				if (waitpid(pid, &st, 0) == -1)
> +					tst_brkm(TBROK|TERRNO, NULL, "waitpid");
> +
> +				if (! WIFEXITED(st))
> +					tst_brkm(TBROK, NULL, "child exits abnormally");

Please don't add space after ! here.

> +				if (WEXITSTATUS(st) == 2)
> +					tst_brkm(TBROK, NULL, "Do you have /bin/true installed?");
> +
> +				if (WEXITSTATUS(st) != 0)
> +					tst_brkm(TBROK, NULL, "chaild exits with non-zero value");
> +
> +				tst_resm(TPASS, "thp01 pass");
> +		}
> +	}
> +
> +        tst_exit();
> +}

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Xperia(TM) PLAY
It's a major breakthrough. An authentic gaming
smartphone on the nation's most reliable network.
And it wants your games.
http://p.sf.net/sfu/verizon-sfdev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
