From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 4 Jul 2018 20:19:36 +0300
Subject: [LTP] [PATCH v3 8/9] net/{stress, virt}: Migrate virt_lib.sh,
 ipsec_lib.sh + tests using them
In-Reply-To: <20180703074209.911-9-pvorel@suse.cz>
References: <20180703074209.911-1-pvorel@suse.cz>
 <20180703074209.911-9-pvorel@suse.cz>
Message-ID: <bad96ab4-e879-24e5-baf2-abbee13ba9b5@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 03.07.2018 10:42, Petr Vorel wrote:
> It was needed to migrate it all in once, as macsec0{1,2}.sh tests are
> using both libraries.
> 
> This includes:
> * Create setup, getopts and helper function for both libraries.
> * Using TST_TEST_DATA and TST_TEST_DATA_IFS in many test cases
> (simplify tests and allow to have more TST_CNT to keep readability of
> output + required by udp_ipsec.sh and udp_ipsec_vti.sh otherwise it'd
> need to use getopts to determine type of udp, as passing parameter to
> tst_run is not not recommended to new API).
> * Put code into TST_TESTFUNC functions.
> * Move anything based on TST_IPV6 to TST_SETUP setup functions (as
> TST_IPV6 is not set until setup)
> 
> Other changes:
> * udp_ipsec{,_vti}.sh: were calling do_test() twice, with parameter.
> Now they use correctly TST_CNT and no params.
> Order of running tests changed. Before first were run udp tests for all
> items in $IPSEC_SIZE_ARRAY, then all udp_lite tests. Now for each item
> in $IPSEC_SIZE_ARRAY both udp and udp_lite tests are run.
> * gre01.sh: Move back device type setting (changed in 57738337a
> "network/gre01: fix device type setting").
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
...
> -TCID=geneve01
> -TST_TOTAL=1
>  TST_NEEDS_TMPDIR=1
>  TST_OPTS="hi:d:"

Do we need "hi:" options with the new lib? The same in the vxlan tests...

>  TST_PARSE_ARGS=virt_lib_parse_args
> @@ -16,26 +15,29 @@ start_id=16700000
>  # that is why using here 'vxlan_*' library functions.
>  vxlan_dst_addr="uni"
>  
...
> diff --git a/testcases/network/virt/virt_lib.sh b/testcases/network/virt/virt_lib.sh
> index 66f10bd41..c40747ac4 100644
> --- a/testcases/network/virt/virt_lib.sh
> +++ b/testcases/network/virt/virt_lib.sh
> @@ -1,5 +1,6 @@
>  #!/bin/sh
>  # SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
>  # Copyright (c) 2014-2017 Oracle and/or its affiliates. All Rights Reserved.
>  # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
>  #
> @@ -15,30 +16,52 @@
>  #          them in cleanup function. See "start_vni" variable which can
>  #          solve it.
>  
> +TST_SETUP="${TST_SETUP:-virt_lib_setup}"
> +TST_CLEANUP="${TST_CLEANUP:-cleanup_vifaces}"
> +trap "tst_brk TBROK 'test interrupted'" INT

"trap..." also included in the new lib.

The rest looks good.

Thanks,
Alexey
