Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZEwcQ-0001DE-KN
	for ltp-list@lists.sourceforge.net; Tue, 14 Jul 2015 09:35:18 +0000
Date: Tue, 14 Jul 2015 11:33:47 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150714093347.GB3729@rei.suse.de>
References: <1435910527-27802-1-git-send-email-liuhangbin@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1435910527-27802-1-git-send-email-liuhangbin@gmail.com>
Subject: Re: [LTP] [PATCH] network/stress/ns-tools: make PING_MAX times
	adjustable
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
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

Hi!
> Some switches need a while to learn the new assigned address, which make the
> connectivity check failed. Make PING_MAX adjustable to let user can pre-define
> it based on their own environment.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  testcases/network/stress/ns-tools/check_icmpv4_connectivity | 2 +-
>  testcases/network/stress/ns-tools/check_icmpv6_connectivity | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/network/stress/ns-tools/check_icmpv4_connectivity b/testcases/network/stress/ns-tools/check_icmpv4_connectivity
> index 7630aae..2daaea4 100644
> --- a/testcases/network/stress/ns-tools/check_icmpv4_connectivity
> +++ b/testcases/network/stress/ns-tools/check_icmpv4_connectivity
> @@ -47,7 +47,7 @@
>  $trace_logic
>  
>  # The max number of ICMP echo request
> -PING_MAX=10
> +PING_MAX=${PING_MAX:-"10"}

I do not like exposing random shell variables as interface without any
documentation. Can't we just increase the PING_MAX to make it work for
everybody without any extra work?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
