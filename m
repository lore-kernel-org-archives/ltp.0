From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 21 Jan 2021 15:44:06 +0100
Subject: [LTP] [PATCH] fs/lftest: Convert to new library
In-Reply-To: <964d7c42-dcdc-321b-9b4e-f0ae540eb5c1@jv-coder.de>
References: <20201215092534.757347-1-lkml@jv-coder.de> <YAa8D8iQwaQr2tAm@pevik>
 <964d7c42-dcdc-321b-9b4e-f0ae540eb5c1@jv-coder.de>
Message-ID: <YAmTNq1GFaMPU3f/@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi J?rg,

> Hi Petr,

> On 1/19/2021 12:01 PM, Petr Vorel wrote:
> > Not sure if anybody uses runtest/fs_readonly, but we still haven't
> > removed it.
> > Thus it must be also updated:

> > -test_robind54 test_robind.sh -c "lftest 80"
> > +test_robind54 test_robind.sh -c "lftest"
> Oh did not see that...
No big deal, these duplicities in runtest files are always confusing.
Looking forward a day when we replace runtest files with something better.

> The default parameter to lftest is now 100, so this should probably be
> +test_robind54 test_robind.sh -c "lftest -n 80
Correct.
> Don't know if it is important

No, it's probably not important, but merged with this change anyway.

> J?rg

Kind regards,
Petr
