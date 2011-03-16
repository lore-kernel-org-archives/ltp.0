Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <chrubis@suse.de>) id 1PzrjQ-00085W-Vx
	for ltp-list@lists.sourceforge.net; Wed, 16 Mar 2011 14:29:48 +0000
Date: Wed, 16 Mar 2011 15:51:43 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110316145143.GF2096@saboteur.suse.cz>
References: <1300284345-23533-1-git-send-email-czhang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1300284345-23533-1-git-send-email-czhang@redhat.com>
Subject: Re: [LTP] [PATCH 2/2] fs: fsstress: fix compile when -DNO_XFS
 disabled
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
To: czhang@redhat.com
Cc: ltp-list@lists.sourceforge.net

> Signed-off-by: Caspar Zhang <czhang@redhat.com>
> ---
>  testcases/kernel/fs/fsstress/Makefile   |    3 +++
>  testcases/kernel/fs/fsstress/fsstress.c |   16 ++++++++--------
>  testcases/kernel/fs/fsstress/global.h   |    4 ++--
>  3 files changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/testcases/kernel/fs/fsstress/Makefile b/testcases/kernel/fs/fsstress/Makefile
> index 0a53891..f6527ed 100644
> --- a/testcases/kernel/fs/fsstress/Makefile
> +++ b/testcases/kernel/fs/fsstress/Makefile
> @@ -27,6 +27,9 @@ include $(top_srcdir)/include/mk/env_pre.mk
>  CPPFLAGS			+= -DNO_XFS -I$(abs_srcdir) \
>  				   -D_LARGEFILE64_SOURCE -D_GNU_SOURCE
>  
> +# if removed -DNO_XFS, you should unmask the following line
> +#CPPFLAGS			+= -lattr

Dynamic libraries should be added to LDLIBS variable see doc/README.mk-devel.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Colocation vs. Managed Hosting
A question and answer guide to determining the best fit
for your organization - today and in the future.
http://p.sf.net/sfu/internap-sfd2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
