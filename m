Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WjrmJ-0001hb-50
	for ltp-list@lists.sourceforge.net; Mon, 12 May 2014 15:04:31 +0000
Date: Mon, 12 May 2014 17:03:29 +0200
From: chrubis@suse.cz
Message-ID: <20140512150329.GG4741@rei>
References: <1399906092-28901-1-git-send-email-mats.liljegren@enea.com>
	<1399906092-28901-2-git-send-email-mats.liljegren@enea.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1399906092-28901-2-git-send-email-mats.liljegren@enea.com>
Subject: Re: [LTP] [PATCH 1/2] SAFE_POPEN: Added function to safe_stdio.h
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
To: Mats Liljegren <mats.liljegren@enea.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> +FILE *safe_popen(const char *file, const int lineno, void (cleanup_fn)(void),
> +		 const char *command, const char *type)
> +{
> +	FILE *stream;
> +	const int saved_errno = errno;
> +
> +	errno = 0;
> +	stream = popen(command, type);
> +
> +	if (stream == NULL) {
> +		if (errno != 0) {
> +			tst_brkm(TBROK | TERRNO, cleanup_fn,
> +				 "%s:%d: popen(%s,%s) failed",
> +				 file, lineno, command, type);
> +		} else {
> +			tst_brkm(TBROK, cleanup_fn,
> +				 "%s:%d: popen(%s,%s) failed: Out of memory",
> +				 file, lineno, command, type);
> +		}
> +	}
> +
> +	errno = saved_errno;

I've added missing return stream; here and pushed both patches, thanks.

> +}

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.
Get unparalleled scalability from the best Selenium testing platform available
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
