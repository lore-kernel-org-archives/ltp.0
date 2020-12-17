From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 17 Dec 2020 14:25:59 +0100
Subject: [LTP] [PATCH] fastopen: add require to sch_netem driver
In-Reply-To: <20201217085852.26032-1-kory.maincent@bootlin.com>
References: <20201217085852.26032-1-kory.maincent@bootlin.com>
Message-ID: <X9tcZzYQUkkw6abP@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Kory,

> +TST_NEEDS_DRIVERS="sch_netem"
On my system also veth, xfrm_algo and xfrm_user are loaded.

veth is added because I use network namespaces based testing (I'll add it on
separate patch) and xfrm_algo is used xfrm_user.

Thus maybe add also xfrm_user?
TST_NEEDS_DRIVERS="sch_netem xfrm_user"

Kind regards,
Petr
