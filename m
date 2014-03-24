Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WS9BB-0002vD-UD
	for ltp-list@lists.sourceforge.net; Mon, 24 Mar 2014 18:00:57 +0000
Date: Mon, 24 Mar 2014 19:00:32 +0100
From: chrubis@suse.cz
Message-ID: <20140324180032.GA21236@rei.suse.cz>
References: <1393599391-7653-1-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1393599391-7653-1-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH v2 1/2] network: vxlan: add new test
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> +user_name="root"
> +use_ssh=0
> +
> +ip_local=${IPV4_NETWORK}.${LHOST_IPV4_HOST}
> +ip_vxlan_local="192.168.124.1"
> +mac_vxlan_local="3A:1C:C0:A8:7C:01"
> +
> +ip_remote=${IPV4_NETWORK}.${RHOST_IPV4_HOST}
> +ip_vxlan_remote="192.168.124.2"
> +mac_vxlan_remote="3A:1C:C0:A8:7C:02"
> +
> +export RC=0
> +export TST_TOTAL=3
> +export TCID="vxlan01"
> +export TST_COUNT=0
> +
> +vxlan_max=5000
> +start_vni=16700000
> +clients_num=2
> +client_requests=500000
> +max_requests=10
> +srv_port=$(( $RANDOM % 28232 + 32768 ))
> +tdir="${LTPROOT}/testcases/bin/"

I keep telling everybody that this path must be part of the $PATH to run
a LTP testcase so all binaries from it should be started just by their
filename.

> +while getopts :hsx:i:r:c:R:p:n: opt; do
> +	case "$opt" in
> +	h)
> +		echo "Usage:"
> +		echo "h        help"
> +		echo "s        use ssh to run remote cmds"
> +		echo "x n      n is a number of VXLANs for tc1 and tc2"
> +		echo "i n      start VNI to use"
> +		echo "r n      client requests for TCP performance test"
> +		echo "c n      clients run concurrently in TCP perf"
> +		echo "R n      num of reqs, after which conn.closed in TCP perf"
> +		echo "p x      x and x + 1 are ports in TCP perf"
> +		echo "n x      VXLAN network 192.168.x"
> +		exit 0
> +	;;
> +	s) use_ssh=1 ;;
> +	x) vxlan_max=$OPTARG ;;
> +	i) start_vni=$OPTARG ;;
> +	c) clients_num=$OPTARG ;;
> +	r) client_requests=$OPTARG ;;
> +	R) max_requests=$OPTARG ;;
> +	p) srv_port=$OPTARG ;;
> +	n)
> +		ip_vxlan_local="192.168.${OPTARG}.1"
> +		ip_vxlan_remote="192.168.${OPTARG}.2"
> +	;;
> +	*)
> +		tst_brkm TBROK NULL "unknown option: $opt"
> +		exit 2

It would be better to use the new test interface instead (which will
simplify the code a bit).

> +	;;
> +	esac
> +done
> +
> +tst_rhost_run()
> +{
> +	if [ "$use_ssh" -eq 1 ]; then
> +		ssh -n -f $user_name@$RHOST "sh -c 'nohup $@ &'" \
> +> /dev/null 2>&1
> +	else
> +		rsh -n -l $user_name $RHOST "sh -c 'nohup $@ &'" \
> +> /dev/null 2>&1
> +	fi
> +	return $?
> +}
> +
> +cleanup_and_exit()
> +{
> +	tst_resm TINFO "cleanup..."
> +	local vxlans=`ip link | sed -nE 's/^[0-9]+: (ltp_vxl[0-9]+):.+/\1/p'`

You should check that ip command exists on the machine (there likely are
older distros that are still missing it). And we have tst_check_cmds in
the new test library exactly for this.

> +	for vx in $vxlans; do
> +		ip link delete $vx
> +	done
> +
> +	if [ $TST_COUNT -ge 3 ]; then
> +		tst_rhost_run "ip link delete ltp_vxl0"
> +		tst_rhost_run "pkill -9 tcp_fastopen\$"
> +		pkill -9 "tcp_fastopen\$"
> +	fi
> +
> +	exit 2
> +}
> +trap "cleanup_and_exit" SIGINT
> +
> +safe_rhost_run()
> +{
> +	tst_rhost_run $@
> +	if [ $? -ne 0 ]; then
> +		tst_brkm TBROK NULL "No route to host $RHOST"
> +		cleanup_and_exit
> +	fi
> +}
> +
> +safe_run()
> +{
> +	$@ > /dev/null 2>&1
> +	if [ $? -ne 0 ]; then
> +		tst_brkm TBROK NULL "cmd failed: $@"
> +		cleanup_and_exit
> +	fi
> +}
> +
> +vxlan_test01()
> +{
> +	local tc="tc$TST_COUNT"
> +	local max=$(( $start_vni + $vxlan_max ))
> +	tst_resm TINFO "$tc: create $vxlan_max VXLANs, then delete them"
> +	local opt="group 239.1.1.1"
> +
> +	for (( i = $start_vni; i < $max; ++i )); do

This style for for loops is bash extension. Please use the `seq
$start_vni $max` syntax.

It may be a good idea to try to run the test using Debian dash shell.

> +		safe_run "ip link add ltp_vxl${i} type vxlan id $i $opt"
> +		safe_run "ip link set ltp_vxl${i} up"
> +	done
> +
> +	for (( i = $start_vni; i < $max; ++i )); do
> +		safe_run "ip link set ltp_vxl${i} down"
> +		safe_run "ip link delete ltp_vxl${i}"
> +	done
> +	tst_resm TPASS "$tc: done"
> +}
> +
> +vxlan_test02()
> +{
> +	local tc="tc$TST_COUNT"
> +
> +	local opt="group 239.1.1.1"
> +	tst_resm TINFO "$tc: creat, delete ltp_vxl1 $vxlan_max times"
> +	for (( i = 0; i < $vxlan_max; ++i )); do
> +		safe_run "ip link add ltp_vxl1 type vxlan id $start_vni $opt"
> +		safe_run "ip link set ltp_vxl1 up"
> +		safe_run "ip link delete ltp_vxl1"
> +	done
> +	tst_resm TPASS "$tc: done"
> +}
> +
> +tcp_test()
> +{
> +	local ip_addr=$1
> +	local rfile=$2
> +	local ret=0
> +	safe_rhost_run "${tdir}tcp_fastopen -R $max_requests \
> +-g $srv_port > /dev/null 2>&1"
> +	sleep 5
> +
> +	# run local tcp client
> +	${tdir}tcp_fastopen -a $clients_num -r $client_requests -l \
> +-H $ip_addr -g $srv_port -d $rfile > /dev/null 2>&1 || ret=1

Hmm, I wonder what is the tcp_fastopen test used here for? Generic
network load? Can't we do something simpler (ping, netcat, etc...)?

> +	if [ $ret -eq 0 -a ! -f $rfile ]; then
> +		tst_brkm TBROK NULL "can't read $rfile"
> +		cleanup_and_exit
> +	fi
> +
> +	srv_port=$(( $srv_port + 1 ))
> +	safe_rhost_run "pkill -9 tcp_fastopen\$"
> +
> +	return $ret
> +}
> +
> +vxlan_test03()
> +{
> +	local ret=0
> +	local tc="tc$TST_COUNT"
> +	tst_resm TINFO "$tc: virtual bridge & VXLAN, connect 2 hosts"
> +	local opt="rsc proxy nolearning"
> +
> +	safe_run "ip link add ltp_vxl0 type vxlan id $1 $opt"
> +	safe_run "ip link set ltp_vxl0 address $mac_vxlan_local"
> +	safe_run "ip address add ${ip_vxlan_local}/24 dev ltp_vxl0"
> +	safe_run "ip link set up ltp_vxl0"
> +
> +	safe_run "arp -s $ip_vxlan_remote $mac_vxlan_remote -i ltp_vxl0"
> +	safe_run "bridge fdb add to $mac_vxlan_remote dst $ip_remote dev ltp_vxl0"
> +
> +	safe_rhost_run "ip link add ltp_vxl0 type vxlan id $2 $opt"
> +	safe_rhost_run "ip link set ltp_vxl0 address $mac_vxlan_remote"
> +	safe_rhost_run "ip address add ${ip_vxlan_remote}/24 dev ltp_vxl0"
> +	safe_rhost_run "ip link set up ltp_vxl0"
> +
> +	safe_rhost_run "arp -s $ip_vxlan_local $mac_vxlan_local -i ltp_vxl0"
> +	safe_rhost_run "bridge fdb add to $mac_vxlan_local dst $ip_local \
> +dev ltp_vxl0"
> +
> +	sleep 2

What is this sleep here for?

> +	local rfile="${TMPDIR}/vxlan_result"
> +
> +	tcp_test $ip_vxlan_remote $rfile || ret=1
> +	safe_run "ip link delete ltp_vxl0"
> +	safe_rhost_run "ip link delete ltp_vxl0"
> +	[ $ret -eq 1 ] && return 1
> +	local vt=`cat $rfile`
> +
> +	tcp_test $ip_remote $rfile || return 1
> +	local lt=`cat $rfile`
> +
> +	tst_resm TINFO "$tc: time lan($lt) vxlan($vt) ms"
> +
> +	per=$(( $vt * 100 / $lt - 100 ))
> +	# In average cases (with small packets less then 150 bytes)
> +	# vxlan slower by 10-30%, set threshold to 40% so when value is
> +	# above it will be definitely an error in vxlan
> +	if [ "$per" -lt 40 ]; then
> +		tst_resm TINFO "$tc: vxlan slower by $per %"
> +	else
> +		tst_resm TINFO "$tc: vxlan too slow: by $per %"
> +		ret=1
> +	fi
> +
> +	return $ret
> +}
> +
> +if [ "`id -u`" -ne 0 ]; then
> +	tst_brkm TCONF NULL "test must be run as root"
> +	exit 0
> +fi

Please use tst_require_root from the test.sh library.

> +tst_kvercmp 3 8 0
> +if [ $? -eq 0 ]; then
> +	tst_brkm TCONF NULL "test must be run with kernel 3.8 or newer"
> +	exit 0
> +fi
> +
> +ip link add type vxlan help 2>&1 | grep -q "vxlan"
> +if [ $? -eq 1 ]; then
> +	tst_brkm TCONF NULL "iproute2 doesn't support vxlan"
> +	exit 0
> +fi
> +
> +modprobe vxlan > /dev/null 2>&1
> +if [ $? -ne 0 ]; then
> +	tst_brkm TCONF NULL "Test requiers vxlan module"
> +	exit 0
> +fi

Hmm, what happens when vxlan is build in kernel?

> +if [ ! -x ${tdir}tcp_fastopen ]; then
> +	tst_brkm TCONF NULL "can't find tcp_fastopen test"
> +	exit 0
> +fi

This should be done by the tst_check_cmds because the path to test
binaries is in $PATH.

> +if [ -z $ip_local -o -z $ip_remote ]; then
> +	tst_brkm TBROK NULL "you must specify IP address"
> +	exit 2
> +fi
> +
> +TST_COUNT=1
> +vxlan_test01
> +
> +TST_COUNT=2
> +vxlan_test02
> +
> +# Networks with the same VNI must work
> +res="TPASS"
> +TST_COUNT=3
> +# VNI is 24 bits long, so max value, which is not reserved, is 0xFFFFFE
> +vxlan_test03 "0xFFFFFE" "0xFFFFFE"
> +if [ $? -ne 0 ]; then
> +	res="TFAIL"
> +	RC=1
> +fi
> +tst_resm $res "tc$TST_COUNT: done"
> +
> +# Different VNI shall not work together, test must fail
> +res="TPASS"
> +TST_COUNT=4
> +vxlan_test03 "0xFFFFFE" "0xFFFFFD"
> +if [ $? -eq 0 ]; then
> +	res="TFAIL"
> +	RC=1
> +fi
> +tst_resm $res "tc$TST_COUNT: done"
> +
> +exit $RC

It would probably be better if we keep the rule one test per runtest
record here as well. What about moving common code to vxlan_lib.sh and
creating several vxlan testcases? (you can easily source the library
just by . vxlan_lib.sh becase the path is in $PATH).

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
