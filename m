From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 1 Feb 2017 10:45:41 +0100
Subject: [LTP] [PATCH] [RFC] zram01: Fix on ppc64le
In-Reply-To: <845142934.836828.1485879246140.JavaMail.zimbra@redhat.com>
References: <1485870273-26990-1-git-send-email-chrubis@suse.cz>
 <845142934.836828.1485879246140.JavaMail.zimbra@redhat.com>
Message-ID: <20170201094541.GA13898@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> This is ~4 years old comment from Zach Brown, when I hit an issue on ppc,
> where I could alloc only 1/2 of the volume size:
> 
> "That small volume mkfs warning is issued for devices less than a gig.  It indicates that btrfs has gone in to a weird degenerate allocation scheme.  We'd only support volumes much larger than that, though I have no quick rule to say how large starts to be reasonable.  Multiple gig, certainly."
> 
> I'm running with 384M since then, so far successfully. If we don't allocate
> too much data on it, we might be OK, but still I'd go with minimum default of 256M.

What exactly do you have in mind? Using 256MB by default for any Btrfs
filesystem or fallback to 256MB if mkfs.btrfs output cannot be parsed?

I guess that for any other testcase it would be fine enough to bump the
minimal device size to 256MB unconditionally, but in this case we create
the data in RAM albeit compressed, and so I would like to keep it as
small as possible, since otherwise it may fail on embedded hardware.
Maybe we should just remove Btrfs from the zram01.sh test so that we
don't have to keep bumping the minimal size each time the minimal Btrfs
size calculation changes...

-- 
Cyril Hrubis
chrubis@suse.cz
