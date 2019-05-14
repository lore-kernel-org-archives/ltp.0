From: Ignaz Forster <iforster@suse.de>
Date: Tue, 14 May 2019 20:42:05 +0200
Subject: [LTP] [PATCH v2 3/3] ima: Add overlay test
In-Reply-To: <20190405165225.27216-4-pvorel@suse.cz>
References: <20190405165225.27216-1-pvorel@suse.cz>
 <20190405165225.27216-4-pvorel@suse.cz>
Message-ID: <810d4df7-1e5e-dd24-8b87-e0fa3edbd25f@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

thanks a lot for your continued work on the IMA / EVM tests and sorry 
for missing feedback - the mail got lost in my stack of TODO items.

Am 05.04.19 um 18:52 Uhr schrieb Petr Vorel:
> Should I check EVM enabled?

As these tests require an appropriately prepared machine anyway: How 
about printing a message whether only IMA or both IMA and EVM are 
enabled. These tests make sense in both cases, so I wouldn't block them 
on either setup.

> /sys/kernel/security/evm should be 1?

Yes, that should be enough to detect whether EVM is enabled.

> +test1()
> +{
> +	local file="foo1.txt"
> +
> +	tst_res TINFO "overwrite file in overlay"
> +	ROD echo lower \> $lower/$file
> +	EXPECT_PASS echo overlay \> $merged/$file

It seems the redirection / escaping is wrong here: the string "overlay" 
never ends up in the target file.

> +}
> +
> +test2()
> +{
> +	local file="foo2.txt"
> +
> +	tst_res TINFO "append file in overlay"
> +	ROD echo lower \> $lower/$file
> +	EXPECT_PASS echo overlay \>\> $merged/$file

Same here: "overlay" never ends up in the target file.

Ignaz
