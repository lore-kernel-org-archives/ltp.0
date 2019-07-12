From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 12 Jul 2019 15:31:39 +0200
Subject: [LTP] [PATCH v4] Add a regression test for CVE-2017-1000380
In-Reply-To: <20190711141026.14705-1-mmoese@suse.de>
References: <20190711141026.14705-1-mmoese@suse.de>
Message-ID: <20190712133139.GA14566@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with a minor change, thanks.

> +static void cleanup(void)
> +{
> +	tst_fzsync_pair_cleanup(&fzsync_pair);

I've removed the tst_fzsync_pair_cleanup() here because the function is
no-op unless you started the second thread by the fzsync reste call.

> +	SAFE_CLOSE(snd_fd);
> +}


-- 
Cyril Hrubis
chrubis@suse.cz
