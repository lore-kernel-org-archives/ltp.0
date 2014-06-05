Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WsUNX-00005R-0K
	for ltp-list@lists.sourceforge.net; Thu, 05 Jun 2014 09:54:35 +0000
Date: Thu, 5 Jun 2014 11:54:14 +0200
From: chrubis@suse.cz
Message-ID: <20140605095413.GA12025@rei>
References: <1401950028-7214-1-git-send-email-njoly@pasteur.fr>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1401950028-7214-1-git-send-email-njoly@pasteur.fr>
Subject: Re: [LTP] [PATCH] lstat/lstat03.c: Fix broken file type check
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
To: Nicolas Joly <njoly@pasteur.fr>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Signed-off-by: Nicolas Joly <njoly@pasteur.fr>
> ---
>  testcases/kernel/syscalls/lstat/lstat03.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/syscalls/lstat/lstat03.c b/testcases/kernel/syscalls/lstat/lstat03.c
> index d48d1ab..2d8716c 100644
> --- a/testcases/kernel/syscalls/lstat/lstat03.c
> +++ b/testcases/kernel/syscalls/lstat/lstat03.c
> @@ -131,7 +131,7 @@ int main(int ac, char **av)
>  		 */
>  		if ((stat_buf.st_uid != user_id) ||
>  		    (stat_buf.st_gid != group_id) ||
> -		    (!(stat_buf.st_mode && S_IFLNK)) ||
> +		    (!(stat_buf.st_mode & S_IFLNK)) ||

Good catch, although this is not yet correct. The file types are not
bitflags so the correct way here is:

	((stat_buf.st_mode & S_IFMT) != S_IFLNK)

I've corrected the patch and pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their 
applications. Written by three acclaimed leaders in the field, 
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
