Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sunyuan3@huawei.com>) id 1ZPh4H-000552-1X
	for ltp-list@lists.sourceforge.net; Thu, 13 Aug 2015 01:12:29 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZPh4A-0006b3-Vg
	for ltp-list@lists.sourceforge.net; Thu, 13 Aug 2015 01:12:29 +0000
Message-ID: <55CBEEDF.9050008@huawei.com>
Date: Thu, 13 Aug 2015 09:11:59 +0800
From: Yuan Sun <sunyuan3@huawei.com>
MIME-Version: 1.0
References: <1439347433-5102-1-git-send-email-liuhangbin@gmail.com>
In-Reply-To: <1439347433-5102-1-git-send-email-liuhangbin@gmail.com>
Subject: Re: [LTP] [PATCH] containers: fix dev name in create_veth()
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
To: Hangbin Liu <liuhangbin@gmail.com>, LTP List <ltp-list@lists.sourceforge.net>

It looks fine to me.
On 2015/8/12 10:43, Hangbin Liu wrote:
> The new version of iproute2 will show veth device like veth0@veth1, but we
> won't get a dev proc entry like this. Fix the dev name to avoid error like
> /proc/sys/net/ipv4/conf/veth0@veth1/proxy_arp: No such file or directory
>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>   testcases/kernel/containers/netns/netns_initialize.sh | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/testcases/kernel/containers/netns/netns_initialize.sh b/testcases/kernel/containers/netns/netns_initialize.sh
> index d44a02b..71d935a 100755
> --- a/testcases/kernel/containers/netns/netns_initialize.sh
> +++ b/testcases/kernel/containers/netns/netns_initialize.sh
> @@ -113,6 +113,8 @@ create_veth()
>       sleep 1
>       ip link show > /tmp/net2
>       eval `diff /tmp/net1 /tmp/net2 | awk -F": "  '/^> [0-9]*:/ { print "dev" i+0 "=" $2; i++  }'`
> +    dev0=$(echo $dev0 | cut -f1 -d'@')
> +    dev1=$(echo $dev1 | cut -f1 -d'@')
>   }
>   
>   # return 1 if disabled originally, 0 for enabled originally.


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
