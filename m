From: Li Wang <liwang@redhat.com>
Date: Thu, 21 Jul 2016 19:02:00 +0800
Subject: [LTP] [PATCH] madvise06: wait a bit after madvise() call
In-Reply-To: <597691787.18542977.1469097118207.JavaMail.zimbra@redhat.com>
References: <8eb6f485a46b9d9fb62eec232bf7bcb2d4cf4215.1468848169.git.jstancek@redhat.com>
 <20160719055844.GA31704@gmail.com>
 <1822250385.6269456.1468911402613.JavaMail.zimbra@redhat.com>
 <20160719085756.GB31704@gmail.com> <578F8CB6.2020602@redhat.com>
 <597691787.18542977.1469097118207.JavaMail.zimbra@redhat.com>
Message-ID: <20160721110159.GA13274@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Jul 21, 2016 at 06:31:58AM -0400, Chunyu Hu wrote:
> > 
> > If you still have the setup, can you try how reliable is this approach?
> 
> I also had a try on my desktop. I copied the file as a.c and compiled it in ltp.
> Result is that if the sys is fresh with low Cache, it can pass rightly. But if 
> the Cache is before exhausted, it can hit failure, as the thresh_hold is too
> large to get there. Just FYI. 

Yes, Chunyu ran failed the case with his destop(uptime more than 30days) at first,
after rebooting it could be PASS.

We guess the reason is the current usage of SwapCached are too large and
madvise_willneed() could not shift the memory(swapout) into swapcache.

To verify this image we incresed SwapCached by another program(background)
then it always get failures like that. Probably it's still hitting the
situations we discussed before:

  2. It pending I/O with short dely.
  3. kernel ignoring the request for unknow reasons.

Regards,
Li Wang
