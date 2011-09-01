Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1Qz6vY-0006zG-JN
	for ltp-list@lists.sourceforge.net; Thu, 01 Sep 2011 13:03:28 +0000
Date: Thu, 1 Sep 2011 15:03:26 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110901130326.GB10968@saboteur.suse.cz>
References: <4E5D276C.3020505@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4E5D276C.3020505@linux.vnet.ibm.com>
Subject: Re: [LTP] [PATCH 1/1] fix ssh03 on system running mls policy
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
To: James Czyzak <czyzak2@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net, debora@linux.vnet.ibm.com

Hi!
> Hi Cyril
> 
> I sent this as new message since it's a revision of the patch as you
> suggested, which is a better way to do it. I wasn't sure whether it
> would be proper procedure to send a revised patch in a reply that
> contained the original. Anyway I modified some of the configuration
> settings of the mail client I'm using (Thunderbird) which unfortunately
> I need to run on a windows machine. Hopefully the configuration changes
> will prevent distortion of the patch. Please let me know if it does not.
> 
>  Signed-off-by: James Czyzak <czyzak2@linux.vnet.ibm.com>

The patch is OK. But please write description for the code change into
the mail body (instead of how Thunderbird tends to mangle patches ;).

Also there shouldn't be a whitespace before the Signed-off-by line.

> ---
>  testcases/network/tcp_cmds/ssh/ssh03 |    4 +---
>  1 files changed, 1 insertions(+), 3 deletions(-)
> 
> diff --git a/testcases/network/tcp_cmds/ssh/ssh03
> b/testcases/network/tcp_cmds/ssh/ssh03
> index 8fbca34..798d385 100755
> --- a/testcases/network/tcp_cmds/ssh/ssh03
> +++ b/testcases/network/tcp_cmds/ssh/ssh03
> @@ -39,10 +39,8 @@ do_setup()
>      export TEST_USER_HOMEDIR="/home/$TEST_USER"
> 
>      # erase user if he/she already exists, so we can have a clean env
> -    TCtmp=/home/$TEST_USER
> -
> -    rm -Rf $TCtmp
> 
> +    rm -Rf /home/$TEST_USER
>      tst_setup
> 
>      exists expect ssh ssh03_s1 useradd userdel
> --
> 1.7.4.1

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Special Offer -- Download ArcSight Logger for FREE!
Finally, a world-class log management solution at an even better 
price-free! And you'll get a free "Love Thy Logs" t-shirt when you
download Logger. Secure your free ArcSight Logger TODAY!
http://p.sf.net/sfu/arcsisghtdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
