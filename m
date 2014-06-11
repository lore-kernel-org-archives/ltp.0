Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WujN8-0001Zn-RH
	for ltp-list@lists.sourceforge.net; Wed, 11 Jun 2014 14:19:26 +0000
Date: Wed, 11 Jun 2014 16:19:15 +0200
From: chrubis@suse.cz
Message-ID: <20140611141915.GA14882@rei.suse.cz>
References: <1401240926-4204-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1401240926-4204-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] containers/netns: enable IPv6 address
 autoconfiguration for veth interfaces
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
To: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> In some linux distributions, such as RHEL7U0RC1, when we create a veth pair
> by "ip link add type veth", the ipv6 address for veth interfaces won't be
> automatically generated, so the "par_chld_ipv6" test case in containers test
> will fail. This is because in these distirbutions, the "/proc/sys/net/ipv6/
> conf/veth*/disable_ipv6" is true for veth interfaces. Please see kernel
> "Documentation/networking/ip-sysctl.txt" for more detailed information.
> 
> In this patch, we will enable IPv6 address autoconfiguration for veth interfaces
> if disabled.
> +enable_veth_ipv6()
> +{
> +    local veth=$1
> +    local veth_ipv6_status=$(cat /proc/sys/net/ipv6/conf/$veth/disable_ipv6)
> +    if [ -z "$veth_ipv6_status" ];then
> +        tst_resm TFAIL "Error: cat /proc/sys/net/ipv6/conf/$veth/disable_ipv6"\
> +            "failed"
> +        exit 1
> +    elif [ "$veth_ipv6_status" = "1" ]; then
> +        echo 0 > /proc/sys/net/ipv6/conf/$veth/disable_ipv6
> +        if [ $? -ne 0 ];then
> +            tst_resm TFAIL "Error: set " \
> +                "/proc/sys/net/ipv6/conf/$veth/disable_ipv6 to 1 failed"
> +            exit 1
> +        fi
> +    fi
> +}
> diff --git a/testcases/kernel/containers/netns/paripv6.sh b/testcases/kernel/containers/netns/paripv6.sh
> index ac8ee57..25d780a 100755
> --- a/testcases/kernel/containers/netns/paripv6.sh
> +++ b/testcases/kernel/containers/netns/paripv6.sh
> @@ -55,6 +55,8 @@ status=0
>      else
>          debug "INFO: vnet0 = $vnet0 , vnet1 = $vnet1"
>      fi
> +    enable_veth_ipv6 $vnet0
> +    enable_veth_ipv6 $vnet1
>  
>  
>      ifconfig $vnet0 $IP1/24 up > /dev/null 2>&1

You should restore the system to previous state when the test finishes.
Can we set disable_ipv6 back if it was changed?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
HPCC Systems Open Source Big Data Platform from LexisNexis Risk Solutions
Find What Matters Most in Your Big Data with HPCC Systems
Open Source. Fast. Scalable. Simple. Ideal for Dirty Data.
Leverages Graph Analysis for Fast Processing & Easy Data Exploration
http://p.sf.net/sfu/hpccsystems
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
