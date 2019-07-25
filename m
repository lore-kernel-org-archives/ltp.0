From: Al Viro <viro@zeniv.linux.org.uk>
Date: Thu, 25 Jul 2019 19:04:28 +0100
Subject: [LTP] 56cbb429d9: ltp.fs_fill.fail
In-Reply-To: <CAHk-=wg+yRjY_AUrjbgrN59OeGAWMF_q=-Dqf2cYtVzoY01j7Q@mail.gmail.com>
References: <20190725110944.GA22106@shao2-debian>
 <20190725132617.GA23135@rei.lan>
 <CAHk-=wg+yRjY_AUrjbgrN59OeGAWMF_q=-Dqf2cYtVzoY01j7Q@mail.gmail.com>
Message-ID: <20190725180428.GH1131@ZenIV.linux.org.uk>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Jul 25, 2019 at 09:32:13AM -0700, Linus Torvalds wrote:
> On Thu, Jul 25, 2019 at 6:26 AM Cyril Hrubis <chrubis@suse.cz> wrote:
> >
> > This looks like mkfs.vfat got EBUSY after the loop device was
> > succesfully umounted.
> 
> Hmm. Smells like the RCU-delaying got triggered again.
> 
> We have that "synchronize_rcu_expedited()" in namespace_unlock(),
> which is so that everything should be done by the time we return to
> user space.
> 
> Al, maybe that RCU synchronization should be after the mntput()s?

There are several interesting issues in there, but synchronize_rcu()
should be between zeroing ->mnt_ns and dropping the final refs.
I'm digging through that crap right now; at least one bug is dealt
with by #fixes, but there's more, unfortunately.
