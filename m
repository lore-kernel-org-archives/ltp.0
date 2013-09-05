Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VHW7t-0004sr-GZ
	for ltp-list@lists.sourceforge.net; Thu, 05 Sep 2013 09:45:21 +0000
Date: Thu, 5 Sep 2013 11:45:29 +0200
From: chrubis@suse.cz
Message-ID: <20130905094529.GA2770@rei>
References: <9e5ca46eba40644a4d51bb60f9a81d2b99cc814c.1378366073.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9e5ca46eba40644a4d51bb60f9a81d2b99cc814c.1378366073.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH] proc01: add nfsd/pool_stats to list of known
	issues
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
> This file is available if /proc/fs/nfsd filesystem is mounted,
> but it can be opened only when nfs server is running.
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  testcases/kernel/fs/proc/proc01.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/testcases/kernel/fs/proc/proc01.c b/testcases/kernel/fs/proc/proc01.c
> index 2771cd4..73a55c8 100644
> --- a/testcases/kernel/fs/proc/proc01.c
> +++ b/testcases/kernel/fs/proc/proc01.c
> @@ -85,6 +85,7 @@ static const struct mapping known_issues[] = {
>  	{"open", "/proc/sal/cmc/data", EBUSY},
>  	{"open", "/proc/sal/init/data", EBUSY},
>  	{"open", "/proc/sal/mca/data", EBUSY},
> +	{"open", "/proc/fs/nfsd/pool_stats", ENODEV},
>  	{"read", "/proc/acpi/event", EAGAIN},
>  	{"read", "/proc/kmsg", EAGAIN},
>  	{"read", "/proc/sal/cpe/event", EAGAIN},

Acked.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn the latest--Visual Studio 2012, SharePoint 2013, SQL 2012, more!
Discover the easy way to master current and previous Microsoft technologies
and advance your career. Get an incredible 1,500+ hours of step-by-step
tutorial videos with LearnDevNow. Subscribe today and save!
http://pubads.g.doubleclick.net/gampad/clk?id=58041391&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
