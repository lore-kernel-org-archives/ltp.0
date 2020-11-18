From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 18 Nov 2020 22:27:37 +0100
Subject: [LTP] [PATCH v2 2/3] network/stress/multicast/query-flood:
 Convert to new API
In-Reply-To: <20201117124320.783802-2-lkml@jv-coder.de>
References: <20201117124320.783802-1-lkml@jv-coder.de>
 <20201117124320.783802-2-lkml@jv-coder.de>
Message-ID: <20201118212737.GC182229@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Joerg,

Thanks for v2!

Main info are reported by Alexey, few more notes below.

...
> +# Verify that the kernel is not crashed when joining a multicast group
> +# on a single socket, then receiving a large number of General Queries
nit: some sort of the description could be in 
tst_test TINFO message in do_setup() / do_test()

...
> +TST_NEEDS_ROOT=1
> +. mcast-lib.sh
> +
> +do_setup()
> +{
> +	mcast_setup $MCASTNUM_NORMAL
> +}
> +
> +do_test()
> +{
> +	local mcast_addr_prefix="$MCAST_IPV4_ADDR_PREFIX"
> +	[ "$TST_IPV6" ] && mcast_addr_prefix="$MCAST_IPV6_ADDR_PREFIX"
nit: maybe just $prefix is enough.
> +
> +	# Run a multicast join tool
> +	local tmpfile=$$
Please, when you need temporary files, use
TST_NEEDS_TMPDIR=1

> +	EXPECT_PASS $MCAST_LCMD -n 1 -p $mcast_addr_prefix \> $tmpfile
> +	tst_res TINFO "joined $(grep groups $tmpfile)"
> +
> +	# Send General Query from the remote host
> +	local params=""
nit: no need to add =""

...

Kind regards,
Petr
