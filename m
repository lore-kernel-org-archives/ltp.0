From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 8 Feb 2017 12:10:56 +0100
Subject: [LTP] [PATCH] [RFC] zram01: Fix on ppc64le
In-Reply-To: <20170202152242.GA11304@rei.lan>
References: <1485870273-26990-1-git-send-email-chrubis@suse.cz>
 <845142934.836828.1485879246140.JavaMail.zimbra@redhat.com>
 <20170201094541.GA13898@rei.lan>
 <1372516698.1369615.1485946778720.JavaMail.zimbra@redhat.com>
 <20170202152242.GA11304@rei.lan>
Message-ID: <20170208111055.GA16139@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > > What exactly do you have in mind? Using 256MB by default for any Btrfs
> > > filesystem or fallback to 256MB if mkfs.btrfs output cannot be parsed?
> > 
> > I meant default size.
> 
> Then we should increase the default size for the LTP_DEV as well.
> Unfortunately it's defined at three different places at this point. We
> have it in runltp script, the C library and the shell library. I was
> thinking of exporting the C library as a binary for the shell tests to
> use in order to reduce the complexity. I will look into that and also
> bump the minimal size as well.

And apparenlty it was defined in four different places, since we have two
versions of shell library each with it's own code to acquire device.

I've send a patchset that exports the acquire/release interface from C
as a single binary and makes use of that in the tst_test.sh.

There is still one unsolved problem since the TWARN messages from the
tst_device.c will trigger TBROK in tst_test.c since the IPC is not
initialized. I'm still unsure how to fix that, maybe we should allow to
allocate non-shared structure for the results in the special case that
the library code is being reused in shell helpers.

Finally the last patch of the series bumps the minima size to 256MB and
touched only two places, the runltp script and tst_device.c, which is
way better than four...

-- 
Cyril Hrubis
chrubis@suse.cz
