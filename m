From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 25 Jul 2017 18:21:27 +0300
Subject: [LTP] [RFC PATCH v7 06/11] network/stress: Fix and cleanup part
 of multicast IPv4 tests
In-Reply-To: <20170721040407.868-7-pvorel@suse.cz>
References: <20170721040407.868-1-pvorel@suse.cz>
 <20170721040407.868-7-pvorel@suse.cz>
Message-ID: <0dcefc85-5c3e-f8e4-12f0-4b3f61a63bde@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 07/21/2017 07:04 AM, Petr Vorel wrote:
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
>  .../stress/multicast/grp-operation/mcast4-lib.sh   | 129 +++++++++++
>  5 files changed, 207 insertions(+), 826 deletions(-)
>  create mode 100644 testcases/network/stress/multicast/grp-operation/mcast4-lib.sh
>
...
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
> +	local iface=$(tst_iface)
> +
> +	netstress_setup
> +	tst_tmpdir
> +
> +	SYSFS_IGMP_MAX_MEMBERSHIPS=$(sysctl -b net.ipv4.igmp_max_memberships)
> +	SYSFS_IGMP_MAX_MSF=$(sysctl -b net.ipv4.igmp_max_msf)
> +	SYSFS_FORCE_IGMP_VERSION=$(sysctl -b net.ipv4.conf.${iface}.force_igmp_version)
> +	SYSFS_ALL_FORCE_IGMP_VERSION=$(sysctl -b net.ipv4.conf.all.force_igmp_version)
> +
> +	if [ "$increase_max" ]; then
> +		# Increase the maximum number of open file descriptors
> +		[ `ulimit -n` -lt $igmp_max_memberships ] && ROD ulimit -n $igmp_max_memberships
> +	fi
> +
> +	tst_add_ipaddr_stress
> +	tst_add_ipaddr_stress rhost

This is very strange, the test adds a new pair of addresses and then
runs ping in setup. After that they not used...

By the way, we already have IP addresses defined by IPV4_HOST variables,
better use them if needed.


> +	check_connectivity $iface $RHOST_IPV4_UNUSED

No need for this test.

> +
> +	ROD sysctl -qw net.ipv4.igmp_max_memberships=$igmp_max_memberships
> +	ROD sysctl -qw net.ipv4.igmp_max_msf=10
> +	ROD sysctl -qw net.ipv4.conf.${iface}.force_igmp_version=0
> +	ROD sysctl -qw net.ipv4.conf.all.force_igmp_version=0
> +}
> +
> +mcast_cleanup()
> +{
> +	local iface=$(tst_iface)
> +
> +	[ -n "$SYSFS_IGMP_MAX_MEMBERSHIPS" ] && sysctl -qw net.ipv4.igmp_max_memberships=$SYSFS_IGMP_MAX_MEMBERSHIPS
> +	[ -n "$SYSFS_IGMP_MAX_MSF" ] && sysctl -qw net.ipv4.igmp_max_msf=$SYSFS_IGMP_MAX_MSF
> +	[ -n "$SYSFS_FORCE_IGMP_VERSION" ] && sysctl -qw net.ipv4.conf.${iface}.force_igmp_version=$SYSFS_FORCE_IGMP_VERSION
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
> +	local iface=$(tst_iface)
> +	local riface=$(tst_iface rhost)

I would rather use those functions inline.

> +	local param_multi_socket ret tmpfile
> +
> +	[ "${2:-}" = true ] && param_multi_socket="-m"
> +
> +	# Run a multicast join tool
> +	tmpfile=ns-mcast_join.$$
> +
> +	EXPECT_PASS ns-mcast_join $param_multi_socket -f 4 -I $iface -n $igmp_max_memberships -p $MCAST_IPV4_ADDR_PREFIX > $tmpfile

EXPECT_PASS ... \> $tmpfile

> +
> +	tst_resm TINFO "joined $(grep groups $tmpfile)"
> +
> +	# Send IGMP General Query from the remote host
> +	EXPECT_RHOST_PASS ns-igmp_querier -I $riface -o -r 1

We need to use the address defined with the prefix
$MCAST_IPV4_ADDR_PREFIX above otherwise we won't get a reply, i.e. "-m
$MCAST_IPV4_ADDR"

> +}
> +
> +do_multicast_test_join_leave()
> +{
> +	local iface=$(tst_iface)
> +	local riface=$(tst_iface rhost)
> +	local define_source_address filter num ret source_addr x y
> +
> +	[ "$1" = true ] && define_source_address=true
> +
> +	# Send IGMP General Query from the remote host
> +	tst_rhost_run -s -c "ns-igmp_querier -I $riface -i 1000000000 -r 1 -b"
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
> +
> +			[ $(($num % 5)) -ne 2 ] && filter="include" || filter="exclude"
> +			params="-F $filter -s $source_addr"
> +		fi
> +
> +		ROD ns-mcast_join -f 4 -I $iface -l $NS_TIMES -a $MCAST_IPV4_ADDR $params &


just ns-mcast_join ... &

> +		num=$(($num + 1))
> +	done
> +
> +	wait
> +
> +	tst_resm TPASS "test is finished successfully"
> +}


Thanks,
Alexey
