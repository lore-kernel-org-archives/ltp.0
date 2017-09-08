From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 8 Sep 2017 10:20:56 +0300
Subject: [LTP] [RFC PATCH v9 5/7] network/stress: Fix and cleanup part
 of multicast IPv4 tests
In-Reply-To: <20170824234436.18145-6-pvorel@suse.cz>
References: <20170824234436.18145-1-pvorel@suse.cz>
 <20170824234436.18145-6-pvorel@suse.cz>
Message-ID: <46938f85-d63c-42ae-35c8-97bdc7096fee@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 08/25/2017 02:44 AM, Petr Vorel wrote:
> * Fix test for SSH and netns based testing.
> * Remove hardcoded rsh dependency.
> * Create shell library mcast4-lib.sh (multicast IPv4 specific)
>   to reduce duplicity in tests. Library uses test_stress_net.sh
>   (and therefore test_net.sh).
> * Cleanup code + fixed typos.
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Although it's easy to convert these tests to handle both IPv4 and IPv6 I'll do it in a next patch-set.
> ---
>  .../stress/multicast/grp-operation/mcast4-grpope01 | 221 ++-----------------
>  .../stress/multicast/grp-operation/mcast4-grpope02 | 230 ++------------------
>  .../stress/multicast/grp-operation/mcast4-grpope03 | 217 ++-----------------
>  .../stress/multicast/grp-operation/mcast4-grpope04 | 236 ++-------------------
>  .../stress/multicast/grp-operation/mcast4-lib.sh   | 118 +++++++++++
>  5 files changed, 196 insertions(+), 826 deletions(-)
>  create mode 100644 testcases/network/stress/multicast/grp-operation/mcast4-lib.sh
>
> ...
> -
> -#-----------------------------------------------------------------------
> -#
> -# Clean up
> -#
> +. mcast4-lib.sh
>  
> -tst_resm TPASS "Test is finished successfully."
> +tst_resm TINFO "joining and leaving the same IPv4 multicast group with a different source filters on $MCASTNUM_NORMAL sockets in $NS_TIMES times"
>  
> -exit 0
> +mcast_setup $MCASTNUM_NORMAL
> +do_multicast_test_join_leave true
> +tst_exit
> diff --git a/testcases/network/stress/multicast/grp-operation/mcast4-lib.sh b/testcases/network/stress/multicast/grp-operation/mcast4-lib.sh
> new file mode 100644
> index 000000000..b3ef44baa
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
> +	if [ "$increase_max" = "true" ]; then
> +		# Increase the maximum number of open file descriptors
> +		[ $(ulimit -n) -lt $igmp_max_memberships ] && ROD ulimit -n $igmp_max_memberships
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
> +	local cnt define_src_addr filter params ret src_addr x y
> +
> +	[ "$1" = true ] && define_src_addr=true
> +
> +	# Send IGMP General Query from the remote host
> +	tst_rhost_run -s -c "ns-igmp_querier -I $(tst_iface rhost) -i 1000000000 -r 1 -b"
> +
> +	# Run a multicast join tool
> +	cnt=0
> +	while [ $cnt -lt $NS_TIMES ]; do
> +		if [ "$define_src_addr" ]; then
> +			x=$(($cnt / 254))
> +			y=$(($cnt % 254 + 1))
> +			if [ $x -gt 254 ]; then
> +				tst_resm TINFO "the number of the connection is less than $cnt"
> +				break
> +			fi
> +			src_addr=$(tst_ipaddr_un $x $y)
> +
> +			[ $((cnt % 5)) -ne 2 ] && filter="include" || filter="exclude"
> +			params="-F $filter -s $src_addr"


Why not params="-F $filter -s $(tst_ipaddr_un -c$cnt)"?

Thanks,
Alexey
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20170908/929f6c03/attachment.html>
