From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 5 Apr 2019 00:37:15 +0200
Subject: [LTP] [PATCH 3/3] ima: Add overlay test
In-Reply-To: <854e62ce-5e5c-7ea7-0291-0d3eaadf3fca@suse.de>
References: <20190327161638.7407-1-pvorel@suse.cz>
 <20190327161638.7407-4-pvorel@suse.cz>
 <854e62ce-5e5c-7ea7-0291-0d3eaadf3fca@suse.de>
Message-ID: <20190404223714.GA12544@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Ignaz,

> thanks a lot for the LTP integration!
thanks for testing and your comments!

> Am 27.03.19 um 17:16 Uhr schrieb Petr Vorel:
> > Based on reproducer made by Ignaz Forster <iforster@suse.de>
> > used for his not upstreamed patchset [1] and previous report [2].

> Just for clarification, as the test is only referring to IMA: With IMA
> everything should be working already, the problem during copy_up operations
> was fixed by Mimi and Goldwyn in
> https://patchwork.kernel.org/patch/10776231/.
> As expected the test passes on my IMA-only setup.

> My outstanding patchset is only necessary when combining IMA with EVM - in
> this case the test will still fail. I hope I'll be able to resume my work in
> the next few weeks.
I'll rename it to evm_overlay.sh.
BTW I got (with TST_NEEDS_DEVICE=1 in ima_overlay.sh) failure with ima_appraise_tcb kernel parameter:
[  741.070585] audit: type=1800 audit(1554415774.087:46): pid=1491 uid=0 auid=0 ses=3 op="appraise_data" cause="invalid-hash" comm="ima_overlay.sh" name="/tmp/LTP_ima_overlay.eZxnT8LMZ7/mntpoint/merged/foo.txt" dev="vda2" ino=3496 res=0

which looked to me as good error.
I didn't get any ima error with ima_policy=appraise_tcb, which is supposed to be
according to docs the same (and setup code in ima_policy.c looks to me like it:
both just set ima_use_appraise_tcb). I wonder, what is wrong in my setup.

BTW can you share your setup? ima_policy=appraise_tcb kernel parameter and
loading IMA and EVM keys over dracut-ima scripts? (IMA appraisal and EVM using
digital signatures? I guess using hashes for IMA appraisal would work as well)

> > +do_test()
> > +{
> > +	local file="foo.txt"
> > +	local f
> > +
> > +	tst_mount
> > +	mounted=1
> > +
> > +	ROD echo lower \> $lower/$file
> > +	if ! echo overlay > $merged/$file 2>/dev/null; then
> > +		tst_res TFAIL "Cannot write to merged layer"
> > +		return
> > +	fi

> I can think of two additional tests here:
> 1. Appending to a file (>> instead of >)
> 2. Creating a new file in the overlay

> These cases are using different code paths and may fail independently, so
> separate tests would be handy.

I'll add them into v2.

> Ignaz

Kind regards,
Petr
