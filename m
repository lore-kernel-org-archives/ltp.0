Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1X9dMB-00072a-2s
	for ltp-list@lists.sourceforge.net; Tue, 22 Jul 2014 16:56:03 +0000
Received: from mail-pd0-f179.google.com ([209.85.192.179])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1X9dM9-0007aE-Nq
	for ltp-list@lists.sourceforge.net; Tue, 22 Jul 2014 16:56:03 +0000
Received: by mail-pd0-f179.google.com with SMTP id ft15so11453505pdb.24
	for <ltp-list@lists.sourceforge.net>;
	Tue, 22 Jul 2014 09:55:55 -0700 (PDT)
Message-ID: <53CE97F7.7070508@casparzhang.com>
Date: Wed, 23 Jul 2014 00:57:27 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <dc2462c674d71068608438bec6cb162481571eec.1406044787.git.jstancek@redhat.com>
In-Reply-To: <dc2462c674d71068608438bec6cb162481571eec.1406044787.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH] mmap15: raise high address to 2^53
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
To: Jan Stancek <jstancek@redhat.com>, ltp-list@lists.sourceforge.net
Cc: wangli.ahau@gmail.com

On 07/23/2014 12:06 AM, Jan Stancek wrote:
> Address space on s390x can go atm. as high as 2^53,
> so raise high address used here to this level.
>
> Signed-off-by: Li Wang <wangli.ahau@gmail.com>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
Acked-by: Caspar Zhang <caspar@casparzhang.com>

Thanks,
Caspar

> ---
>   testcases/kernel/syscalls/mmap/mmap15.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/mmap/mmap15.c b/testcases/kernel/syscalls/mmap/mmap15.c
> index 321d405..49dbba4 100644
> --- a/testcases/kernel/syscalls/mmap/mmap15.c
> +++ b/testcases/kernel/syscalls/mmap/mmap15.c
> @@ -41,7 +41,7 @@
>   char *TCID = "mmap15";
>   int TST_TOTAL = 1;
>
> -#define HIGH_ADDR	(void *)(0x1000000000000)
> +#define HIGH_ADDR	(void *)(1L << 53)
>
>   static long map_sz;
>
>


------------------------------------------------------------------------------
Want fast and easy access to all the code in your enterprise? Index and
search up to 200,000 lines of code with a free copy of Black Duck
Code Sight - the same software that powers the world's largest code
search on Ohloh, the Black Duck Open Hub! Try it now.
http://p.sf.net/sfu/bds
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
