Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1UpFeo-0003pr-Ua
	for ltp-list@lists.sourceforge.net; Wed, 19 Jun 2013 10:30:30 +0000
Received: from mail-pa0-f54.google.com ([209.85.220.54])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UpFek-0004cG-ML
	for ltp-list@lists.sourceforge.net; Wed, 19 Jun 2013 10:30:30 +0000
Received: by mail-pa0-f54.google.com with SMTP id kx10so4994634pab.41
	for <ltp-list@lists.sourceforge.net>;
	Wed, 19 Jun 2013 03:30:20 -0700 (PDT)
Message-ID: <51C18279.7000607@casparzhang.com>
Date: Wed, 19 Jun 2013 18:05:45 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <51C1553B.7090600@cn.fujitsu.com>
In-Reply-To: <51C1553B.7090600@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] mmap/mmap12.c: new case to test MAP_POPULATE of
 mmap
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
To: DAN LI <li.dan@cn.fujitsu.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

On 06/19/2013 02:52 PM, DAN LI wrote:
> +			ret = sysinfo(&info);
> +			if (ret != 0)
> +				tst_brkm(TFAIL, cleanup, "sysinfo failed");
> +			freeram_after =
> +				(unsigned long long)info.freeram *
> +				(unsigned long long)info.mem_unit;

man sysinfo:

        This function is Linux-specific, and should not be used in 
programs intended to be portable.

We're expecting all LTP tests are POSIX-compatible, sysinfo is 
Linux-specific, would it better to read the info from /proc/meminfo 
directly?

Thanks,
Caspar

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
