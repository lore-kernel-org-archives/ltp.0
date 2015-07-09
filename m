Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1ZD6cQ-0002cI-Tc
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2015 07:51:42 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZD6cN-0002AJ-Lm
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2015 07:51:42 +0000
Date: Thu, 9 Jul 2015 03:51:33 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1538874773.14815420.1436428293231.JavaMail.zimbra@redhat.com>
In-Reply-To: <20150708203358.GA24428@tarantula.localdomain>
References: <20150708203358.GA24428@tarantula.localdomain>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] proc/proc01.c: ignore stable_secret files
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
> Sent: Wednesday, 8 July, 2015 10:33:58 PM
> Subject: [LTP] [PATCH] proc/proc01.c: ignore stable_secret files
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
> Ignore the stable_secret files in the proc01 test.

Can we add it to known_issues array instead? It looks like there's no problem
with opening/reading the file (in sense that would cause adverse effects,
e.g. hang the test).

Regards,
Jan

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
> ---
>  testcases/kernel/fs/proc/proc01.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/fs/proc/proc01.c
> b/testcases/kernel/fs/proc/proc01.c
> index f513110eca0e..b9ff3ac42fe2 100644
> --- a/testcases/kernel/fs/proc/proc01.c
> +++ b/testcases/kernel/fs/proc/proc01.c
> @@ -290,14 +290,15 @@ static long readproc(const char *obj)
>  			     dir_ent != NULL;
>  			     dir_ent = (struct dirent *)readdir(dir)) {
>  
> -				/* Ignore ".", "..", "kcore", and
> -				 * "/proc/<pid>" (unless this is our
> +				/* Ignore ".", "..", "kcore", "stable_secret",
> +                                 * and "/proc/<pid>" (unless this is our
>  				 * starting point as directed by the
>  				 * user).
>  				 */
>  				if (strcmp(dir_ent->d_name, ".") &&
>  				    strcmp(dir_ent->d_name, "..") &&
>  				    strcmp(dir_ent->d_name, "kcore") &&
> +				    strcmp(dir_ent->d_name, "stable_secret") &&
>  				    (fnmatch("[0-9]*", dir_ent->d_name,
>  					     FNM_PATHNAME) ||
>  				     strcmp(obj, procpath))) {
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
