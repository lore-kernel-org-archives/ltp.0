From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 17 Dec 2020 16:01:25 +0100
Subject: [LTP] [PATCH] fastopen: add require to sch_netem driver
In-Reply-To: <20201217152957.685200a9@kmaincent-XPS-13-7390>
References: <20201217085852.26032-1-kory.maincent@bootlin.com>
 <X9tcZzYQUkkw6abP@pevik>
 <20201217152957.685200a9@kmaincent-XPS-13-7390>
Message-ID: <X9tyxRv4QNlD9JH7@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Kory,

> > > +TST_NEEDS_DRIVERS="sch_netem"  
> > On my system also veth, xfrm_algo and xfrm_user are loaded.

> > veth is added because I use network namespaces based testing (I'll add it on
> > separate patch) and xfrm_algo is used xfrm_user.

> The xfrm_user driver seems not to be needed for the fastopen test.
Thanks for info. Correct, it's loaded by ip xfrm in tst_init_iface()
(which is not required since 250438496).

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
