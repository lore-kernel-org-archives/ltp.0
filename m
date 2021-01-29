From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 29 Jan 2021 15:24:09 +0100
Subject: [LTP] [PATCH] sctp/func_test: add check on the sctp driver
In-Reply-To: <20210129151715.2a865703@kmaincent-XPS-13-7390>
References: <20210129090759.16534-1-kory.maincent@bootlin.com>
 <YBQR50ltZa+d1Or7@pevik>
 <20210129151715.2a865703@kmaincent-XPS-13-7390>
Message-ID: <YBQaiVcZeV4g1I0w@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Kory,

> > > +	if (tst_check_driver("sctp"))
> > > +		tst_brkm(TCONF, tst_exit, "sctp driver not available");  
> > Using tst_check_driver requires #include "tst_kernel.h".

> Weird I did not get any build error and the binaries are built.
> Maybe Yocto manage to build it even without the include.
> Sorry for that.
It's safer to test build and patches also on x86_64 machine with typical linux
distro :).

Kind regards,
Petr
