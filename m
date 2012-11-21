Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1TbBiN-0007jR-Mu
	for ltp-list@lists.sourceforge.net; Wed, 21 Nov 2012 14:55:47 +0000
Date: Wed, 21 Nov 2012 15:53:07 +0100
From: chrubis@suse.cz
Message-ID: <20121121145306.GA5187@rei.suse.cz>
References: <1353490217-30332-1-git-send-email-penght@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1353490217-30332-1-git-send-email-penght@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] ar01: fix a bug of attribute "selinux" in rhel6
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
To: Peng Haitao <penght@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> When SELinux is enabled, "ls -ln" will list permissions with "-rw-r--r--.",
> but "ar -tv" will list permissions with "-rw-r--r--"???so the case 22 will fail.
> 
> Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>
> ---
>  testcases/commands/ade/ar/ar01 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/testcases/commands/ade/ar/ar01 b/testcases/commands/ade/ar/ar01
> index 948c1fe..32fef11 100755
> --- a/testcases/commands/ade/ar/ar01
> +++ b/testcases/commands/ade/ar/ar01
> @@ -536,7 +536,7 @@ do
>  	ls -ln --time-style=+%b" "%e" "%H:%M file1.in file2.in file3.in |
>  	while read permissions link uid gid size month day time file_name
>  	do
> -		echo "$permissions;$uid/$gid;$size;$month;$day;$time;$file_name"
> +		echo "${permissions%.};$uid/$gid;$size;$month;$day;$time;$file_name"
>  	done >>  $TCtmp/lib.a.exp
>  	ar -tv $TCtmp/lib.a |

Acked.

However please include a short description of the solution to the commit
log as well.

Something like "This patch removes the dot from the end of the
permission string if there was one."

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Monitor your physical, virtual and cloud infrastructure from a single
web console. Get in-depth insight into apps, servers, databases, vmware,
SAP, cloud infrastructure, etc. Download 30-day Free Trial.
Pricing starts from $795 for 25 servers or applications!
http://p.sf.net/sfu/zoho_dev2dev_nov
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
