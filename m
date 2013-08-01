Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1V4wIb-0001hq-3h
	for ltp-list@lists.sourceforge.net; Thu, 01 Aug 2013 17:04:25 +0000
Date: Thu, 1 Aug 2013 19:04:17 +0200
From: chrubis@suse.cz
Message-ID: <20130801170417.GA32528@rei.scz.novell.com>
References: <1C23526A7C42DB45BBF55B662C7C530E25B461FD20@BUNGLE.Emea.Arm.com>
	<20130730172427.GB1999@rei.scz.novell.com>
	<1C23526A7C42DB45BBF55B662C7C530E25B4AAF0D3@BUNGLE.Emea.Arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1C23526A7C42DB45BBF55B662C7C530E25B4AAF0D3@BUNGLE.Emea.Arm.com>
Subject: Re: [LTP] Where is defined TEST_ERRNO when 'make UCLINUX=1'?
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
To: Benoit Marcot <Benoit.Marcot@arm.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi!
> > That seems to be really messed up, so without UCLINUX the TEST_ERRNO is
> > defined in the header which is included in the test and in the library.
> > I wonder how that passes through the linker, that looks like redefinition to
> > me...
> >
> > And with UCLINUX it's does not look to be defined anywhere.
> >
> > Hmm, we should really clean up this part.
> 
> I have quickly patched my local working copy with the following change, but I am not really fond of this kind of nested conditions...
> 
> From 67bb4cc0a23c7a1c48acb85b49323edb9c93ff0a Mon Sep 17 00:00:00 2001
> From: Benoit Marcot < benoit.marcot@gmail.com >
> Date: Thu, 25 Jul 2013 15:45:17 +0100
> Subject: [PATCH] usctest.h: fix TEST_ERRNO definition when compiling with
>  'make UCLINUX=1'.
> 
> Compiling with 'make UCLINUX=1' adds -D_USC_LIB_, which make TEST_ERRNO declared as extern. This patch defines TEST_ERRNO.
> 
> Signed-off-by: Benoit Marcot <benoit.marcot@gmail.com>
> ---
>  include/usctest.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/usctest.h b/include/usctest.h
> index 90b124f..290b379 100644
> --- a/include/usctest.h
> +++ b/include/usctest.h
> @@ -157,7 +157,7 @@ struct usc_errno_t {
>   ****
>   ****
>   **********************************************************************/
> -#ifdef  _USC_LIB_
> +#if defined(_USC_LIB_) && (!defined(UCLINUX) || UCLINUX == 0)
> 
>  extern long TEST_RETURN;
>  extern int TEST_ERRNO;

The more I'm looking at the issue the more I think that the best
solution is to remove the ifdefs and left only the extern definitons
there and add the corresponding declaration somewhere into the library
sources, presumbly tst_res.c.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Get your SQL database under version control now!
Version control is standard for application code, but databases havent 
caught up. So what steps can you take to put your SQL databases under 
version control? Why should you start doing it? Read more to find out.
http://pubads.g.doubleclick.net/gampad/clk?id=49501711&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
