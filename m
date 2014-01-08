Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1W0wQd-00076e-6F
	for ltp-list@lists.sourceforge.net; Wed, 08 Jan 2014 16:56:27 +0000
Date: Wed, 8 Jan 2014 17:56:06 +0100
From: chrubis@suse.cz
Message-ID: <20140108165606.GA2178@rei>
References: <1383899857-4669-1-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1383899857-4669-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: Re: [LTP] [PATCH] setregid02: invalid user value fix
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
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> Commit 705926d096f7a64c9d53efeb789288e25457d68f
> introduced a bug that the value for inval_user was treated
> as '-1' when passed to 16-bit version of setregid().
> 
> Fixed it the same way as it's done for setreuid test cases.
> 
> Reported-by: Honggyu Kim <hong.gyu.kim@lge.com>
> Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
> ---
>  testcases/kernel/syscalls/setregid/setregid02.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/setregid/setregid02.c b/testcases/kernel/syscalls/setregid/setregid02.c
> index e67a7df..2b84b26 100644
> --- a/testcases/kernel/syscalls/setregid/setregid02.c
> +++ b/testcases/kernel/syscalls/setregid/setregid02.c
> @@ -39,7 +39,7 @@ TCID_DEFINE(setregid02);
>  
>  static gid_t neg_one = -1;
>  
> -static gid_t inval_user = (USHRT_MAX);
> +static gid_t inval_user = USHRT_MAX - 2;
>  static struct passwd *ltpuser;

Unfortunately I've found that in SLES user nobody has UID precisely
USHRT_MAX - 2 and the test fails :(

Thinking of correct solution, we probably need some
tst_get_unused_uid(). What do you think?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
