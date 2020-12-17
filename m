From: =?unknown-8bit?q?K=C3=B6ry?= Maincent <kory.maincent@bootlin.com>
Date: Thu, 17 Dec 2020 15:29:57 +0100
Subject: [LTP] [PATCH] fastopen: add require to sch_netem driver
In-Reply-To: <X9tcZzYQUkkw6abP@pevik>
References: <20201217085852.26032-1-kory.maincent@bootlin.com>
 <X9tcZzYQUkkw6abP@pevik>
Message-ID: <20201217152957.685200a9@kmaincent-XPS-13-7390>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

On Thu, 17 Dec 2020 14:25:59 +0100
Petr Vorel <pvorel@suse.cz> wrote:

> Hi Kory,
> 
> > +TST_NEEDS_DRIVERS="sch_netem"  
> On my system also veth, xfrm_algo and xfrm_user are loaded.
> 
> veth is added because I use network namespaces based testing (I'll add it on
> separate patch) and xfrm_algo is used xfrm_user.

The xfrm_user driver seems not to be needed for the fastopen test.

Regards,

K?ry 

> 
> Thus maybe add also xfrm_user?
> TST_NEEDS_DRIVERS="sch_netem xfrm_user"
> 
> Kind regards,
> Petr
