From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 18 Jun 2020 22:28:40 +0200
Subject: [LTP] [PATCH v3 1/2] IMA: Add a test to verify measurment of
 keys
In-Reply-To: <20200617234957.10611-2-t-josne@linux.microsoft.com>
References: <20200617234957.10611-1-t-josne@linux.microsoft.com>
 <20200617234957.10611-2-t-josne@linux.microsoft.com>
Message-ID: <20200618202840.GA175579@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Lachlan,

Reviewed-by: Petr Vorel <pvorel@suse.cz>

> +++ b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
> @@ -0,0 +1,67 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2020 Microsoft Corporation
> +# Author: Lachlan Sneff <t-josne@linux.microsoft.com>
> +#
> +# Verify that keys are measured correctly based on policy.
> +
> +TST_NEEDS_CMDS="grep mktemp cut sed tr"
This is already a dependency for tst_test.sh, but it does not harm to have it
here (in case we remove the dependency from tst_test.sh).
> +TST_CNT=1
> +TST_NEEDS_DEVICE=1
> +
> +. ima_setup.sh
> +
> +# Based on https://lkml.org/lkml/2019/12/13/564.
> +# (450d0fd51564 - "IMA: Call workqueue functions to measure queued keys")
> +test1()
> +{
> +	local keyrings keycheck_line templates test_file=$(mktemp)
Do we need mktemp? Can't it be just:
	local keyrings keycheck_line templates test_file="file.txt"

...
> +		echo "$line" | cut -d' ' -f6 | xxd -r -p > $test_file
Because you later just overwrite the file (simplicity).

I also try to keep shell dependencies low so it's possible to run it with in
dracut initramfs with rapido [1] without too many dependencies (although mktemp
is already tst_test.sh dependency).

> +
> +		expected_digest="$(compute_digest $algorithm $test_file)" || \
> +			tst_brk TCONF "cannot compute digest for $algorithm"
> +
> +		if [ "$digest" != "$expected_digest" ]; then
> +			tst_res TFAIL "incorrect digest was found for the ($keyring) keyring"
> +		fi
> +	done
> +
> +	rm $test_file
Again, IMHO no need to delete the file.

[1] https://github.com/rapido-linux/rapido

> +
> +	tst_res TPASS "specified keyrings were measured correctly"
This TPASS will be called even if there is previous TFAIL "incorrect digest was
found for the ($keyring) keyring". We should either exit testing with return,
or have variable to detect failure and not call this (not sure what makes more
sense).

Kind regards,
Petr
