Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Z0Upz-0001j2-HO
	for ltp-list@lists.sourceforge.net; Thu, 04 Jun 2015 13:05:35 +0000
Date: Thu, 4 Jun 2015 15:04:35 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150604130435.GB7095@rei.suse.de>
References: <0412ecc6e0cec73921a692ba87443a486bc53193.1433422701.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0412ecc6e0cec73921a692ba87443a486bc53193.1433422701.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH v2] mem/oom: allocate memory using multiple threads
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
Cc: ltp-list@lists.sourceforge.net

Hi!
> diff --git a/testcases/kernel/mem/include/libmem.mk b/testcases/kernel/mem/include/libmem.mk
> index 4503e78..dffa379 100644
> --- a/testcases/kernel/mem/include/libmem.mk
> +++ b/testcases/kernel/mem/include/libmem.mk
> @@ -23,7 +23,7 @@ MEM_DIR			:= $(top_builddir)/testcases/kernel/mem
>  LIBMEM_DIR		:= $(MEM_DIR)/lib
>  LIBMEM			:= $(LIBMEM_DIR)/libmem.a
>  FILTER_OUT_DIRS		:= $(LIBMEM_DIR)
> -CFLAGS			+= -I$(MEM_SRCDIR)/include
> +CFLAGS			+= -I$(MEM_SRCDIR)/include -lpthread

-pthread not -lpthread, see man pthread_create() for example

Otherwise it looks fine.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
