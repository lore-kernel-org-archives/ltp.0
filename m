From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 25 Sep 2017 17:24:01 +0300
Subject: [LTP] [PATCH v2 1/1] network/stress: Fix and cleanup part of
 multicast group tests
In-Reply-To: <20170922100253.3742-1-pvorel@suse.cz>
References: <20170922100253.3742-1-pvorel@suse.cz>
Message-ID: <26dafb9d-cb08-d9f8-9ec6-12e8308b6f3a@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
On 09/22/2017 01:02 PM, Petr Vorel wrote:
...
> diff --git a/testcases/network/stress/multicast/grp-operation/mcast-lib.sh b/testcases/network/stress/multicast/grp-operation/mcast-lib.sh
> new file mode 100644
> index 000000000..fe70cdefe
> --- /dev/null
> +++ b/testcases/network/stress/multicast/grp-operation/mcast-lib.sh
> @@ -0,0 +1,155 @@
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
> +MCAST_LCMD_BASE="ns-mcast_join"
> +MCAST_RCMD_BASE="ns-igmp_querier"
> +[ "$TST_IPV6" ] && MCAST_RCMD_BASE="ns-icmpv6_sender"
> +
> +MCAST_LCMD="$MCAST_LCMD_BASE -f $ipver -I $(tst_iface)"
> +MCAST_RCMD="$MCAST_RCMD_BASE -I $(tst_iface rhost)"
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
> +	SYSCTL_ALL_FORCE_MLD_VERSION=$(sysctl -b net.ipv6.conf.all.force_mld_version)
> +	SYSCTL_FORCE_MLD_VERSION=$(sysctl -b net.ipv6.conf.$(tst_iface).force_mld_version)
> +	SYSCTL_MLD_MAX_MSF=$(sysctl -b net.ipv6.mld_max_msf)
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
> +	pkill -SIGHUP -x $MCAST_LCMD_BASE

Are *_BASE vars only needed here? We could search full command line with
"-f"
option, no need for adding new *_BASE variables:

  pkill -SIGHUP -f "$MCAST_LCMD"

Thanks,
Alexey

