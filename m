From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 2 Aug 2019 11:47:08 +0200
Subject: [LTP] [RFC PATCH 2/9] lib: Add a canary for guarded buffers
In-Reply-To: <1801920982.4081964.1564677172725.JavaMail.zimbra@redhat.com>
References: <20190801092616.30553-1-chrubis@suse.cz>
 <20190801092616.30553-3-chrubis@suse.cz>
 <1516778317.3992530.1564656190448.JavaMail.zimbra@redhat.com>
 <20190801115418.GB23916@rei>
 <1801920982.4081964.1564677172725.JavaMail.zimbra@redhat.com>
Message-ID: <20190802094708.GA27727@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > I'm aware of that. My reasoning here is that:
> > 
> > * The end of the page is aligned by definition to 2^page_order
> > 
> > * Any primitive types such as integer, etc. are hence aligned
> > 
> > * Structures are padded so that the total size is multiple of
> >   the largest alignment required (because otherwise arrays of
> >   structures would end up causing unaligned access as well).
> > 
> > That leaves out things such as buffers for direct I/O, the only way to
> > allocate aligned buffers there is to make the size to be multiple of
> > the block size.
> 
> I don't have concrete example at hand, but I foggily recall
> s390 issue from couple years back, where it didn't like odd addresses.
> Can't recall if it was data or code pointer.

Data should be fine as far as they are aligned accordingly to the type sizes.

I.e. one byte acces is fine on odd addresses, otherwise most of the
functions in string.h wouldn't work.

For shorts i.e. two byte integers odd addresses are slower on x86 and
x86_64 however does not work at all on many architectures. I remember
that 32bit arm used to have in-kernel emulation that mostly did the
right job but sometimes you got wrong results, so unaligned accesses are
better to be avoided.

The question is if kernel expects some alignment for buffers for things
such as read()/write() etc. I doubt so, since that would still break
things like write(fd, "aabbcc" + 1, 3) which I would expect is still
valid code.

Or do you have anything else in mind that may break?

> Could we apply/enforce some minimum alignment, similar to what glibc
> does for malloc?

That would be against the purpose of this patchset, i.e. catching
off-by-one bugs, since the page boundary would be a few bytes after the
end of the buffer in some cases. Well I guess that most of the
allocations would be as a matter of fact aligned and even these that are
not could be easily fixed by choosing buffers that are multiples of
four.

I would be fine with aligning the buffers for architectures that turn
out to be problematic if we find some. However I would like to avoid to
"just in case" modifications.

-- 
Cyril Hrubis
chrubis@suse.cz
