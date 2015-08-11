Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZPEMD-00020h-0l
	for ltp-list@lists.sourceforge.net; Tue, 11 Aug 2015 18:33:05 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZPEMA-00088n-DU
	for ltp-list@lists.sourceforge.net; Tue, 11 Aug 2015 18:33:04 +0000
Date: Tue, 11 Aug 2015 20:32:36 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150811183236.GF24227@rei.suse.de>
References: <1436424468-11756-1-git-send-email-alexey.kodanev@oracle.com>
	<1436424468-11756-20-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1436424468-11756-20-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH 19/23] network/virt: add test-case 02 to
	virt_lib.sh
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
> diff --git a/testcases/network/virt/ipvlan01.sh b/testcases/network/virt/ipvlan01.sh
> index 706c1d8..156de78 100755
> --- a/testcases/network/virt/ipvlan01.sh
> +++ b/testcases/network/virt/ipvlan01.sh
> @@ -16,8 +16,8 @@
>  #
>  # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
>  #
> -# Test-case 1: Local test, check if we can create and then delete ipvlan
> -#              interface 500 times.
> +# Local test, check if we can create and then delete ipvlan
> +# interface 1000 times.
>  
>  TCID=ipvlan01
>  TST_TOTAL=2
> @@ -27,19 +27,8 @@ virt_type="ipvlan"
>  . test_net.sh
>  . virt_lib.sh
>  
> -modes="l2 l3"
> +options="mode l2,mode l3"
>  
> -start_id=1
> -virt_count=500
> -
> -for m in $modes; do
> -	tst_resm TINFO "add $virt_type with mode '$m'"
> -
> -	virt_check_cmd virt_add ltp_v0 mode $m || m=""
> -
> -	virt_add_delete_test "mode $m"
> -
> -	start_id=$(($start_id + $virt_count))
> -done
> +virt_test_02 "$options"
>  
>  tst_exit
> diff --git a/testcases/network/virt/macvlan01.sh b/testcases/network/virt/macvlan01.sh
> index 35febd0..402edde 100755
> --- a/testcases/network/virt/macvlan01.sh
> +++ b/testcases/network/virt/macvlan01.sh
> @@ -16,8 +16,8 @@
>  #
>  # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
>  #
> -# Test-case 1: Local test, check if we can create and then delete macvlan
> -#              interface 500 times.
> +# Local test, check if we can create and then delete macvlan
> +# interface 2000 times.
>  
>  TCID=macvlan01
>  TST_TOTAL=4
> @@ -27,19 +27,8 @@ virt_type="macvlan"
>  . test_net.sh
>  . virt_lib.sh
>  
> -modes="private vepa bridge passthru"
> +options="mode private,mode vepa,mode bridge,mode passthru"
>  
> -start_id=1
> -virt_count=500
> -
> -for m in $modes; do
> -	tst_resm TINFO "add $virt_type with mode '$m'"
> -
> -	virt_check_cmd virt_add ltp_v0 mode $m || m=""
> -
> -	virt_add_delete_test "mode $m"
> -
> -	start_id=$(($start_id + $virt_count))
> -done
> +virt_test_02 "$options"
>  
>  tst_exit
> diff --git a/testcases/network/virt/macvtap01.sh b/testcases/network/virt/macvtap01.sh
> index 8bb3636..3408c94 100755
> --- a/testcases/network/virt/macvtap01.sh
> +++ b/testcases/network/virt/macvtap01.sh
> @@ -16,8 +16,8 @@
>  #
>  # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
>  #
> -# Test-case 1: Local test, check if we can create and then delete macvtap
> -#              interface 500 times.
> +# Local test, check if we can create and then delete macvtap
> +# interface 2000 times.
>  
>  TCID=macvtap01
>  TST_TOTAL=4
> @@ -27,19 +27,8 @@ virt_type="macvtap"
>  . test_net.sh
>  . virt_lib.sh
>  
> -modes="private vepa bridge passthru"
> +options="mode private,mode vepa,mode bridge,mode passthru"
>  
> -start_id=1
> -virt_count=500
> -
> -for m in $modes; do
> -	tst_resm TINFO "add $virt_type with mode '$m'"
> -
> -	virt_check_cmd virt_add ltp_v0 mode $m || m=""
> -
> -	virt_add_delete_test "mode $m"
> -
> -	start_id=$(($start_id + $virt_count))
> -done
> +virt_test_02 "$options"
>  
>  tst_exit
> diff --git a/testcases/network/virt/virt_lib.sh b/testcases/network/virt/virt_lib.sh
> index 2ccba43..d79f7bc 100644
> --- a/testcases/network/virt/virt_lib.sh
> +++ b/testcases/network/virt/virt_lib.sh
> @@ -289,6 +289,34 @@ virt_test_01()
>  	done
>  }
>  
> +# Check if we can create then delete virtual interface n times.
> +# virt_test_02 [OPTIONS]
> +# OPTIONS - different options separated by comma.
> +virt_test_02()
> +{
> +	start_id=1
> +	virt_count=500
> +
> +	local opts=${1:-""}
> +	local n=0
> +
> +	while ((1)); do

while true; here as well

> +		n=$((n + 1))
> +		p="$(echo $opts | cut -d',' -f$n)"
> +		if [ -z "$p" -a $n -gt 1 ]; then
> +			break
> +		fi
> +
> +		tst_resm TINFO "add and then delete $virt_type with '$p'"
> +
> +		virt_check_cmd virt_add ltp_v0 $p || p=""
> +
> +		virt_add_delete_test "$p"
> +
> +		start_id=$(($start_id + $virt_count))
> +	done
> +}
> +
>  tst_require_root
>  
>  case "$virt_type" in
> diff --git a/testcases/network/virt/vlan02.sh b/testcases/network/virt/vlan02.sh
> index 0fb35a3..60addba 100755
> --- a/testcases/network/virt/vlan02.sh
> +++ b/testcases/network/virt/vlan02.sh
> @@ -16,8 +16,8 @@
>  #
>  # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
>  #
> -# Test-case 1: Local test, check if we can create and then delete VLAN
> -#              interface 4095 times.
> +# Local test, check if we can create and then delete VLAN
> +# interface 4095 times.
>  #
>  
>  TCID=vlan02
> diff --git a/testcases/network/virt/vxlan02.sh b/testcases/network/virt/vxlan02.sh
> index 1470495..0b3a21c 100755
> --- a/testcases/network/virt/vxlan02.sh
> +++ b/testcases/network/virt/vxlan02.sh
> @@ -16,8 +16,8 @@
>  #
>  # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
>  #
> -# Test-case 1: Local test, check if we can create and then delete VXLAN
> -#              interface 5000 times.
> +# Local test, check if we can create and then delete VXLAN
> +# interface 5000 times.
>  #
>  
>  TCID=vxlan02
> -- 
> 1.7.1
> 
> 
> ------------------------------------------------------------------------------
> Don't Limit Your Business. Reach for the Cloud.
> GigeNET's Cloud Solutions provide you with the tools and support that
> you need to offload your IT needs and focus on growing your business.
> Configured For All Businesses. Start Your Cloud Today.
> https://www.gigenetcloud.com/
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
