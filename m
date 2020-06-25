From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 25 Jun 2020 19:52:33 +0300
Subject: [LTP] [RESENT PATCH 4/5] net/test: Add basic testing for
 tst_rhost_run
In-Reply-To: <20200622070911.16123-5-petr.vorel@suse.com>
References: <20200622070911.16123-1-petr.vorel@suse.com>
 <20200622070911.16123-5-petr.vorel@suse.com>
Message-ID: <ddc1eb9d-af64-909e-bcc4-b7c7d5ddc7f1@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 22.06.2020 10:09, Petr Vorel wrote:
> From: Petr Vorel <pvorel@suse.cz>
> 
> Regression test for use of nested single quotes
> (fixed in previous commit).
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  lib/newlib_tests/shell/net/tst_rhost_run.sh | 25 +++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100755 lib/newlib_tests/shell/net/tst_rhost_run.sh
> 
> diff --git a/lib/newlib_tests/shell/net/tst_rhost_run.sh b/lib/newlib_tests/shell/net/tst_rhost_run.sh
> new file mode 100755
> index 000000000..4c034a4ac
> --- /dev/null
> +++ b/lib/newlib_tests/shell/net/tst_rhost_run.sh
> @@ -0,0 +1,25 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
> +
> +TST_TESTFUNC=do_test
> +PATH="$(dirname $0)/../../../../testcases/lib/:$PATH"
> +. tst_net.sh
> +
> +do_test()
> +{
> +	local file="/etc/fstab"
> +
> +	tst_rhost_run -c 'which grep > /dev/null' || \
> +		tst_res TCONF "grep not found on rhost"
> +
> +	tst_rhost_run -c "[ -f $file ]" || \
> +		tst_res TCONF "$file not found on rhost"
> +
> +	tst_rhost_run -s -c "grep -q \"[^ ]\" $file"
> +	tst_rhost_run -s -c "grep -q '[^ ]' $file"
> +
> +	tst_res TPASS "tst_rhost_run is working"
> +}
> +
> +tst_run
> 

Acked-by: Alexey Kodanev <alexey.kodanev@oracle.com>

