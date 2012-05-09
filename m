Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1SS4Bz-0001i2-6X
	for ltp-list@lists.sourceforge.net; Wed, 09 May 2012 10:32:23 +0000
Received: from mail-pz0-f47.google.com ([209.85.210.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SS4Bv-0007TD-9d
	for ltp-list@lists.sourceforge.net; Wed, 09 May 2012 10:32:23 +0000
Received: by dalh21 with SMTP id h21so129961dal.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 09 May 2012 03:32:13 -0700 (PDT)
Message-ID: <4FAA4782.8040401@casparzhang.com>
Date: Wed, 09 May 2012 18:31:30 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <4FAA34CF.6050809@redhat.com>
In-Reply-To: <4FAA34CF.6050809@redhat.com>
Subject: Re: [LTP] [PATCH] move_pages08: E2BIG was removed in 2.6.29
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net, Jeffrey Burke <jburke@redhat.com>

On 05/09/2012 05:11 PM, Jan Stancek wrote:
> Following commit reworked do_pages_move() to work by page-sized
> chunks and also removed E2BIG:
> 
> commit 3140a2273009c01c27d316f35ab76a37e105fdd8
> Author: Brice Goglin <Brice.Goglin@inria.fr>
> Date:   Tue Jan 6 14:38:57 2009 -0800
>     mm: rework do_pages_move() to work on page_sized chunks
> 
> So, move_pages08 makes sense only for kernels < 2.6.29.
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  .../kernel/syscalls/move_pages/move_pages08.c      |   18 ++++++++++++++++--
>  1 files changed, 16 insertions(+), 2 deletions(-)
> 
> 
> 
> 
> 0001-move_pages08-E2BIG-was-removed-in-2.6.29.patch
> 
> 
> diff --git a/testcases/kernel/syscalls/move_pages/move_pages08.c b/testcases/kernel/syscalls/move_pages/move_pages08.c
> index a7ce6e4..f6f01d6 100644
> --- a/testcases/kernel/syscalls/move_pages/move_pages08.c
> +++ b/testcases/kernel/syscalls/move_pages/move_pages08.c
> @@ -46,7 +46,7 @@
>   *		Initial Version.
>   *
>   * Restrictions
> - *	None
> + *	kernel < 2.6.29
>   */
>  
>  #include <sys/mman.h>
> @@ -96,6 +96,20 @@ int main(int argc, char **argv)
>  		/* reset Tst_count in case we are looping */
>  		Tst_count = 0;
>  
> +		/*
> +		 * commit 3140a2273009c01c27d316f35ab76a37e105fdd8
> +		 * Author: Brice Goglin <Brice.Goglin@inria.fr>
> +		 * Date:   Tue Jan 6 14:38:57 2009 -0800
> +		 *     mm: rework do_pages_move() to work on page_sized chunks
> +		 *
> +		 * reworked do_pages_move() to work by page-sized chunks and removed E2BIG
> +		 */
> +		if ((tst_kvercmp(2, 6, 29)) >= 0) {
> +			tst_resm(TCONF, "move_pages: E2BIG was removed in "
> +			    "commit 3140a2273009c01c27d316f35ab76a37e105fdd8");
> +			break;
> +		}
> +

Hi Jan,

I think it would be better to put it in setup() function (as we usually
do the kvercmp in setup phase), and just use tst_brkm(TCONF. How do you
think?

Thanks,
Caspar

>  		ret = alloc_pages_on_node(pages, TEST_PAGES, from_node);
>  		if (ret == -1)
>  			continue;
> @@ -151,4 +165,4 @@ void cleanup(void)
>  	 */
>  	TEST_CLEANUP;
>  
> - }
> \ No newline at end of file
> + }
> 

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
