From: Petr Vorel <pvorel@suse.cz>
Date: Sun, 10 Jun 2018 12:23:08 +0200
Subject: [LTP] [PATCH 1/1] network.sh: Cleanup netpan logs
In-Reply-To: <20180610101309.8201-1-pvorel@suse.cz>
References: <20180610101309.8201-1-pvorel@suse.cz>
Message-ID: <20180610102308.GA10123@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> network.sh script doesn't delete it's logs, which can lead to fill /tmp.
> Remove these files, which unify behavior with runltp and runltplite.sh
> (just don't use trap to force remove on INT).

...
>  testscripts/network.sh | 2 ++
...
> @@ -121,3 +121,5 @@ if [ $? -eq "0" ]; then
>  else
>  	echo ltp-pan reported FAIL
>  fi
> +
> +rm -rf $TMPDIR

I suppose there is no reason to keep ltp-net logs, that it was left by accident.
This patch keeps /tmp/netpan.log, but that's just one file.


Kind regards,
Petr
