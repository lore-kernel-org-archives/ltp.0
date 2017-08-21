From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 21 Aug 2017 16:52:55 +0300
Subject: [LTP] [RFC PATCH v8 06/11] network/stress: Fix and cleanup part
 of multicast IPv4 tests
In-Reply-To: <20170818164437.13556-7-pvorel@suse.cz>
References: <20170818164437.13556-1-pvorel@suse.cz>
 <20170818164437.13556-7-pvorel@suse.cz>
Message-ID: <ef3c1e16-22fe-2572-85d8-cf30ed30cb17@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 08/18/2017 07:44 PM, Petr Vorel wrote:
> * Fix test for SSH and netns based testing.
> * Remove hardcoded rsh dependency.
> * Create shell library mcast4-lib.sh (multicast IPv4 specific)
>   to reduce duplicity in tests. Library uses test_stress_net.sh
>   (and therefore test_net.sh).
> * Cleanup code + fixed typos.
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  .../stress/multicast/grp-operation/mcast4-grpope01 | 221 ++-----------------
>  .../stress/multicast/grp-operation/mcast4-grpope02 | 230 ++------------------
>  .../stress/multicast/grp-operation/mcast4-grpope03 | 217 ++-----------------
>  .../stress/multicast/grp-operation/mcast4-grpope04 | 236 ++-------------------
>  .../stress/multicast/grp-operation/mcast4-lib.sh   | 118 +++++++++++
>  5 files changed, 196 insertions(+), 826 deletions(-)
>  create mode 100644 testcases/network/stress/multicast/grp-operation/mcast4-lib.sh
...
> -
> -wait
> -
> -#-----------------------------------------------------------------------
> -#
> -# Clean up
> -#
> +. mcast4-lib.sh
>  
> -tst_resm TPASS "Test is finished successfully."
> +tst_resm TINFO "joining and leaving the same IPv4 multicast group with a different source filter on $MCASTNUM_NORMAL sockets in $NS_TIMES times"
>  
> -exit 0
> +mcast_setup $MCASTNUM_NORMAL
> +do_multicast_test_join_leave true
> +tst_exit
> diff --git a/testcases/network/stress/multicast/grp-operation/mcast4-lib.sh b/testcases/network/stress/multicast/grp-operation/mcast4-lib.sh
> new file mode 100644
> index 000000000..0c74969cf
> --- /dev/null
> +++ b/testcases/network/stress/multicast/grp-operation/mcast4-lib.sh
> @@ -0,0 +1,118 @@
> +#!/bin/sh
> +# Copyright (c) International Business Machines  Corp., 2006
> +# Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
> +#
> +# This program is free software; you can redistribute it and/or
> +# modify it under the terms of the GNU General Public License as
> +# published by the Free Software Foundation; either version 2 of
> +# the License, or (at your option) any later version.
> +#
> +# This program is distributed in the hope that it would be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program. If not, see <http://www.gnu.org/licenses/>.
> +#
> +# Author: Petr Vorel <pvorel@suse.cz>
> +#
> +# Setup script for mcast4-grpope* tests.
> +
> +TST_TOTAL=1
> +TST_CLEANUP="mcast_cleanup"
> +
> +. test_net_stress.sh
> +
> +mcast_setup()
> +{
> +	local igmp_max_memberships="$1"
> +	local increase_max="${2:-}"
> +
> +	netstress_setup
> +	tst_tmpdir
> +
> +	SYSFS_IGMP_MAX_MEMBERSHIPS=$(sysctl -b net.ipv4.igmp_max_memberships)
> +	SYSFS_IGMP_MAX_MSF=$(sysctl -b net.ipv4.igmp_max_msf)
> +	SYSFS_FORCE_IGMP_VERSION=$(sysctl -b net.ipv4.conf.$(tst_iface).force_igmp_version)
> +	SYSFS_ALL_FORCE_IGMP_VERSION=$(sysctl -b net.ipv4.conf.all.force_igmp_version)
> +
> +	if [ "$increase_max" ]; then

"$increase_max" = "true"

> +		# Increase the maximum number of open file descriptors
> +		[ `ulimit -n` -lt $igmp_max_memberships ] && ROD ulimit -n $igmp_max_memberships
> +	fi
> +
> +	ROD sysctl -qw net.ipv4.igmp_max_memberships=$igmp_max_memberships
> +	ROD sysctl -qw net.ipv4.igmp_max_msf=10
> +	ROD sysctl -qw net.ipv4.conf.$(tst_iface).force_igmp_version=0
> +	ROD sysctl -qw net.ipv4.conf.all.force_igmp_version=0
> +}
> +
> +mcast_cleanup()
> +{
> +	[ -n "$SYSFS_IGMP_MAX_MEMBERSHIPS" ] && sysctl -qw net.ipv4.igmp_max_memberships=$SYSFS_IGMP_MAX_MEMBERSHIPS
> +	[ -n "$SYSFS_IGMP_MAX_MSF" ] && sysctl -qw net.ipv4.igmp_max_msf=$SYSFS_IGMP_MAX_MSF
> +	[ -n "$SYSFS_FORCE_IGMP_VERSION" ] && sysctl -qw net.ipv4.conf.$(tst_iface).force_igmp_version=$SYSFS_FORCE_IGMP_VERSION
> +	[ -n "$SYSFS_ALL_FORCE_IGMP_VERSION" ] && sysctl -qw net.ipv4.conf.all.force_igmp_version=$SYSFS_ALL_FORCE_IGMP_VERSION
> +
> +	pkill -SIGHUP -x ns-mcast_join
> +	tst_sleep 10ms
> +	pkill -9 -x ns-mcast_join
> +
> +	tst_rhost_run -c "pkill -SIGHUP -x ns-igmp_querier"
> +
> +	restore_ipaddr
> +	restore_ipaddr rhost
> +}
> +
> +do_multicast_test_multiple_join()
> +{
> +	local igmp_max_memberships="$1"
> +	local param_multi_socket ret tmpfile
> +
> +	[ "${2:-}" = true ] && param_multi_socket="-m"
> +
> +	# Run a multicast join tool
> +	tmpfile=ns-mcast_join.$$
> +
> +	EXPECT_PASS ns-mcast_join $param_multi_socket -f 4 -I $(tst_iface) -n $igmp_max_memberships -p $MCAST_IPV4_ADDR_PREFIX \> $tmpfile
> +
> +	tst_resm TINFO "joined $(grep groups $tmpfile)"
> +
> +	# Send IGMP General Query from the remote host
> +	EXPECT_RHOST_PASS ns-igmp_querier -I $(tst_iface rhost) -o -r 1 -m $MCAST_IPV4_ADDR
> +}
> +
> +do_multicast_test_join_leave()
> +{
> +	local define_source_address filter num ret source_addr x y
> +
> +	[ "$1" = true ] && define_source_address=true
> +
> +	# Send IGMP General Query from the remote host
> +	tst_rhost_run -s -c "ns-igmp_querier -I $(tst_iface rhost) -i 1000000000 -r 1 -b"
> +
> +	# Run a multicast join tool
> +	num=0
> +	while [ $num -lt $MCASTNUM_NORMAL ]; do
> +		if [ "$define_source_address" ]; then
> +			x=$(($num / 254))
> +			y=$(($num % 254 + 1))
> +			if [ $x -gt 254 ]; then
> +				tst_resm TINFO "the number of the connection is less than $num"
> +				break
> +			fi
> +			source_addr="${IPV4_NET16_UNUSED}.${x}.${y}"

tst_ipaddr_un()?


> +
> +			[ $(($num % 5)) -ne 2 ] && filter="include" || filter="exclude"
> +			params="-F $filter -s $source_addr"
> +		fi
> +
> +		ns-mcast_join -f 4 -I $(tst_iface) -l $NS_TIMES -a $MCAST_IPV4_ADDR $params &
> +		num=$(($num + 1))
> +	done
> +
> +	wait
> +
> +	tst_resm TPASS "test is finished successfully"
> +}

Best regards,
Alexey

