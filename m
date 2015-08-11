Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZPEE0-0001kN-Vv
	for ltp-list@lists.sourceforge.net; Tue, 11 Aug 2015 18:24:36 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZPEDy-0007tx-7s
	for ltp-list@lists.sourceforge.net; Tue, 11 Aug 2015 18:24:36 +0000
Date: Tue, 11 Aug 2015 20:24:08 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150811182407.GD24227@rei.suse.de>
References: <1436424468-11756-1-git-send-email-alexey.kodanev@oracle.com>
	<1436424468-11756-18-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1436424468-11756-18-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH 17/23] network/virt: add test-case 01 to
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
> +# Check if we can create then delete virtual interface n times.
> +# virt_test_01 [OPTIONS]
> +# OPTIONS - different options separated by comma.
> +virt_test_01()
> +{
> +	start_id=1
> +	virt_count=500
> +
> +	local opts=${1:-""}
> +	local n=0
> +
> +	while ((1)); do

This does not work with dash, use "while true; do" instead.

> +		n=$((n + 1))
> +		p="$(echo $opts | cut -d',' -f$n)"
> +		if [ -z "$p" -a $n -gt 1 ]; then
> +			break
> +		fi
> +
> +		tst_resm TINFO "add $virt_type with '$p'"
> +
> +		virt_add ltp_v0 id 0 $p > /dev/null 2>&1
> +		if [ $? -ne 0 ]; then
> +			tst_resm TCONF "iproute/kernel doesn't support '$p'"
> +			p=""

Again shouldn't we just continue here instead?

> +		else
> +			ROD_SILENT "ip li delete ltp_v0"
> +		fi
> +
> +		virt_multiple_add_test "$p"
> +
> +		start_id=$(($start_id + $virt_count))
> +	done
> +}
> +
>  tst_require_root
>  
>  case "$virt_type" in
> diff --git a/testcases/network/virt/vlan01.sh b/testcases/network/virt/vlan01.sh
> index ac74463..fb96562 100755
> --- a/testcases/network/virt/vlan01.sh
> +++ b/testcases/network/virt/vlan01.sh
> @@ -16,7 +16,7 @@
>  #
>  # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
>  #
> -# Test-case 1: Local test, check if we can create 4095 VLAN interfaces.
> +# Local test, check if we can create 4000 VLAN interfaces.
>  #
>  
>  TCID=vlan01
> @@ -34,28 +34,9 @@ lb1="loose_binding on"
>  rh0="reorder_hdr off"
>  rh1="reorder_hdr on"
>  
> -opts="$p0 $lb0 $rh0,$p0 $lb0 $rh1,$p0 $lb1 $rh0,$p0 $lb1 $rh1,\
> +options="$p0 $lb0 $rh0,$p0 $lb0 $rh1,$p0 $lb1 $rh0,$p0 $lb1 $rh1,\
>  $p1 $lb0 $rh0,$p1 $lb0 $rh1,$p1 $lb1 $rh0,$p1 $lb1 $rh1,"
>  
> -start_id=1
> -virt_count=500
> -
> -for n in $(seq 1 8); do
> -	params="$(echo $opts | cut -d',' -f$n)"
> -
> -	tst_resm TINFO "add $virt_type with '$params'"
> -
> -	virt_add ltp_v0 id 0 $params > /dev/null 2>&1
> -	if [ $? -ne 0 ]; then
> -		tst_resm TCONF "iproute or kernel doesn't support '$params'"
> -		params=""
> -	else
> -		ROD_SILENT "ip li delete ltp_v0"
> -	fi
> -
> -	virt_multiple_add_test "$params"
> -
> -	start_id=$(($start_id + $virt_count))
> -done
> +virt_test_01 "$options"
>  
>  tst_exit
> diff --git a/testcases/network/virt/vxlan01.sh b/testcases/network/virt/vxlan01.sh
> index 63a52d0..4dfe3d7 100755
> --- a/testcases/network/virt/vxlan01.sh
> +++ b/testcases/network/virt/vxlan01.sh
> @@ -16,11 +16,11 @@
>  #
>  # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
>  #
> -# Test-case 1: Local test, check if we can create 5000 VXLAN interfaces.
> +# Local test, check if we can create 2500 VXLAN interfaces.
>  #
>  
>  TCID=vxlan01
> -TST_TOTAL=1
> +TST_TOTAL=5
>  
>  virt_type="vxlan"
>  start_id=16700000
> @@ -28,27 +28,9 @@ start_id=16700000
>  . test_net.sh
>  . virt_lib.sh
>  
> -opts="l2miss l3miss,norsc nolearning noproxy,ttl 0x01 tos 0x01,ttl 0xff tos 0xff,gbp"
> +options="l2miss l3miss,norsc nolearning noproxy,\
> +ttl 0x01 tos 0x01,ttl 0xff tos 0xff,gbp"
>  
> -start_id=1
> -virt_count=1000
> -
> -for n in $(seq 1 5); do
> -	params="$(echo $opts | cut -d',' -f$n)"
> -
> -	tst_resm TINFO "add $virt_type with '$params'"
> -
> -	virt_add ltp_v0 id 0 $params > /dev/null 2>&1
> -	if [ $? -ne 0 ]; then
> -		tst_resm TCONF "iproute or kernel doesn't support '$params'"
> -		params=""
> -	else
> -		ROD_SILENT "ip li delete ltp_v0"
> -	fi
> -
> -	virt_multiple_add_test "$params"
> -
> -	start_id=$(($start_id + $virt_count))
> -done
> +virt_test_01 "$options"
>  
>  tst_exit
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
