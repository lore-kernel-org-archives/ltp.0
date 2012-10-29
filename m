Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1TSrKm-0007YA-Jo
	for ltp-list@lists.sourceforge.net; Mon, 29 Oct 2012 15:33:00 +0000
Date: Mon, 29 Oct 2012 16:30:40 +0100
From: chrubis@suse.cz
Message-ID: <20121029153039.GC12578@rei.suse.cz>
References: <cover.1351256774.git.jstancek@redhat.com>
	<ec297ec37d42b978b26dc407dabd62225e62b7f8.1351256774.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ec297ec37d42b978b26dc407dabd62225e62b7f8.1351256774.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH v3 1/3] numa_helper: export get_max_node()
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
>  testcases/kernel/include/numa_helper.h |    1 +
>  testcases/kernel/lib/numa_helper.c     |    6 ++++--
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/include/numa_helper.h b/testcases/kernel/include/numa_helper.h
> index 463019a..0be7a28 100644
> --- a/testcases/kernel/include/numa_helper.h
> +++ b/testcases/kernel/include/numa_helper.h
> @@ -30,6 +30,7 @@
>  #define NH_MEMS (1 << 0)
>  #define NH_CPUS (1 << 1)
>  
> +unsigned long get_max_node();
>  int get_allowed_nodes_arr(int flag, int *num_nodes, int **nodes);
>  int get_allowed_nodes(int flag, int count, ...);
>  void nh_dump_nodes();

Please don't forget to add void as a parameter for functions without any
parameters so that compiler disallows passing arguments to them.

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
