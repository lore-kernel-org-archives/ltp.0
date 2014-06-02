Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WrVsK-0004cG-Qb
	for ltp-list@lists.sourceforge.net; Mon, 02 Jun 2014 17:18:20 +0000
Date: Mon, 2 Jun 2014 19:17:56 +0200
From: chrubis@suse.cz
Message-ID: <20140602171756.GA23446@rei>
References: <1398697619-27372-1-git-send-email-mats.liljegren@enea.com>
	<1399990269-3383-1-git-send-email-mats.liljegren@enea.com>
	<1399990269-3383-2-git-send-email-mats.liljegren@enea.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1399990269-3383-2-git-send-email-mats.liljegren@enea.com>
Subject: Re: [LTP] [PATCH v3] partrt_nohz_full: Introducing a new test case
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
To: Mats Liljegren <mats.liljegren@enea.com>
Cc: ltp-list@lists.sourceforge.net, Kevin Hilman <khilman@linaro.org>, Frederic Weisbecker <fweisbec@gmail.com>

Hi!
> This test case is intended to test the nohz_full kernel feature. See file
> testcases/kernel/partrt/README for more information.

This version looks good to me. My last concern is about the names of the
partrt tools.

> --- a/utils/Makefile
> +++ b/utils/Makefile
> @@ -24,6 +24,10 @@ include $(top_srcdir)/include/mk/env_pre.mk
>  
>  MAKE_TARGETS         += ffsb
>  
> +ifneq ($(wildcard rt-tools),)
> +MAKE_TARGETS         += partrt list2mask count_ticks
> +endif
> +
>  FFSBDIR			:= ffsb-6.0-rc2
>  FILTER_OUT_DIRS		:= $(FFSBDIR)
>  FFSB			:= $(FFSBDIR)/ffsb
> @@ -35,6 +39,9 @@ $(FFSB): $(abs_srcdir)/$(FFSBDIR)
>  ffsb: $(FFSB)
>  	cp $(FFSB) ffsb
>  
> +partrt list2mask count_ticks:
> +	cp rt-tools/install/bin/$@ $@

As it is now, upon the installation LTP copies all executables into one
directory and we are trying to avoid collisions by adding sufixes or
prefixes to the binaries.

Can we add a rt to all the binaries (list2maskrt, count_ticksrt) or
something similar while we install them?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their 
applications. Written by three acclaimed leaders in the field, 
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
