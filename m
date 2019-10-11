From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 11 Oct 2019 10:20:43 +0200
Subject: [LTP] [PATCH 2/2] tst_test.sh: Add public tst_test_root command
In-Reply-To: <20191009113919.GB7561@rei.lan>
References: <20191009061619.48677-1-lkml@jv-coder.de>
 <20191009061619.48677-3-lkml@jv-coder.de>
 <20191009113919.GB7561@rei.lan>
Message-ID: <20191011082043.GA746@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> > +tst_test_root()
> > +{
> > +	if [ "$(id -ru)" != 0 ]; then
> > +		tst_brk TCONF "Must be super/root for this test!"
> > +	fi
> > +}

> Can we keep the name to be tst_require_root() please?
> Historically this function has been always named like this in LTP.
+1

Kind regards,
Petr
