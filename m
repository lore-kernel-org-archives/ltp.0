Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1QwYsC-0003hO-UW
	for ltp-list@lists.sourceforge.net; Thu, 25 Aug 2011 12:17:28 +0000
Date: Thu, 25 Aug 2011 14:22:39 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110825122239.GC12466@saboteur.suse.cz>
References: <bb8dd0f8ab78cf55a124f99af36b0eea70f787a1.1314254883.git.czhang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bb8dd0f8ab78cf55a124f99af36b0eea70f787a1.1314254883.git.czhang@redhat.com>
Subject: Re: [LTP] [PATCH] syscalls/mmap11: mask broken test
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
To: Caspar Zhang <czhang@redhat.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

Hi!
> mmap11 is currently broken and we meet difficult to fix it perfectly.
> Mask the testcase for now.
> 
> Signed-off-by: Caspar Zhang <czhang@redhat.com>
> ---
>  runtest/syscalls |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 

> diff --git a/runtest/syscalls b/runtest/syscalls
> index 7989764..353f427 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -555,7 +555,9 @@ mmap06 mmap06
>  mmap07 mmap07
>  mmap08 mmap08
>  mmap09 mmap09
> -mmap11 mmap11 -i 30000
> +# Masked by Caspar Zhang <czhang@redhat.com>
> +# test is broken, mask it for now.
> +#mmap11 mmap11 -i 30000

Please omit the 'Masked by...' line. This info would be stored in the
git commit message and it's redundant here.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
EMC VNX: the world's simplest storage, starting under $10K
The only unified storage solution that offers unified management 
Up to 160% more powerful than alternatives and 25% more efficient. 
Guaranteed. http://p.sf.net/sfu/emc-vnx-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
