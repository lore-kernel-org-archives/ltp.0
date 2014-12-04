Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XwTTu-0001XG-En
	for ltp-list@lists.sourceforge.net; Thu, 04 Dec 2014 10:17:54 +0000
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id C375BACDE
	for <ltp-list@lists.sourceforge.net>;
	Thu,  4 Dec 2014 10:17:46 +0000 (UTC)
Date: Thu, 4 Dec 2014 11:17:41 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141204101741.GB15326@rei.suse.de>
References: <20141204083400.GA2704@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20141204083400.GA2704@localhost.localdomain>
Subject: Re: [LTP] [PATCH] syscalls/getgroups/getgroups01: set supplementary
 groups to prevent TCONF
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
To: ltp-list@lists.sourceforge.net

Hi!
> Signed-off-by: Han Pingtian <hanpt@linux.vnet.ibm.com>
> ---
>  testcases/kernel/syscalls/getgroups/getgroups01.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/getgroups/getgroups01.c b/testcases/kernel/syscalls/getgroups/getgroups01.c
> index 9fb4c98..28559d3 100644
> --- a/testcases/kernel/syscalls/getgroups/getgroups01.c
> +++ b/testcases/kernel/syscalls/getgroups/getgroups01.c
> @@ -74,8 +74,6 @@ int main(int ac, char **av)
>  	int i;
>  	int entries;
>  
> -	initgroups("root", 0);
> -
>  	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
>  		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
>  
> @@ -183,6 +181,9 @@ static void setup(void)
>  	tst_sig(FORK, DEF_HANDLER, cleanup);
>  
>  	TEST_PAUSE;
> +
> +	GID_T init_gidset[3] = {0, 1, 2};

This should be gid_t instead of GID_T. The uppercase prototypes are for
raw syscalls only. The setgroups() you call is glibc wrapper instead.

> +	setgroups(3, init_gidset);

Otherwise it looks good to me.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=164703151&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
