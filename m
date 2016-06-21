From: Li Wang <liwang@redhat.com>
Date: Tue, 21 Jun 2016 17:07:31 +0800
Subject: [LTP] [PATCH] mem/lib: Keep KSM off when child_alloc() allocate
 memory in single thread
In-Reply-To: <1126821490.620692.1466498390955.JavaMail.zimbra@redhat.com>
References: <1466480392-25837-1-git-send-email-liwang@redhat.com>
 <1793371138.555301.1466492429338.JavaMail.zimbra@redhat.com>
 <20160621075613.GB24636@gmail.com>
 <1126821490.620692.1466498390955.JavaMail.zimbra@redhat.com>
Message-ID: <20160621090005.GC24636@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Jun 21, 2016 at 04:39:50AM -0400, Jan Stancek wrote:
> ----- Original Message -----
> > From: "Li Wang" <liwang@redhat.com>
> > To: "Jan Stancek" <jstancek@redhat.com>
> > Cc: ltp@lists.linux.it
> > Sent: Tuesday, 21 June, 2016 9:56:13 AM
> > Subject: Re: [PATCH] mem/lib: Keep KSM off when child_alloc() allocate memory in single thread
> > > What if KSM was enabled before test started?
> > 
> > From what I know about KSM, if a memory area affected by function
> > madvise(..., MADV_MERGEABLE), the samepages located in that merory will be
> > easily merged by ksmd as long as we turn it on (echo 1
> > >/sys/kernel/mm/ksm/run).
> > 
> > And the ".../ksm/run" default value is 0, it means if we just affect
> > the memory area by madvise() function but with ksmd off, there won't
> > have any samepages be merged.
> 
> True, but there's no guarantee that every distro and every user will
> keep the default set to 0. As I recall IBM's PowerKVM has KSM enabled
> by default.

Okay, that sounds more reasonable.

> 
> > > I'd skip this entire else block if lite == 1. With KSM off, it's nearly
> > > identical to oom(NORMAL).
> > 
> > Hmm, actually there still have a little bit difference from
> > oom(NORMALNORMAL).
> > 
> > In alloc_mem() function, if testcase == KSM, the memory area will do
> > madvise operation like:
> > 	madvise(s, length, MADV_MERGEABLE)
> 
> That's what I meant by "nearly identical". Looking at kernel,
> only ksm seems to care about that flag, and we turn KSM off:

Seems like skip oom(KSM) here is better than turn it off. :)

I'll rewrite a new one. Thanks!

Regards,
Li WANG
