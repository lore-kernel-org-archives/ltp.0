Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZZHY0-0004y5-RZ
	for ltp-list@lists.sourceforge.net; Tue, 08 Sep 2015 11:58:48 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZZHXz-0001X7-OZ
	for ltp-list@lists.sourceforge.net; Tue, 08 Sep 2015 11:58:48 +0000
Date: Tue, 8 Sep 2015 13:58:02 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150908115801.GA3576@rei.suse.cz>
References: <1441386175-23123-1-git-send-email-yuriy.kolerov@synopsys.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1441386175-23123-1-git-send-email-yuriy.kolerov@synopsys.com>
Subject: Re: [LTP] [PATCH] Enable including config.mk and features.mk for
 *clean targets
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
To: Yuriy Kolerov <yuriy.kolerov@synopsys.com>
Cc: Anton.Kolesov@synopsys.com, ltp-list@lists.sourceforge.net, Francois.Bedard@synopsys.com

Hi!
> It's necessary for correct cleaning. E.g. open_posix_testsuite
> is not cleaned without including these .mk files. However it's
> not an error if these files does not exist while cleaning.
> 
> Signed-off-by: Yuriy Kolerov <yuriy.kolerov@synopsys.com>
> ---
>  include/mk/env_pre.mk | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 

> diff --git a/include/mk/env_pre.mk b/include/mk/env_pre.mk
> index f1584a8..a6beb5b 100644
> --- a/include/mk/env_pre.mk
> +++ b/include/mk/env_pre.mk
> @@ -94,11 +94,18 @@ ifeq ($(srcdir),)
>  srcdir				:= .
>  endif
>  
> -# autotools, *clean, and help don't require config.mk, features.mk, etc...
> -ifeq ($(filter autotools %clean .gitignore gitignore.% help,$(MAKECMDGOALS)),)
> +# autotools and help don't require config.mk, features.mk, etc...
> +ifeq ($(filter autotools .gitignore gitignore.% help,$(MAKECMDGOALS)),)
>  
> +# If config.mk and features.mk does not exist it's not an error for *clean
> +# targets.
> +ifeq ($(filter %clean,$(MAKECMDGOALS)),)
>  include $(abs_top_builddir)/include/mk/config.mk
>  include $(abs_top_builddir)/include/mk/features.mk
> +else
> +-include $(abs_top_builddir)/include/mk/config.mk
> +-include $(abs_top_builddir)/include/mk/features.mk
> +endif

Hmm, besides including the config.mk this also enables the out-of-tree
build checks and make 3.80 compatibility targets. Not that it's apriory
wrong but I would rather be more conservative and only include the
config.mk and features.mk.

One option would be to add the:

-include $(abs_top_builddir)/include/mk/config.mk
-include $(abs_top_builddir)/include/mk/features.mk

before the ifeq that filters out the autotools, clean, etc. targets.
What do you think?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
