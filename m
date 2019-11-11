From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 11 Nov 2019 03:19:40 -0500 (EST)
Subject: [LTP] LTP: diotest4.c:476: read to read-only space. returns 0:
 Success
In-Reply-To: <20191111012614.GC6235@magnolia>
References: <CA+G9fYtmA5F174nTAtyshr03wkSqMS7+7NTDuJMd_DhJF6a4pw@mail.gmail.com>
 <852514139.11036267.1573172443439.JavaMail.zimbra@redhat.com>
 <20191111012614.GC6235@magnolia>
Message-ID: <1751469294.11431533.1573460380206.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> I can't do a whole lot with a code snippet that lacks a proper SOB
> header.

I'll resend as a patch, maybe split it to 2 returns instead.

> > diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> > index 2f88d64c2a4d..8615b1f78389 100644
> > --- a/fs/iomap/direct-io.c
> > +++ b/fs/iomap/direct-io.c
> > @@ -318,7 +318,7 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos,
> > loff_t length,
> >                 if (pad)
> >                         iomap_dio_zero(dio, iomap, pos, fs_block_size -
> >                         pad);
> >         }
> > -       return copied ? copied : ret;
> > +       return copied ? (loff_t) copied : ret;
> 
> I'm a little confused on this proposed fix -- why does casting size_t
> (aka unsigned long) to loff_t (long long) on a 32-bit system change the
> test outcome?

Ternary operator has a return type and an attempt is made to convert
each of operands to the type of the other. So, in this case "ret"
appears to be converted to type of "copied" first. Both have size of
4 bytes on 32-bit x86:

size_t copied = 0;
int ret = -14;
long long actor_ret = copied ? copied : ret;

On x86_64: actor_ret == -14;
On x86   : actor_ret == 4294967282

> Does this same diotest4 failure happen with XFS?  I ask
> because XFS has been using iomap for directio for ages.

Yes, it fails on XFS too.

