Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WHxot-0005d4-J9
	for ltp-list@lists.sourceforge.net; Mon, 24 Feb 2014 15:51:51 +0000
Date: Mon, 24 Feb 2014 16:51:37 +0100
From: chrubis@suse.cz
Message-ID: <20140224155137.GA30419@rei>
References: <1393236325-30766-1-git-send-email-penght@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1393236325-30766-1-git-send-email-penght@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v3 1/2] sigaction:16-1: leave it untested on the
 Linux kernel less than 2.6.22
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
To: Peng Haitao <penght@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> As the Linux signal(7) said:
> POSIX semaphore interfaces: sem_wait(3) and sem_timedwait(3) (since Linux 2.6.22; beforehand, always failed with EINTR).
> 
> So, on Linux, we just leave it untested when the kernel version
> is less than 2.6.22 and user wants to filter it.
> 
> Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  testcases/open_posix_testsuite/Makefile              |  4 ++++
>  testcases/open_posix_testsuite/Makefile.linux        | 20 ++++++++++++++++++++
>  .../open_posix_testsuite/scripts/tst_kvercmp.sh      | 20 ++++++++++++++++++++
>  3 files changed, 44 insertions(+)
>  create mode 100644 testcases/open_posix_testsuite/Makefile.linux
>  create mode 100755 testcases/open_posix_testsuite/scripts/tst_kvercmp.sh
> 
> diff --git a/testcases/open_posix_testsuite/Makefile b/testcases/open_posix_testsuite/Makefile
> index 9c61fa4..500ddc2 100644
> --- a/testcases/open_posix_testsuite/Makefile
> +++ b/testcases/open_posix_testsuite/Makefile
> @@ -40,6 +40,10 @@ exec_prefix?=		$(prefix)
>  
>  all: conformance-all functional-all stress-all tools-all
>  
> +ifeq ($(shell uname -s), Linux)
> +include Makefile.linux
> +endif
> +
>  clean: $(CRITICAL_MAKEFILES)
>  	@rm -f $(LOGFILE)*
>  	@for dir in $(SUBDIRS) tools; do \
> diff --git a/testcases/open_posix_testsuite/Makefile.linux b/testcases/open_posix_testsuite/Makefile.linux
> new file mode 100644
> index 0000000..3b09433
> --- /dev/null
> +++ b/testcases/open_posix_testsuite/Makefile.linux
> @@ -0,0 +1,20 @@
> +cmd_disable = @set -e; \
> +	echo "Disabling: $(1)"; \
> +	echo "\#!/bin/sh" > $(1); \
> +	echo "echo $(1) skipped" >> $(1); \
> +	echo "echo $(2)" >> $(1); \
> +	echo "exit 0" >> $(1); \
> +	chmod a+x $(1)
> +
> +BROKEN :=
> +
> +kver_cmp = $(shell $(top_srcdir)/scripts/tst_kvercmp.sh 2 6 22)
> +ifeq ($(kver_cmp), 1)
> +BROKEN += t_sigaction_16-1
> +endif
> +
> +filter-broken: $(BROKEN)

Just a minor nit, this should be filter-known-fails or similar because
the test itself is not broken. If the test was broken we would either
disable it or remove it.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Flow-based real-time traffic analytics software. Cisco certified tool.
Monitor traffic, SLAs, QoS, Medianet, WAAS etc. with NetFlow Analyzer
Customize your own dashboards, set traffic alerts and generate reports.
Network behavioral analysis & security monitoring. All-in-one tool.
http://pubads.g.doubleclick.net/gampad/clk?id=126839071&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
