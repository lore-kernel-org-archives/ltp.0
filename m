Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <penght@cn.fujitsu.com>) id 1Pijdd-0007Qw-NB
	for ltp-list@lists.sourceforge.net; Fri, 28 Jan 2011 08:25:01 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1Pijdc-00028H-Af
	for ltp-list@lists.sourceforge.net; Fri, 28 Jan 2011 08:25:01 +0000
Message-ID: <4D427D32.8020801@cn.fujitsu.com>
Date: Fri, 28 Jan 2011 16:24:18 +0800
From: Peng Haitao <penght@cn.fujitsu.com>
MIME-Version: 1.0
References: <4D3017F9.7060307@cn.fujitsu.com>
In-Reply-To: <4D3017F9.7060307@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] Fix a building error.
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi Garrett,

  Would you like to apply this patch? 

  "%option nolex-compat" make the global variable "yylineno" undeclared, 
this will result in build error in RHEL4.8 and RHEL5.5.

  The environments are as follows:
  - RHEL4.8 --- x86_64
  - flex    --- version 2.5.4

  - RHEL5.5 --- (x86, x86_64, ia64)
  - flex    --- version 2.5.4


Peng Haitao said the following on 2011-1-14 17:31:
> Hi Garrett,
> 
> Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>
> ---
>  pan/scan.l |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/pan/scan.l b/pan/scan.l
> index 9696531..cc47bdf 100644
> --- a/pan/scan.l
> +++ b/pan/scan.l
> @@ -91,6 +91,7 @@ static int check_mode(int, int, ...);
>  %option noinput
>  %option nolex-compat
>  %option nounput
> +%option yylineno
>  
>  UI      [0-9]+
>  A       [a-zA-Z]+

-- 
Best Regards,
Peng Haitao


------------------------------------------------------------------------------
Special Offer-- Download ArcSight Logger for FREE (a $49 USD value)!
Finally, a world-class log management solution at an even better price-free!
Download using promo code Free_Logger_4_Dev2Dev. Offer expires 
February 28th, so secure your free ArcSight Logger TODAY! 
http://p.sf.net/sfu/arcsight-sfd2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
