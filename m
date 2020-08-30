From: Petr Vorel <pvorel@suse.cz>
Date: Sun, 30 Aug 2020 18:31:50 +0200
Subject: [LTP] [LTP v4 3/5] IMA: Refactor datafiles directory
In-Reply-To: <20200828132825.GA12601@x230>
References: <20200820090824.3033-1-pvorel@suse.cz>
 <20200820090824.3033-4-pvorel@suse.cz>
 <20200828131856.GA29915@dell5510> <20200828132825.GA12601@x230>
Message-ID: <20200830163150.GA164224@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> > > +SUBDIRS	:= ima_*
> I guess this could fix it:
> SUBDIRS	:= $(shell ls ima_*) 
This didn't work. Fixed in 4231003f3.

Kind regards,
Petr
