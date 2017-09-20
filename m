From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 20 Sep 2017 19:29:00 +0300
Subject: [LTP] [PATCH 1/1] network/stress: Fix and cleanup part of
 multicast group tests
In-Reply-To: <20170911210835.25381-1-pvorel@suse.cz>
References: <20170911210835.25381-1-pvorel@suse.cz>
Message-ID: <5d42c8a0-eff6-9e25-4f26-eb30772e6675@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 09/12/2017 12:08 AM, Petr Vorel wrote:
> * Fix test for SSH and netns based testing.
> * Remove hardcoded rsh dependency.
> * Create shell library mcast-lib.sh (multicast specific) to reduce
> duplicity in tests. Library uses test_stress_net.sh (and therefore
> test_net.sh).
> * Merged IPv4 and IPv6 tests into one file.
> * Renamed test names and files (readability).
> * Cleanup code + fixed typos.
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Changes from "Simplify network setup v9" [1]:
> * mcast4-lib.sh use both IPv4 and IPv6 (renamed to mcast-lib.sh).
> * Test names and scripts renamed.
>
> I'm not sure about parameters for ns-igmp_querier (IPv4) in
> do_multicast_test_multiple_join().  I'm using -m $MCAST_IPV4_ADDR for it, as
> I've been told [2], but original file
> testcases/network/stress/multicast/grp-operation/mcast4-grpope02 was didn't use
> it.
>
> [1]: http://lists.linux.it/pipermail/ltp/2017-September/005605.html
> [2]: http://lists.linux.it/pipermail/ltp/2017-July/005115.html
> ---
>  runtest/net_stress.multicast                       |  16 +-
>  .../multicast/grp-operation/00_Descriptions.txt    |  16 +-
>  .../grp-operation/mcast-group-multiple-socket      |  36 ++++
>  .../multicast/grp-operation/mcast-group-same-group |  28 +++
>  .../grp-operation/mcast-group-single-socket        |  28 +++
>  .../grp-operation/mcast-group-source-filter        |  28 +++
>  .../stress/multicast/grp-operation/mcast-lib.sh    | 155 ++++++++++++++
>  .../stress/multicast/grp-operation/mcast4-grpope01 | 211 -------------------
>  .../stress/multicast/grp-operation/mcast4-grpope02 | 220 --------------------
>  .../stress/multicast/grp-operation/mcast4-grpope03 | 207 -------------------
>  .../stress/multicast/grp-operation/mcast4-grpope04 | 226 ---------------------
>  .../stress/multicast/grp-operation/mcast6-grpope01 | 208 -------------------
>  .../stress/multicast/grp-operation/mcast6-grpope02 | 217 --------------------
>  .../stress/multicast/grp-operation/mcast6-grpope03 | 204 -------------------
>  .../stress/multicast/grp-operation/mcast6-grpope04 | 222 --------------------
>  .../network/stress/ns-tools/test_net_stress.sh     |   9 +-
>  16 files changed, 296 insertions(+), 1735 deletions(-)
>  create mode 100644 testcases/network/stress/multicast/grp-operation/mcast-group-multiple-socket
>  create mode 100644 testcases/network/stress/multicast/grp-operation/mcast-group-same-group
>  create mode 100644 testcases/network/stress/multicast/grp-operation/mcast-group-single-socket
>  create mode 100644 testcases/network/stress/multicast/grp-operation/mcast-group-source-filter
>  create mode 100644 testcases/network/stress/multicast/grp-operation/mcast-lib.sh
>  delete mode 100644 testcases/network/stress/multicast/grp-operation/mcast4-grpope01
>  delete mode 100644 testcases/network/stress/multicast/grp-operation/mcast4-grpope02
>  delete mode 100644 testcases/network/stress/multicast/grp-operation/mcast4-grpope03
>  delete mode 100644 testcases/network/stress/multicast/grp-operation/mcast4-grpope04
>  delete mode 100644 testcases/network/stress/multicast/grp-operation/mcast6-grpope01
>  delete mode 100644 testcases/network/stress/multicast/grp-operation/mcast6-grpope02
>  delete mode 100644 testcases/network/stress/multicast/grp-operation/mcast6-grpope03
>  delete mode 100644 testcases/network/stress/multicast/grp-operation/mcast6-grpope04
...
> +. mcast-lib.sh
> +
> +tst_resm TINFO "joining $MCASTNUM_HEAVY IPv$ipver multicast groups on multiple sockets"
> +
> +do_setup()
> +{
> +	# Increase the maximum number of open file descriptors
> +	[ $(ulimit -n) -lt $MCASTNUM_HEAVY ] && ROD ulimit -n $MCASTNUM_HEAVY

may be better exit with TCONF instead of "TBROK"?

> +
> +	mcast_setup $MCASTNUM_HEAVY
> +}
> +

...

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
> +MCAST_LCMD="ns-mcast_join"
> +MCAST_RCMD="ns-igmp_querier"
> +[ "$TST_IPV6" ] && MCAST_RCMD="ns-icmpv6_sender"
> +
> +mcast_setup4()
> +{
> +	local igmp_max_memberships="$1"
> +
> +	SYSFS_IGMP_MAX_MEMBERSHIPS=$(sysctl -b net.ipv4.igmp_max_memberships)
> +	SYSFS_IGMP_MAX_MSF=$(sysctl -b net.ipv4.igmp_max_msf)
> +	SYSFS_FORCE_IGMP_VERSION=$(sysctl -b net.ipv4.conf.$(tst_iface).force_igmp_version)
> +	SYSFS_ALL_FORCE_IGMP_VERSION=$(sysctl -b net.ipv4.conf.all.force_igmp_version)
> +
> +	[ "$igmp_max_memberships" -gt 5459 ] && tst_resm TWARN \
> +		"\$1 shouldn't be set higher than 5459 as it's used to set /proc/sys/net/ipv4/igmp_max_memberships"
> +
> +	ROD sysctl -qw net.ipv4.igmp_max_memberships=$igmp_max_memberships
> +	ROD sysctl -qw net.ipv4.igmp_max_msf=10
> +	ROD sysctl -qw net.ipv4.conf.$(tst_iface).force_igmp_version=0
> +	ROD sysctl -qw net.ipv4.conf.all.force_igmp_version=0
> +}
> +
> +mcast_setup6()
> +{
> +	local default_mld_max_msf=64
> +	tst_kvcmp -lt '2.6.15' && default_mld_max_msf=10
> +
> +	SYSCTL_ALL_FORCE_MLD_VERSION=$(sysctl -qw net.ipv6.conf.all.force_mld_version)
> +	SYSCTL_FORCE_MLD_VERSION=$(sysctl -qw net.ipv6.conf.$(tst_iface).force_mld_version)
> +	SYSCTL_MLD_MAX_MSF=$(sysctl -qw net.ipv6.mld_max_msf)

looks like a typo, should be '-b' instead of '-qw'

> +
> +	ROD sysctl -qw net.ipv6.conf.all.force_mld_version=0
> +	ROD sysctl -qw net.ipv6.conf.$(tst_iface).force_mld_version=0
> +	ROD sysctl -qw net.ipv6.mld_max_msf=$default_mld_max_msf
> +}
> +
> +mcast_setup()
> +{
> +	local max="$1"
> +
> +	netstress_setup
> +	tst_tmpdir
> +
> +	[ "$TST_IPV6" ] && mcast_setup6 || mcast_setup4 $max
> +}
> +
> +mcast_cleanup4()
> +{
> +	[ -n "$SYSFS_IGMP_MAX_MEMBERSHIPS" ] && sysctl -qw net.ipv4.igmp_max_memberships=$SYSFS_IGMP_MAX_MEMBERSHIPS
> +	[ -n "$SYSFS_IGMP_MAX_MSF" ] && sysctl -qw net.ipv4.igmp_max_msf=$SYSFS_IGMP_MAX_MSF
> +	[ -n "$SYSFS_FORCE_IGMP_VERSION" ] && sysctl -qw net.ipv4.conf.$(tst_iface).force_igmp_version=$SYSFS_FORCE_IGMP_VERSION
> +	[ -n "$SYSFS_ALL_FORCE_IGMP_VERSION" ] && sysctl -qw net.ipv4.conf.all.force_igmp_version=$SYSFS_ALL_FORCE_IGMP_VERSION
> +}
> +
> +mcast_cleanup6()
> +{
> +	[ -n "$SYSCTL_ALL_FORCE_MLD_VERSION" ] && sysctl -qw net.ipv6.conf.all.force_mld_version=$SYSCTL_ALL_FORCE_MLD_VERSION
> +	[ -n "$SYSCTL_FORCE_MLD_VERSION" ] && sysctl -qw net.ipv6.conf.$(tst_iface).force_mld_version=$SYSCTL_FORCE_MLD_VERSION
> +	[ -n "$SYSCTL_MLD_MAX_MSF" ] && sysctl -qw net.ipv6.mld_max_msf=$SYSCTL_MLD_MAX_MSF
> +}
> +
> +mcast_cleanup()
> +{
> +	[ "$TST_IPV6" ] && mcast_cleanup6 || mcast_cleanup4
> +
> +	pkill -SIGHUP -x $MCAST_LCMD
> +	tst_sleep 10ms
> +	pkill -9 -x $MCAST_LCMD
> +
> +	tst_rhost_run -c "pkill -SIGHUP -x $MCAST_RCMD"
> +
> +	restore_ipaddr
> +	restore_ipaddr rhost

Is it really necessary to flush interfaces and reassign IP addresses
after the tests?

> +}
> +
> +do_multicast_test_multiple_join()
> +{
> +	local num="$1"
> +	local mprefix="$MCAST_IPV4_ADDR_PREFIX"
> +	local param_multi_socket ret tmpfile
> +
> +	[ "${2:-}" = true ] && param_multi_socket="-m"
> +	[ "$TST_IPV6" ] && mprefix="$MCAST_IPV6_ADDR_PREFIX"
> +
> +	# Run a multicast join tool
> +	tmpfile=$MCAST_LCMD.$$
> +	EXPECT_PASS $MCAST_LCMD $param_multi_socket -f $ipver -I $(tst_iface) -n $num -p $mprefix \> $tmpfile
> +	tst_resm TINFO "joined $(grep groups $tmpfile)"
> +
> +	# Send MLD / IGMP General Query from the remote host
> +	if [ "$TST_IPV6" ]; then
> +		EXPECT_RHOST_PASS $MCAST_RCMD -I $(tst_iface rhost) -S $(tst_ipaddr) -m -o
> +	else
> +		EXPECT_RHOST_PASS $MCAST_RCMD -I $(tst_iface rhost) -o -r 1 -m $MCAST_IPV4_ADDR

You could include parameters that won't change to $MCAST_RCMD, and the
same for $MCAST_LCMD.


Best regards,
Alexey
