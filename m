From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 3 May 2017 03:02:35 -0400 (EDT)
Subject: [LTP] LTP release
In-Reply-To: <20170428154714.GB4741@rei.suse.de>
References: <20170424162534.GA13616@rei.lan>
 <20170428154714.GB4741@rei.suse.de>
Message-ID: <8885817.6312900.1493794955506.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi!
> Here is a short list of problems I've found by pre-release testing:
> 
> * utimensat01 - We reverted the fix before the last release and started
>                 discussion on LKML but it seems that nobody cares so I
> 		guess that we should reapply the patch and forget.
> 
> * pselect01   - There seems to be some outliners, at least on SLES where
>                 the test request 200us sleep and ends up with up to
> 		1500us, I will have to have a closer look into this.
> 
> * syslog*     - Ends up with TBROK on Tumbleweed as it does not find
>                 any syslog running, possibly systemd related, needs
> 		to be investigated.
> 
> * madvise09   - Ends up with memsg.limits_in_bytes missing on kernel
>                 with unset CONFIG_MEMCG_SWAP_ENABLED (Tumbleweed again)
> 		I will have to look into that.
> 
> Anything else?

mmapstress04 heap overwrite, I need to make v2 of patch you already
reviewed.

> 
> Any other patches that should go in before the release?
> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
> 
