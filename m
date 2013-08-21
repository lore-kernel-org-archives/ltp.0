Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1VC9Se-00076x-BI
	for ltp-list@lists.sourceforge.net; Wed, 21 Aug 2013 14:32:36 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VC9Sc-0003rt-VF
	for ltp-list@lists.sourceforge.net; Wed, 21 Aug 2013 14:32:36 +0000
Date: Wed, 21 Aug 2013 10:32:28 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1585868915.1934407.1377095548829.JavaMail.root@redhat.com>
In-Reply-To: <1377086098-32691-2-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <52122141.3020005@oracle.com>
	<1377086098-32691-2-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH V2 2/3] syscalls/migrate_pages: fix nodemask
 memory allocation
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
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: vasily isaenko <vasily.isaenko@oracle.com>, ltp-list@lists.sourceforge.net



----- Original Message -----
> From: "Stanislav Kholmanskikh" <stanislav.kholmanskikh@oracle.com>
> To: ltp-list@lists.sourceforge.net
> Cc: "vasily isaenko" <vasily.isaenko@oracle.com>, jstancek@redhat.com
> Sent: Wednesday, 21 August, 2013 1:54:57 PM
> Subject: [PATCH V2 2/3] syscalls/migrate_pages: fix nodemask memory allocation
> 
> In accordance to man migrate_pages(), mbind() the bit mask size
> should be rounded to next multiple of sizeof(unsigned long).
> 
> Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>

As noted in 3/3 we need to align on bits, looks good to me.

Reviewed-by: Jan Stancek <jstancek@redhat.com>

> ---
>  .../syscalls/migrate_pages/migrate_pages01.c       |    2 +-
>  .../syscalls/migrate_pages/migrate_pages02.c       |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c
> b/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c
> index c23e8b0..6361e9f 100644
> --- a/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c
> +++ b/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c
> @@ -248,7 +248,7 @@ static void setup(void)
>  			 ret);
>  
>  	sane_max_node = get_max_node();
> -	sane_nodemask_size = sane_max_node / 8 + 1;
> +	sane_nodemask_size = ALIGN(sane_max_node, sizeof(unsigned long)*8) / 8;
>  	sane_old_nodes = SAFE_MALLOC(NULL, sane_nodemask_size);
>  	sane_new_nodes = SAFE_MALLOC(NULL, sane_nodemask_size);
>  	memset(sane_old_nodes, 0, sane_nodemask_size);
> diff --git a/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
> b/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
> index 49129e0..5790abd 100644
> --- a/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
> +++ b/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
> @@ -110,7 +110,7 @@ static int migrate_to_node(pid_t pid, int node)
>  	tst_resm(TINFO, "pid(%d) migrate pid %d to node -> %d",
>  		 getpid(), pid, node);
>  	max_node = get_max_node();
> -	nodemask_size = max_node / 8 + 1;
> +	nodemask_size = ALIGN(max_node, sizeof(unsigned long)*8) / 8;
>  	old_nodes = SAFE_MALLOC(NULL, nodemask_size);
>  	new_nodes = SAFE_MALLOC(NULL, nodemask_size);
>  
> --
> 1.7.1
> 
> 

------------------------------------------------------------------------------
Introducing Performance Central, a new site from SourceForge and 
AppDynamics. Performance Central is your source for news, insights, 
analysis and resources for efficient Application Performance Management. 
Visit us today!
http://pubads.g.doubleclick.net/gampad/clk?id=48897511&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
