Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VgxmB-0004MZ-19
	for ltp-list@lists.sourceforge.net; Thu, 14 Nov 2013 14:20:07 +0000
Date: Thu, 14 Nov 2013 15:19:51 +0100
From: chrubis@suse.cz
Message-ID: <20131114141951.GA14170@rei>
References: <20131113175008.GE12406@rei.Home>
	<1384411077-26013-1-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1384411077-26013-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: Re: [LTP] [PATCH V3 1/2] tst_res: added ETIME,
	ETIMEDOUT errno values
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
> Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
> ---
>  lib/tst_res.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/lib/tst_res.c b/lib/tst_res.c
> index f73022b..698b12c 100644
> --- a/lib/tst_res.c
> +++ b/lib/tst_res.c
> @@ -255,6 +255,8 @@ static const char *strerrnodef(int err)
>  		    PAIR(ENOSYS)
>  		    PAIR(ENOTEMPTY)
>  		    PAIR(ELOOP)
> +		    PAIR(ETIMEDOUT)
> +		    PAIR(ETIME)
>  	};
>  	return pair_lookup(errno_pairs, err);
>  }

I've just pushed patch that add all ERRNO values found in headers on
recent enough distribution.

Please check that it compiles at older distros you are using and if not
send a patch with ifdefs as they are around the HWPOISON.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
DreamFactory - Open Source REST & JSON Services for HTML5 & Native Apps
OAuth, Users, Roles, SQL, NoSQL, BLOB Storage and External API Access
Free app hosting. Or install the open source package on any LAMP server.
Sign up and see examples for AngularJS, jQuery, Sencha Touch and Native!
http://pubads.g.doubleclick.net/gampad/clk?id=63469471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
