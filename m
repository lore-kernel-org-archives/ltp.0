From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 2 Feb 2017 16:22:42 +0100
Subject: [LTP] [PATCH] [RFC] zram01: Fix on ppc64le
In-Reply-To: <1372516698.1369615.1485946778720.JavaMail.zimbra@redhat.com>
References: <1485870273-26990-1-git-send-email-chrubis@suse.cz>
 <845142934.836828.1485879246140.JavaMail.zimbra@redhat.com>
 <20170201094541.GA13898@rei.lan>
 <1372516698.1369615.1485946778720.JavaMail.zimbra@redhat.com>
Message-ID: <20170202152242.GA11304@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > > This is ~4 years old comment from Zach Brown, when I hit an issue on ppc,
> > > where I could alloc only 1/2 of the volume size:
> > > 
> > > "That small volume mkfs warning is issued for devices less than a gig.  It
> > > indicates that btrfs has gone in to a weird degenerate allocation scheme.
> > > We'd only support volumes much larger than that, though I have no quick
> > > rule to say how large starts to be reasonable.  Multiple gig, certainly."
> > > 
> > > I'm running with 384M since then, so far successfully. If we don't allocate
> > > too much data on it, we might be OK, but still I'd go with minimum default
> > > of 256M.
> > 
> > What exactly do you have in mind? Using 256MB by default for any Btrfs
> > filesystem or fallback to 256MB if mkfs.btrfs output cannot be parsed?
> 
> I meant default size.

Then we should increase the default size for the LTP_DEV as well.
Unfortunately it's defined at three different places at this point. We
have it in runltp script, the C library and the shell library. I was
thinking of exporting the C library as a binary for the shell tests to
use in order to reduce the complexity. I will look into that and also
bump the minimal size as well.

> > I guess that for any other testcase it would be fine enough to bump the
> > minimal device size to 256MB unconditionally, but in this case we create
> > the data in RAM albeit compressed, and so I would like to keep it as
> > small as possible, since otherwise it may fail on embedded hardware.
> 
> I didn't have a look at zram01, but can't we detect this and TCONF?

I guess that we can look at total amount of RAM and enable/disable the
test with Btrfs filesystem if it's deemed too small.

> We can try with minimum and see how frequently it changes, I just
> wanted to share Zach's quote and my experience with tiny btrfs volumes.

I've been adjusting the minimal size (of the TST_DEVICE) two times
already, we bumped it to 100MB then to 150MB. The first one was
because mkfs.btrfs change, the second was because the size depends on
PAGE_SIZE and 100MB wasn't enough for ppc64le. I guess that bumping it
to 256MB is not unreasonable, and hopefully that would be enough for
some time.

-- 
Cyril Hrubis
chrubis@suse.cz
