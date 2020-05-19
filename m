From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 19 May 2020 08:43:14 +0200
Subject: [LTP] [PATCH 2/2] tst_test.sh: Warn about setup/cleanup
 function not loaded
In-Reply-To: <033366de-ed10-f494-600a-51aed8639613@jv-coder.de>
References: <20200518130132.19312-1-pvorel@suse.cz>
 <20200518130132.19312-2-pvorel@suse.cz>
 <033366de-ed10-f494-600a-51aed8639613@jv-coder.de>
Message-ID: <20200519064314.GA16972@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi J?rg,

> this looks good, just one small typo. And I guess I would raise this to
> TBROK, but that
> is just my personal preference :)
Yes, it could be. I thought TBROK would be for setup (tests results are probably
invalid without setup) and TWARN for cleanup (well, cleanup is important, but
results are valid, see other TWARN in tst_test.sh). But I want to be consistent
=> use TBROK.

> Am 18.05.2020 um 15:01 schrieb Petr Vorel:
> > +		if type "$TST_CLEANUP" >/dev/null 2>&1; then
> > +			$TST_CLEANUP
> > +		else
> > +			tst_res TWARN "cleanup function set (TST_SETUP='$TST_CLEANUP'), but not found (test bug)"
> This should probably be TST_CLEANUP=....
Thanks!

Kind regards,
Petr
