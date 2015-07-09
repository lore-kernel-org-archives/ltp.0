Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1ZDE4f-0008HG-9z
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2015 15:49:21 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZDE4c-0001hd-Ep
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2015 15:49:21 +0000
Date: Thu, 9 Jul 2015 11:49:11 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1003432786.15130300.1436456951899.JavaMail.zimbra@redhat.com>
In-Reply-To: <20150709151457.GT17625@tarantula.localdomain>
References: <20150708203358.GA24428@tarantula.localdomain>
	<1538874773.14815420.1436428293231.JavaMail.zimbra@redhat.com>
	<20150709151457.GT17625@tarantula.localdomain>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH v2] proc/proc01.c: ignore stable_secret files
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
To: Jeffrey Bastian <jbastian@redhat.com>
Cc: ltp-list@lists.sourceforge.net





----- Original Message -----
> From: "Jeffrey Bastian" <jbastian@redhat.com>
> To: ltp-list@lists.sourceforge.net
> Sent: Thursday, 9 July, 2015 5:14:57 PM
> Subject: Re: [LTP] [PATCH v2] proc/proc01.c: ignore stable_secret files
> 
> Linux 4.1.0 introduced a per-NIC IPv6 stable_secret file for RFC7217.
> The stable_secret file for each NIC cannot be read until it is set,
> thus LTP fails like this:
> 
> proc01      1  TFAIL  :  proc01.c:392: read failed:
> /proc/sys/net/ipv6/conf/all/stable_secret: errno=EIO(5): Input/output error
> proc01      2  TFAIL  :  proc01.c:392: read failed:
> /proc/sys/net/ipv6/conf/default/stable_secret: errno=EIO(5): Input/output
> error
> proc01      3  TFAIL  :  proc01.c:392: read failed:
> /proc/sys/net/ipv6/conf/eno1/stable_secret: errno=EIO(5): Input/output error
> ...
> 
> Add the stable_secret files to the known_issues list in the proc01 test.
> 
> TODO: A future test should verify stable_secret functionality.
>   ~]# cat /proc/sys/net/ipv6/conf/eno1/stable_secret
>   cat: /proc/sys/net/ipv6/conf/eno1/stable_secret: Input/output error
>   ~]# echo "ffff:ffff:ffff:ffff:ffff:ffff:255.255.255.255" >
>   /proc/sys/net/ipv6/conf/eno1/stable_secret
>   ~]# cat /proc/sys/net/ipv6/conf/eno1/stable_secret
>   ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff
> 
> Signed-off-by: Jeffrey Bastian <jbastian@redhat.com>

Pushed.

Thanks,
Jan

> ---
>  testcases/kernel/fs/proc/proc01.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/testcases/kernel/fs/proc/proc01.c
> b/testcases/kernel/fs/proc/proc01.c
> index f513110eca0e..2825b51dff95 100644
> --- a/testcases/kernel/fs/proc/proc01.c
> +++ b/testcases/kernel/fs/proc/proc01.c
> @@ -107,6 +107,7 @@ static const struct mapping known_issues[] = {
>  	{"read", "/proc/fs/nfsd/.getfs", EINVAL},
>  	{"read", "/proc/fs/nfsd/.getfd", EINVAL},
>  	{"read", "/proc/self/net/rpc/use-gss-proxy", EAGAIN},
> +	{"read", "/proc/sys/net/ipv6/conf/*/stable_secret", EIO},
>  	{"", "", 0}
>  };
>  
> --
> 1.9.4
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
> 

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
