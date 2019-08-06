From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Tue, 06 Aug 2019 09:36:35 +0200
Subject: [LTP] [RFC PATCH 1/9] lib: Add support for guarded buffers
In-Reply-To: <CAEemH2dBj6Re=+booW5Lc77P1yumEbqP_4g6NMRPji-CtUG-aw@mail.gmail.com>
References: <20190801092616.30553-1-chrubis@suse.cz>
 <20190801092616.30553-2-chrubis@suse.cz>
 <CAEemH2dBj6Re=+booW5Lc77P1yumEbqP_4g6NMRPji-CtUG-aw@mail.gmail.com>
Message-ID: <8736ied9to.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Li Wang <liwang@redhat.com> writes:
>
> I tend to agree with Richard for this. Looks like adding such a new
> field in tst_test struct is a little bit complicated. Maybe we can
> define a series macro for doing that, which something likes:
>
> TST_INIT_GUARD_BUFFER(ptr, size)

I think tst_alloc() is OK (although maybe it should be
tst_guarded_alloc()), but the API is missing its inverse; tst_free().

> TST_INIT_IOVEC_GUARD_BUFFER(ptr, iov_sizes)

Or I guess, tst_alloc() could take tst_buffer(s) as its argument and
return the right type of buffer based on that.

>
> then, testcase just calling it in setup() if needed.

I don't think allocating the buffers in tst_test is a bad idea in
some/most cases. I think the problem is that some primitive, low level
functions are missing, which will make edge cases difficult to deal
with.

--
Thank you,
Richard.
