From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 13 Oct 2020 13:59:35 +0200
Subject: [LTP] [PATCH 04/11] docparse: Add README
In-Reply-To: <135581472.16896262.1601907346856.JavaMail.zimbra@redhat.com>
References: <20201005133054.23587-1-chrubis@suse.cz>
 <20201005133054.23587-5-chrubis@suse.cz>
 <135581472.16896262.1601907346856.JavaMail.zimbra@redhat.com>
Message-ID: <20201013115935.GB29925@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > +Open Points
> > +===========
> > +
> > +There are stil some loose ends. Mostly it's not well defined where to put
> > +things and how to format them.
> > +
> > +* Some of the hardware requirements are already listed in the tst\_test.
> > Should
> > +  we put all of them there?
> > +
> > +* What would be the format for test documentation and how to store things
> > such
> > +  as test variants there?
> 
> I'm assuming you don't mean ".test_variants" here, but runtest entries
> using same binary with different parameters. Currently we have a "tag"
> that can refer to binary+parameters pair. Which is also useful, for
> skipping tests - e.g. they run long, they are broken, or older kernel
> is known to crash - we have a list of checks that modify runtest files
> before actual run to avoid running into known issues (or save time).

Yes I do mean binary parameters here. And yes we will need a way how to
express skiplist for this as well.

-- 
Cyril Hrubis
chrubis@suse.cz
