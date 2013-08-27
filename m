Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VEHy0-0007Sx-AY
	for ltp-list@lists.sourceforge.net; Tue, 27 Aug 2013 12:01:48 +0000
Date: Tue, 27 Aug 2013 14:01:55 +0200
From: chrubis@suse.cz
Message-ID: <20130827120154.GF10995@rei.Home>
References: <893330423.2949965.1377244649561.JavaMail.root@redhat.com>
	<1377246401-17449-1-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1377246401-17449-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: Re: [LTP] [PATCH V3.1 1/3] Added ALIGN, __ALIGN_MASK macros
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
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
> ---
>  include/test.h |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/include/test.h b/include/test.h
> index d9eba31..a517ff9 100644
> --- a/include/test.h
> +++ b/include/test.h
> @@ -105,6 +105,12 @@
>  #define MAP_PRIVATE_EXCEPT_UCLINUX	MAP_PRIVATE
>  #endif
>  
> +/* Round x to the next multiple of a.
> + * a should be a power of 2.
> + */
> +#define ALIGN(x, a)	__ALIGN_MASK(x, (typeof(x))(a) - 1)
> +#define __ALIGN_MASK(x, mask)	(((x) + (mask)) & ~(mask))
> +

Generally looks good to me. I'm a bit concerned that macros named as
ALIGN() and __ALING_MASK() may eventually collide with some system
definiton. What about prefixing them with LTP_?

Also test.h is a bit crowded, what about adding them into compiler.h
instead?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Introducing Performance Central, a new site from SourceForge and 
AppDynamics. Performance Central is your source for news, insights, 
analysis and resources for efficient Application Performance Management. 
Visit us today!
http://pubads.g.doubleclick.net/gampad/clk?id=48897511&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
