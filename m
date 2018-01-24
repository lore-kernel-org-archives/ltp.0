From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 24 Jan 2018 12:18:34 +0100
Subject: [LTP] [PATCH 1/1] network/stress: Update README
In-Reply-To: <20170920092918.19960-1-pvorel@suse.cz>
References: <20170920092918.19960-1-pvorel@suse.cz>
Message-ID: <20180124111834.GB14773@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> networkstress.sh was merged into network.sh and then deleted in
> fddb4f3c7 ("network: remove outdated network runtests and scripts")
> 
> Also same of network stress tests use test_net.sh instead of using
> deprecated LTP_RSH.
> 
> This fixes #203.

Looks good, acked.

> Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
> ---
> I hate 'ltp-yyyymmdd/' path prefix, but I ignored it now.

I do not like it either about we changed that to ltp-* or ltp-foo?

-- 
Cyril Hrubis
chrubis@suse.cz
