From: =?unknown-8bit?q?K=C3=B6ry?= Maincent <kory.maincent@bootlin.com>
Date: Fri, 29 Jan 2021 15:17:15 +0100
Subject: [LTP] [PATCH] sctp/func_test: add check on the sctp driver
In-Reply-To: <YBQR50ltZa+d1Or7@pevik>
References: <20210129090759.16534-1-kory.maincent@bootlin.com>
 <YBQR50ltZa+d1Or7@pevik>
Message-ID: <20210129151715.2a865703@kmaincent-XPS-13-7390>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

On Fri, 29 Jan 2021 14:47:19 +0100
Petr Vorel <pvorel@suse.cz> wrote:

> Hi Kory,
> 
> > +	if (tst_check_driver("sctp"))
> > +		tst_brkm(TCONF, tst_exit, "sctp driver not available");  
> Using tst_check_driver requires #include "tst_kernel.h".

Weird I did not get any build error and the binaries are built.
Maybe Yocto manage to build it even without the include.
Sorry for that.

Regards,

Kory
