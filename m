Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1TSpsj-0006FM-RG
	for ltp-list@lists.sourceforge.net; Mon, 29 Oct 2012 13:59:57 +0000
Date: Mon, 29 Oct 2012 14:57:32 +0100
From: chrubis@suse.cz
Message-ID: <20121029135732.GA12578@rei.suse.cz>
References: <1351502940-20415-1-git-send-email-cxie@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1351502940-20415-1-git-send-email-cxie@redhat.com>
Subject: Re: [LTP] [PATCH] thp/thp03: new testcase
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
To: cxie@redhat.com
Cc: ltp-list@lists.sourceforge.net

Hi!
> Modified form a reproducer for
>            https://patchwork.kernel.org/patch/1358441/

I would add this link as well as kernel commit hash to the
comment with testcase description too. Just in case.

> +char *TCID = "thp03";

It's missing:

int TST_TOTAL = 1;

So that test framework knows the number of executed tests.

(I'm not sure if it's currently used, but all the other
 tests defined this)

> +static void thp_test(void);
> +
> +static long hugepage_size;
> +static long unaligned_size;
> +static long page_size;

The rests seems okay.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
The Windows 8 Center - In partnership with Sourceforge
Your idea - your app - 30 days.
Get started!
http://windows8center.sourceforge.net/
what-html-developers-need-to-know-about-coding-windows-8-metro-style-apps/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
