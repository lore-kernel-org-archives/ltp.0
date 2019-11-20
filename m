From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 20 Nov 2019 13:29:10 +0100
Subject: [LTP] [PATCH 1/3] perf_event_open02: migrate to newlib
In-Reply-To: <53c6b3308d3e77fd95cae17b2a7ed1d4e8b2f60e.1574087532.git.jstancek@redhat.com>
References: <cover.1574087532.git.jstancek@redhat.com>
 <53c6b3308d3e77fd95cae17b2a7ed1d4e8b2f60e.1574087532.git.jstancek@redhat.com>
Message-ID: <20191120122910.GD14963@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> @@ -312,15 +238,13 @@ static void cleanup(void)
>  {
>  	int i;
>  
> -	for (i = 0; i < n; i++) {
> -		if (hwfd[i] > 0 && close(hwfd[i]) == -1)
> -			tst_resm(TWARN | TERRNO, "close(%d) failed", hwfd[i]);
> -		if (tskfd[i] > 0 && close(tskfd[i]) == -1)
> -			tst_resm(TWARN | TERRNO, "close(%d) failed", tskfd[i]);
> +	for (i = 0; i < ntotal; i++) {
> +		SAFE_CLOSE(hwfd[i]);
> +		SAFE_CLOSE(tskfd[i]);

Shouldn't we check that the hwfd[i] and tskfd[i] are > 0?

I guess that we may do SAFE_CLOSE(0) repeatedly here in a case that
perf_event_open() failed somewhere in the middle of the setup().

Otherwise this is a nice cleanup, acked.

-- 
Cyril Hrubis
chrubis@suse.cz
