Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1V72ZU-0005QT-0i
	for ltp-list@lists.sourceforge.net; Wed, 07 Aug 2013 12:10:32 +0000
Date: Wed, 7 Aug 2013 14:10:28 +0200
From: chrubis@suse.cz
Message-ID: <20130807121028.GB4761@rei>
References: <20130807102427.GA4389@rei>
	<1375874575-29198-1-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1375874575-29198-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: Re: [LTP] [PATCH] tst_run_cmd: const correctness
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
>  void tst_run_cmd_fds(void (cleanup_fn)(void),
> -			char *const argv[],
> +			const char *const argv[],
>  			int stdout_fd,
>  			int stderr_fd);
>  
> @@ -236,7 +236,7 @@ void tst_run_cmd_fds(void (cleanup_fn)(void),
>   * not needed.
>   */
>  void tst_run_cmd(void (cleanup_fn)(void),
> -		char *const argv[],
> +		const char *const argv[],
>  		const char *stdout_path,
>  		const char *stderr_path);

Gosh, that fixed the warning in the test but I've overlooked that
execvp() takes char *const argv[] argument so it introduced warning in
the lib. Now I wonder why execvp() has such strange parameter type...

I'm trying to figure out how to fix it 'right' but it gets unnecessary
complicated. I guess that we can fix this patch by casting the array in
the lib before it gets to execvp().

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite!
It's a free troubleshooting tool designed for production.
Get down to code-level detail for bottlenecks, with <2% overhead. 
Download for free and get started troubleshooting in minutes. 
http://pubads.g.doubleclick.net/gampad/clk?id=48897031&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
