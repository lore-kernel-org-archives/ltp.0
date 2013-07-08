Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Uw97F-0000H6-AV
	for ltp-list@lists.sourceforge.net; Mon, 08 Jul 2013 10:56:21 +0000
Date: Mon, 8 Jul 2013 12:57:57 +0200
From: chrubis@suse.cz
Message-ID: <20130708105756.GC23579@rei.Home>
References: <1372912287-8610-1-git-send-email-gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1372912287-8610-1-git-send-email-gaowanlong@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] vma01: check kernel version
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
To: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Cc: Garrett Cooper <yanegomi@gmail.com>, LTP <ltp-list@lists.sourceforge.net>, Mike Frysinger <vapier@gentoo.org>

Hi!
> This is just a kernel behaviour change to avoid the possible
> scalability issue, not a real kernel bug. So, check the kernel
> version.
> 
> Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
> ---
>  testcases/kernel/mem/vma/vma01.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/mem/vma/vma01.c b/testcases/kernel/mem/vma/vma01.c
> index 7cd22c0..c6cb1f5 100644
> --- a/testcases/kernel/mem/vma/vma01.c
> +++ b/testcases/kernel/mem/vma/vma01.c
> @@ -192,7 +192,13 @@ static void check_status(int status)
>  		tst_resm(TPASS, "two 3*ps VMAs found.");
>  		break;
>  	case 1:
> -		tst_resm(TFAIL, "A single 6*ps VMA found.");
> +		if (tst_kvercmp(3, 0, 0) < 0) {
> +			tst_resm(TCONF, "A single 6*ps VMA found. You may need"
> +					" to back port kernel commit 965f55d "
> +					"to fix this scalability issue.");
> +		} else {
> +			tst_resm(TFAIL, "A single 6*ps VMA found.");
> +		}
>  		break;
>  	default:
>  		tst_brkm(TBROK, cleanup, "unexpected VMA found.");

This one looks fine.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
