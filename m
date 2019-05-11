From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 11 May 2019 12:30:51 +0300
Subject: [LTP] [PATCH v4] syscalls/swap{on,
 off}: fail softly if FIBMAP ioctl trial fails
In-Reply-To: <20190511042014.xlonuwqpg6owg6a3@XZHOUW.usersys.redhat.com>
References: <CAOQ4uxjDyx7JFBSmkDe-rHNe=NriT710Ldsva=s+HasaDL0CTw@mail.gmail.com>
 <20190510044217.5215-1-xzhou@redhat.com>
 <CAOQ4uxi1=Xj59GvyrJf9HiMgGvRYTC8HGG8UOZKz3B8zgGh52g@mail.gmail.com>
 <20190510081535.ax7th47uyjjkayk6@XZHOUW.usersys.redhat.com>
 <CAOQ4uxjAzTL+aN4SdvD7xEUhuOht0nc70JDUOqAHGoyChOyPbA@mail.gmail.com>
 <20190511042014.xlonuwqpg6owg6a3@XZHOUW.usersys.redhat.com>
Message-ID: <CAOQ4uxjQ918iCXv3XdzmyKfQjqzBu-=N3Y+-BXDmrEDH-KVfpQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Sat, May 11, 2019 at 7:20 AM Murphy Zhou <xzhou@redhat.com> wrote:
>
> On Fri, May 10, 2019 at 11:48:42AM +0300, Amir Goldstein wrote:
> > On Fri, May 10, 2019 at 11:15 AM Murphy Zhou <xzhou@redhat.com> wrote:
> > >
> > > On Fri, May 10, 2019 at 08:27:35AM +0300, Amir Goldstein wrote:
> > > > On Fri, May 10, 2019 at 7:42 AM Murphy Zhou <xzhou@redhat.com> wrote:
> > > > >
> > > > > Add a test helper to do a FIBMAP ioctl test. Remove old fs type whitelist code.
> > > >
> > > > If you wouldn't have just done that it would have been good.
> > > > But your patch also changes a lot of the logic and output messages,
> > > > which is less good.
> > >
> > > First of all, don't be mad if you think I'm changing too much. :)
> >
> > Not mad. Sorry if came off this way..
> > Just trying to explain why too much changes can be counter productive.
> > And I am writing my opinion, you are not obliged to agree with it ;-)
>
> Start your developer engine. Actually _think_ about what your're writing.
> Your opinion varies every single post in this thread.
>

I sense that I offended you. I did not mean to. I apologize.
There might have been some miscommunication.
My option varied after incorporating feedback from Li Wang and looking
closer at recent kernel changes to btrfs, which I was not aware of.

To be clear, my current opinion is:
- As Li suggested, it is best to check filesystem support in setup()
using swapon()
  and the rest of the test should not relax any failure
- By checking FIBMAP before swapon() in setup() you can differentiate between
  failing the test (for legacy fs) or TCONF (BTRFS, NFS)
- TCONF result should be accompanied with "not supported" language
- Take care not to change test logic in a way that will regress test on older
  kernels or some filesystem

[...]
> > Put your tester hat on. Imagine you do not know what swapfile is nor
> > that filesystems may support it or not.
> > Which is the following messages convey the test result better:
> >
> > TCONF: Failed to make swapfile
> >
> > OR
> >
> > TCONF: mkswap not supported on btrfs filesystem
>
> You are ranting at wrong guy. It was not me writing this message.
>

Certainly. It wasn't my intention to blame you for anything.
The developer that wrote this message did not expect tmpfs to reach this
point, because blacklist was in place.
By changing from TBROK to TCONF, the message may need to change
from a language of "Failed" to a language of "not supported".

> >
> > If test setup arrives to a conclusion that filesystem doesn't support test
> > and test should be skipped, that is what should be communicated to user.
> >
> > The BTRFS_MAGIC code that your patch removes does that correctly.
> > Your patch does not.
> >
> > Even the message:
> > TCONF: "Will not report FAIL as FIBMAP ioctl not supported"
> > is "too much information" IMO.
> > Users without proper background won't know what it means.
> > This would have been better IMO:
> > TCONF: "FIBMAP ioctl not supported on XXX filesystem"
>
> I guess LTP is not a desktop app :), but yes these messages need improvement.
>

Test engineers can spend a lot of time figuring out why a certain test
(of a feature they
are not intimately familiar with) has started failing on a certain
kernel version or after
getting latest LTP.
We should be sympathetic to our end users and try to make their lives
easier if it is
in our power.

Thanks,
Amir.
