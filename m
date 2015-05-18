Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YuJQC-0001aO-3y
	for ltp-list@lists.sourceforge.net; Mon, 18 May 2015 11:41:24 +0000
Date: Mon, 18 May 2015 13:40:42 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150518114042.GC4104@rei>
References: <1431515986-22287-1-git-send-email-weijg.fnst@cn.fujitsu.com>
	<1431515986-22287-2-git-send-email-weijg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1431515986-22287-2-git-send-email-weijg.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 2/5] testcases/kernel/syscalls/fcntl: use TERRNO
 flag
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
To: "Wei,Jiangang" <weijg.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> diff --git a/testcases/kernel/syscalls/fcntl/fcntl19.c b/testcases/kernel/syscalls/fcntl/fcntl19.c
> index a542cfc..5775684 100644
> --- a/testcases/kernel/syscalls/fcntl/fcntl19.c
> +++ b/testcases/kernel/syscalls/fcntl/fcntl19.c
> @@ -101,12 +101,11 @@ void setup(void)
>  	snprintf(template, PATH_MAX, "fcntl19XXXXXX");
>  
>  	if ((fd = mkstemp(template)) < 0) {
> -		tst_resm(TFAIL, "Couldn't open temp file! errno = %d", errno);
> +		tst_resm(TFAIL|TERRNO, "Couldn't open temp file!");

Technically this is a good change, but the code was broken beforehand.

The correct thing to do here is:

	tst_brkm(TBROK | TERRNO, cleanup, "Couldn't open temp file.");

Otherwise the testcase will attempt to call write() on fd == -1.

Moreover it can also do simple open instead of mkstemp() because the
temporary directory made with tst_tmpdir() is unique itself.

>  	}
>  
>  	if (write(fd, buf, STRINGSIZE) < 0) {
> -		tst_resm(TFAIL, "Couldn't write to temp file! errno = %d",
> -			 errno);
> +		tst_resm(TFAIL|TERRNO, "Couldn't write to temp file!");
>  	}

Here it could be changed to SAFE_WRITE();

>  	memset(&act, 0, sizeof(act));
> @@ -114,7 +113,7 @@ void setup(void)
>  	sigemptyset(&act.sa_mask);
>  	sigaddset(&act.sa_mask, SIGCLD);
>  	if ((sigaction(SIGCLD, &act, NULL)) < 0) {
> -		tst_resm(TFAIL, "SIGCLD signal setup failed, errno: %d", errno);
> +		tst_resm(TFAIL|TERRNO, "SIGCLD signal setup failed!");
>  		fail = 1;
>  	}
>  }
> @@ -203,7 +202,7 @@ void unlock_file(void)
>  	struct flock fl;
>  
>  	if (do_lock(F_SETLK, (short)F_UNLCK, (short)0, 0, 0) < 0) {
> -		tst_resm(TFAIL, "fcntl on file failed, errno =%d", errno);
> +		tst_resm(TFAIL|TERRNO, "fcntl on file failed!");
>  		fail = 1;
>  	}


Hmm, this should be tst_brkm(TBROK ... ); as well as this is not the
test but rather cleanup/preparation for next test.

Basically all cases where some prepartion fails should be TBROK rather
than TFAIL and should also exit the test if needed preparation steps
have failed.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
