From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 15 May 2019 13:32:29 +0200
Subject: [LTP] [PATCH v2 3/3] ima: Add overlay test
In-Reply-To: <810d4df7-1e5e-dd24-8b87-e0fa3edbd25f@suse.de>
References: <20190405165225.27216-1-pvorel@suse.cz>
 <20190405165225.27216-4-pvorel@suse.cz>
 <810d4df7-1e5e-dd24-8b87-e0fa3edbd25f@suse.de>
Message-ID: <20190515113229.GA22920@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Ignaz,

> thanks a lot for your continued work on the IMA / EVM tests and sorry for
> missing feedback - the mail got lost in my stack of TODO items.
Not a big deal and thanks a lot for a feedback and info.

> Am 05.04.19 um 18:52 Uhr schrieb Petr Vorel:
> > Should I check EVM enabled?

> As these tests require an appropriately prepared machine anyway: How about
> printing a message whether only IMA or both IMA and EVM are enabled. These
> tests make sense in both cases, so I wouldn't block them on either setup.

> > /sys/kernel/security/evm should be 1?

> Yes, that should be enough to detect whether EVM is enabled.

> > +test1()
> > +{
> > +	local file="foo1.txt"
> > +
> > +	tst_res TINFO "overwrite file in overlay"
> > +	ROD echo lower \> $lower/$file
> > +	EXPECT_PASS echo overlay \> $merged/$file

> It seems the redirection / escaping is wrong here: the string "overlay"
> never ends up in the target file.
I'm pretty sure that '>' should be escaped for both ROD and EXPECT_PASS.
EXPECT_PASS should fail (something like "evm_overlay 1 TFAIL: echo overlay ...
failed unexpectedly") if "overlay" string didn't get into $merged/$file file.
Can you sent whole output?

Kind regards,
Petr
