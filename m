Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1VCmFX-0004sC-4l
	for ltp-list@lists.sourceforge.net; Fri, 23 Aug 2013 07:57:39 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VCmFT-0005yD-Sy
	for ltp-list@lists.sourceforge.net; Fri, 23 Aug 2013 07:57:39 +0000
Date: Fri, 23 Aug 2013 03:57:29 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <893330423.2949965.1377244649561.JavaMail.root@redhat.com>
In-Reply-To: <1377157309-23572-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <52122141.3020005@oracle.com>
	<1377157309-23572-1-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH V3 1/3] Added ALIGN, __ALIGN_MASK macroses
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
Cc: vasily isaenko <vasily.isaenko@oracle.com>, ltp-list@lists.sourceforge.net



----- Original Message -----
> From: "Stanislav Kholmanskikh" <stanislav.kholmanskikh@oracle.com>
> To: ltp-list@lists.sourceforge.net
> Cc: "vasily isaenko" <vasily.isaenko@oracle.com>, jstancek@redhat.com
> Sent: Thursday, 22 August, 2013 9:41:47 AM
> Subject: [PATCH V3 1/3] Added ALIGN, __ALIGN_MASK macroses
> 
> Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>

The series looks good to me. I also ran it on small NUMA system, it worked fine.
My only nit is this patch's subject, I believe plural of macro is macros :-).

Reviewed-by: Jan Stancek <jstancek@redhat.com>

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
>  /*
>   * lib/forker.c
>   */
> --
> 1.7.1
> 
> 

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
