Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <czhang@redhat.com>) id 1NL5da-0006ZU-4b
	for ltp-list@lists.sourceforge.net; Thu, 17 Dec 2009 01:58:42 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NL5dV-0003u5-71
	for ltp-list@lists.sourceforge.net; Thu, 17 Dec 2009 01:58:42 +0000
Date: Wed, 16 Dec 2009 20:46:06 -0500 (EST)
From: Caspar Zhang <czhang@redhat.com>
Message-ID: <1173683636.495591261014366483.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
In-Reply-To: <4B28C68C.1080304@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH 2/3] ade: fix the bug of ar01
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
To: liubo <liubo2009@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net


----- "liubo" <liubo2009@cn.fujitsu.com> wrote:

> Command "ar -tv" 's output doesn't match with "ls -ln" 's output on
> item
> "permission".
> 
> s/-$permissions/-$permissions./

This strange dot only appears in RHEL6, I don't see this dot in other
distros or releases.

Thanks,
Caspar

> 
> This patch fixed the bug.
> 
> Signed-off-by: Liu Bo <liubo2009@cn.fujitsu.com>
> 
> ---
>  testcases/commands/ade/ar/ar01 |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/testcases/commands/ade/ar/ar01
> b/testcases/commands/ade/ar/ar01
> index c8f85eb..c393959 100755
> --- a/testcases/commands/ade/ar/ar01
> +++ b/testcases/commands/ade/ar/ar01
> @@ -584,7 +584,7 @@ ar -tv $TCtmp/lib.a |
>  while
>  read permissions uid size month day time year file_name
>  do
> -echo "-$permissions;$uid;$size;$month;$day;$time;$file_name"
> +echo "-$permissions.;$uid;$size;$month;$day;$time;$file_name"
>  done >> $TCtmp/lib.a.stdout
>  ttest
>  
> -- 
> 1.6.2.2
> 
> 
> 
> 
> 
> 
> ------------------------------------------------------------------------------
> This SF.Net email is sponsored by the Verizon Developer Community
> Take advantage of Verizon's best-in-class app development support
> A streamlined, 14 day to market process makes app distribution fast
> and easy
> Join now and get one step closer to millions of Verizon customers
> http://p.sf.net/sfu/verizon-dev2dev 
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

-- 
/-------------------------------------------\
| Name: Caspar Zhang                        |
| Position: Kernel Qualification Engineer   |
| IRC: czhang on #kernel-qe, #eng-china     |
| Phone: +86-10-6260-8150                   |
| Cellphone: +86-1381-073-0090              |
\-------------------------------------------/


------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
