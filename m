Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WSrCB-0008Lm-Fa
	for ltp-list@lists.sourceforge.net; Wed, 26 Mar 2014 17:00:55 +0000
Date: Wed, 26 Mar 2014 18:00:28 +0100
From: chrubis@suse.cz
Message-ID: <20140326170027.GA11941@rei.Home>
References: <20140326131946.GD9168@rei.suse.cz>
	<1395851259-14416-1-git-send-email-xu.simon@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1395851259-14416-1-git-send-email-xu.simon@oracle.com>
Subject: Re: [LTP] [PATCH] xinetd_test.sh: restart xinetd by restart_daemon()
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
To: Simon Xu <xu.simon@oracle.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Signed-off-by: Simon Xu <xu.simon@oracle.com>
> ---
>  testcases/network/xinetd/xinetd_tests.sh | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/testcases/network/xinetd/xinetd_tests.sh b/testcases/network/xinetd/xinetd_tests.sh
> index dac23a8..38cd7b0 100755
> --- a/testcases/network/xinetd/xinetd_tests.sh
> +++ b/testcases/network/xinetd/xinetd_tests.sh
> @@ -63,6 +63,8 @@ init()
>      export TST_TOTAL=2
>      export TCID="xinetd"
>      export TST_COUNT=0
> +    export XINETD_DAEMON='xinetd'

I would be for passing the xinetd directly to the restart_daemon (just
calling restart_daemon xinetd) function unless you know that there is a
distribution that named it differently and we will need the runtime name
detection.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
