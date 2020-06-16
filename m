From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 16 Jun 2020 17:31:16 +0200
Subject: [LTP] [PATCH v2 1/2] IMA: Add a test to verify measurment of
 keys
In-Reply-To: <20200612143842.3993-2-t-josne@linux.microsoft.com>
References: <20200612143842.3993-1-t-josne@linux.microsoft.com>
 <20200612143842.3993-2-t-josne@linux.microsoft.com>
Message-ID: <20200616153116.GA8754@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Lachlan,

Reviewed-by: Petr Vorel <pvorel@suse.cz>

..
> +++ b/testcases/kernel/security/integrity/ima/datafiles/keycheck.policy
> @@ -0,0 +1 @@
> +measure func=KEY_CHECK keyrings=.ima|.evm|.builtin_trusted_keys|.blacklist template=ima-buf
Thanks for this!
You don't use it, but that's ok, I'll add that policy handling myself after
merging. I have some notes about documentation / setup for both commits.

It would be nice to mention CONFIG_IMA_READ_POLICY=y in
testcases/kernel/security/integrity/ima/README.md as it's required.
That trivial thing I could do myself, but it'd help to add more info for setup
needed (and it's always preferred to do the setup, if possible, but for some
tests e.g. EVM testing in evm_overlay.sh it must be during the installation).

> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
> new file mode 100755
> index 000000000..f9c60a6fc
> --- /dev/null
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
> @@ -0,0 +1,65 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2020 Microsoft Corporation
> +# Author: Lachlan Sneff <t-josne@linux.microsoft.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
> +#
> +# Verify that keys are measured correctly based on policy.
> +
> +TST_NEEDS_CMDS="awk cut xxd"
nit: actually sed was meant to be added in this commit (I reported in previous
one).

Kind regards,
Petr
