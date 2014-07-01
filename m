Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1X1yWw-00077w-Mu
	for ltp-list@lists.sourceforge.net; Tue, 01 Jul 2014 13:55:30 +0000
Date: Tue, 1 Jul 2014 15:55:09 +0200
From: chrubis@suse.cz
Message-ID: <20140701135509.GA25542@rei.scz.novell.com>
References: <1404113603-19192-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1404113603-19192-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] syscalls: fix testcases which take TCONF as TFAIL
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
To: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> This issue was introduced by commit: 6f6878f4e1406d79cae53564777c5e1245d2a124
> In this commit, we took TCONF as a special state, to let user know the real
> LTP test coverage.
> 
> But setreuid04.c, setreuid05.c, setreuid07.c and setfsuid04.c do real test
> work in child process, if child process returns TCONF, parent process will
> get a non-zero return value, which will print TFAIL directly, so fix this.
> 
> Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>

Ah, it took me a little while to realize that the TCONF is returned from
the compat_16.h macros, you should probably mention it in the commit
message (because the rest of the code in the child does not use the tst
interface at all).

>  testcases/kernel/syscalls/setfsuid/setfsuid04.c | 23 ++++++++++++++++-----
>  testcases/kernel/syscalls/setreuid/setreuid04.c | 27 ++++++++++++++++++-------
>  testcases/kernel/syscalls/setreuid/setreuid05.c | 24 ++++++++++++++++------
>  testcases/kernel/syscalls/setreuid/setreuid07.c | 21 ++++++++++++++++---
>  4 files changed, 74 insertions(+), 21 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/setfsuid/setfsuid04.c b/testcases/kernel/syscalls/setfsuid/setfsuid04.c
> index 6818987..c774582 100644
> --- a/testcases/kernel/syscalls/setfsuid/setfsuid04.c
> +++ b/testcases/kernel/syscalls/setfsuid/setfsuid04.c
> @@ -58,7 +58,7 @@ int main(int ac, char **av)
>  {
>  	pid_t pid;
>  	const char *msg;
> -	int status;
> +	int status, ret;
>  
>  	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
>  		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
> @@ -74,10 +74,23 @@ int main(int ac, char **av)
>  
>  	if (waitpid(pid, &status, 0) == -1)
>  		tst_resm(TBROK | TERRNO, "waitpid failed");
> -	if (!WIFEXITED(status) || (WEXITSTATUS(status) != 0))
> -		tst_resm(TFAIL, "child process terminated abnormally");
> -	else
> -		tst_resm(TPASS, "Test passed");
> +
> +	if (WIFEXITED(status)) {
> +		ret = WEXITSTATUS(status);
> +		if (ret == TCONF) {
> +			tst_brkm(TCONF, cleanup, "child process return "
> +				 "TCONF");
> +		} else if (ret == TPASS) {
> +			tst_resm(TPASS, "test succeeded within"
> +				 "child process");
> +		} else {
> +			tst_resm(TFAIL, "test failed within"
> +				 "child process");
> +		}
> +	} else {
> +		tst_brkm(TBROK, cleanup, "child process terminated "
> +				 "abnormally. status: %d", status);
> +	}

The child code uses exit(1) directly, which coincidentally maps to the
TFAIL but we should be consistent and better use 1 here or TFAIL in the
child code.

Also this would be better written as a switch statement

	switch (ret) {
	case TPASS:
		...
	break;
	case TCONF:
		...
	break;
	default:
		tst_resm(TFAIL, "...");
	}

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Open source business process management suite built on Java and Eclipse
Turn processes into business applications with Bonita BPM Community Edition
Quickly connect people, data, and systems into organized workflows
Winner of BOSSIE, CODIE, OW2 and Gartner awards
http://p.sf.net/sfu/Bonitasoft
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
