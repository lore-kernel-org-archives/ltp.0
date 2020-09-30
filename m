From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 30 Sep 2020 08:53:48 +0200
Subject: [LTP] [PATCH v3 2/4] IMA: Rewrite ima_boot_aggregate.c to new
 API
In-Reply-To: <4c0ec7617f2686ffdd4565a05beddd34ebf0b6aa.camel@linux.ibm.com>
References: <20200929165021.11731-1-pvorel@suse.cz>
 <20200929165021.11731-3-pvorel@suse.cz>
 <4c0ec7617f2686ffdd4565a05beddd34ebf0b6aa.camel@linux.ibm.com>
Message-ID: <20200930065348.GB21664@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Mimi,

> <snip>

> > diff --git a/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh b/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
> > index c69f891f1..dc958eb5c 100755
> > --- a/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
> > +++ b/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
> > @@ -33,7 +33,7 @@ test1()
> >  			tst_res TFAIL "bios boot aggregate is not 0"
> >  		fi
> >  	else
> > -		boot_aggregate=$(ima_boot_aggregate $tpm_bios | grep "boot_aggregate:" | cut -d':' -f2)
> > +		boot_aggregate=$(ima_boot_aggregate -f $tpm_bios | grep "sha1:" | cut -d':' -f2)
> >  		if [ "$boot_hash" = "$boot_aggregate" ]; then
> >  			tst_res TPASS "bios aggregate matches IMA boot aggregate"
> >  		else

> The original "ima" template is just the hash digest, without the
> algorithm.
Yes, but this code is output of ima_boot_aggregate.c. And code detecting old
format is still working (verified on ima_measurements.sh with ima_tcb kernel
parameter on 3.10).

Kind regards,
Petr
