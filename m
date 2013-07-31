Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1V4XFL-0008NN-Lt
	for ltp-list@lists.sourceforge.net; Wed, 31 Jul 2013 14:19:23 +0000
Date: Wed, 31 Jul 2013 16:19:15 +0200
From: chrubis@suse.cz
Message-ID: <20130731141915.GA2698@rei.scz.novell.com>
References: <1374226012-16771-1-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1374226012-16771-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: Re: [LTP] [PATCH 1/2] tst_run_cmd: added support for stdout and
 stderr redirection
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
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net, alexey.kodanev@oracle.com

Hi!
> -void tst_run_cmd(void (cleanup_fn)(void), char *const argv[])
> +void tst_run_cmd(void (cleanup_fn)(void),
> +		char *const argv[],
> +		const char *stdout_path,
> +		const char *stderr_path)
>  {
>  	if (argv == NULL || argv[0] == NULL) {
>  		tst_brkm(TBROK, cleanup_fn,
> @@ -36,8 +40,20 @@ void tst_run_cmd(void (cleanup_fn)(void), char *const argv[])
>  		tst_brkm(TBROK | TERRNO, cleanup_fn, "vfork failed at %s:%d",
>  			__FILE__, __LINE__);
>  	}
> -	if (!pid)
> +	if (!pid) {
> +		/* redirecting stdout and stderr if needed */
> +		if ((stdout_path != NULL) &&
> +				(freopen(stdout_path, "a", stdout) == NULL))
> +			tst_resm(TWARN | TERRNO, "freopen failed at %s:%d",
> +					__FILE__, __LINE__);
> +
> +		if ((stderr_path != NULL) &&
> +				(freopen(stderr_path, "a", stderr) == NULL))
> +			tst_resm(TWARN | TERRNO, "freopen failed at %s:%d",
> +					__FILE__, __LINE__);

There is a slight problem bin this part of the code. As you did vfork()
the virtual memory is not duplicated in the child and only safe
operations you can do is, exec(), _exit() and operations that affects
file description table (which is one of the things that is duplicated,
or guaranteed to be copy on write after vfork()).

So we can't just freopen the streams as freopen() is not guaranteed not
to modify memory (The FILE* object for stdout may end up in inconsistent
state in parent because it was closed by freopen() in child), but we can
close the stdout and stderr in child and redirect them via dup2().

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Get your SQL database under version control now!
Version control is standard for application code, but databases havent 
caught up. So what steps can you take to put your SQL databases under 
version control? Why should you start doing it? Read more to find out.
http://pubads.g.doubleclick.net/gampad/clk?id=49501711&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
