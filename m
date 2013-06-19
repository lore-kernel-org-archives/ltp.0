Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UpG5F-0000pP-0D
	for ltp-list@lists.sourceforge.net; Wed, 19 Jun 2013 10:57:49 +0000
Date: Wed, 19 Jun 2013 12:59:14 +0200
From: chrubis@suse.cz
Message-ID: <20130619105914.GA24520@rei>
References: <51C1553B.7090600@cn.fujitsu.com>
	<51C18279.7000607@casparzhang.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51C18279.7000607@casparzhang.com>
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
To: Caspar Zhang <caspar@casparzhang.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

Hi!
> > +			ret = sysinfo(&info);
> > +			if (ret != 0)
> > +				tst_brkm(TFAIL, cleanup, "sysinfo failed");
> > +			freeram_after =
> > +				(unsigned long long)info.freeram *
> > +				(unsigned long long)info.mem_unit;
> 
> man sysinfo:
> 
>         This function is Linux-specific, and should not be used in 
> programs intended to be portable.
> 
> We're expecting all LTP tests are POSIX-compatible, sysinfo is 
> Linux-specific, would it better to read the info from /proc/meminfo 
> directly?

That is true for the Open Posix Testsuite, but this test is added under
testcases/kernel/ for which it is fine.

Note also that MAP_POPULATE is itself Linux specific ;).

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
