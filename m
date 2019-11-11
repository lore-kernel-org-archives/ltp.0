From: Christoph Hellwig <hch@infradead.org>
Date: Mon, 11 Nov 2019 00:38:15 -0800
Subject: [LTP] LTP: diotest4.c:476: read to read-only space. returns 0:
 Success
In-Reply-To: <1751469294.11431533.1573460380206.JavaMail.zimbra@redhat.com>
References: <CA+G9fYtmA5F174nTAtyshr03wkSqMS7+7NTDuJMd_DhJF6a4pw@mail.gmail.com>
 <852514139.11036267.1573172443439.JavaMail.zimbra@redhat.com>
 <20191111012614.GC6235@magnolia>
 <1751469294.11431533.1573460380206.JavaMail.zimbra@redhat.com>
Message-ID: <20191111083815.GA29540@infradead.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Nov 11, 2019 at 03:19:40AM -0500, Jan Stancek wrote:
> > > loff_t length,
> > >                 if (pad)
> > >                         iomap_dio_zero(dio, iomap, pos, fs_block_size -
> > >                         pad);
> > >         }
> > > -       return copied ? copied : ret;
> > > +       return copied ? (loff_t) copied : ret;
> > 
> > I'm a little confused on this proposed fix -- why does casting size_t
> > (aka unsigned long) to loff_t (long long) on a 32-bit system change the
> > test outcome?
> 
> Ternary operator has a return type and an attempt is made to convert
> each of operands to the type of the other. So, in this case "ret"
> appears to be converted to type of "copied" first. Both have size of
> 4 bytes on 32-bit x86:

Sounds like we should use a good old if here to avoid that whole problem
spacE:

	if (copied)
		return copied;
	return ret;

> size_t copied = 0;
> int ret = -14;
> long long actor_ret = copied ? copied : ret;
> 
> On x86_64: actor_ret == -14;
> On x86   : actor_ret == 4294967282
> 
> > Does this same diotest4 failure happen with XFS?  I ask
> > because XFS has been using iomap for directio for ages.
> 
> Yes, it fails on XFS too.

Is this a new test?  If not why was this never reported?  Sounds like
we should add this test case to xfstests.
