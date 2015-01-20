Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YDa3D-0000is-Cx
	for ltp-list@lists.sourceforge.net; Tue, 20 Jan 2015 14:45:03 +0000
Date: Tue, 20 Jan 2015 15:44:03 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150120144403.GC15452@rei>
References: <8593d893c637eadbac85711428be570e2636ef38.1421761305.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8593d893c637eadbac85711428be570e2636ef38.1421761305.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH] runltp: export initialized LTP_DEV
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
Cc: ltp-list@lists.sourceforge.net, liwan@redhat.com

Hi!
> This patch restores behavior from ltp-20140828, where LTP_DEV is exported
> and tst_acquire_device() will use that instead of trying to acquire/release
> loopdev on its own.

Sorry for my confusion. This patch is correct as it moves the export to
the right places. I didn't read till it carefully and thought this
simply reverts the change, sorry.

The change is acked, but I think that it merely avoids the EBUSY from
the ioctl() and that there is a real bug somewhere, likely some race
condition in kernel.

> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  runltp |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/runltp b/runltp
> index e803898..8116306 100755
> --- a/runltp
> +++ b/runltp
> @@ -1011,10 +1011,10 @@ set_block_device()
>              echo "Tests which require block device are disabled."
>              echo "You can specify it with option -b"
>  	else
> -            LTP_DEV=$DEVICE
> +            export LTP_DEV=$DEVICE
>          fi
>      else
> -        LTP_DEV=$DEVICE
> +        export LTP_DEV=$DEVICE
>      fi
>  }
>  
> -- 
> 1.7.1
> 

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
New Year. New Location. New Benefits. New Data Center in Ashburn, VA.
GigeNET is offering a free month of service with a new server in Ashburn.
Choose from 2 high performing configs, both with 100TB of bandwidth.
Higher redundancy.Lower latency.Increased capacity.Completely compliant.
http://p.sf.net/sfu/gigenet
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
