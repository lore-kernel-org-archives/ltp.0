From: Li Wang <liwang@redhat.com>
Date: Wed, 20 Nov 2019 10:19:15 +0800
Subject: [LTP] [PATCH] tst_fill_fs: enhance the filesystem filling
 routine
In-Reply-To: <c9d278e6-5700-6c16-019b-1770a6ede0ff@suse.cz>
References: <20191119094156.20348-1-liwang@redhat.com>
 <1860355560.12961927.1574161647388.JavaMail.zimbra@redhat.com>
 <CAEemH2cN8qv_YpsFKJazcOKEvgfjXpacZOV_Er-0bjK86=6VpQ@mail.gmail.com>
 <c9d278e6-5700-6c16-019b-1770a6ede0ff@suse.cz>
Message-ID: <CAEemH2dZCm5MVyhzWiFKVK-jt+UUw65u5CRFk-moUVUgpDHHWg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Nov 19, 2019 at 10:24 PM Martin Doucha <mdoucha@suse.cz> wrote:

> On 11/19/19 3:03 PM, Li Wang wrote:
> > On Tue, Nov 19, 2019 at 7:07 PM Jan Stancek <jstancek@redhat.com
> > <mailto:jstancek@redhat.com>> wrote:
> >
> >     ----- Original Message -----
> >     > -             while (len) {
> >     > +             while (len >= fi.f_bsize) {
> >
> >     Let's say f_bsize is 512, and len is 1023. We hit ENOSPC for 1023,
> >     len for next round is 511. Loop ends, but we never tried write with
> >     f_bsize or smaller value.
> >
> >     I think we should try len < fi.f_bsize@least once.
> >
> >
> > Good point. At least for len = fi.f_bsize.
>
> You don't need to reduce the write size in the first place. Kernel will
> happily do short writes for you if the file system somehow finds some
>

You're probably right, but here I just want to enhance the tst_fill_fs
routine, it obviously couldn't  be guaranteed way to perfectly fill a
filesystem, this action from userspace is what I can think of.


> free blocks. The more important question is how to trigger garbage
> collection of internal file system book-keeping data.
>

Okay. I'm not good at FS issues. Or, do you have a better idea for that?

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20191120/12246ea0/attachment.htm>
