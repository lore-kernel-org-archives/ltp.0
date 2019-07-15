From: Li Wang <liwang@redhat.com>
Date: Mon, 15 Jul 2019 17:33:51 +0800
Subject: [LTP] [PATCH RFC] move_pages12: handle errno EBUSY for
 madvise(..., MADV_SOFT_OFFLINE)
In-Reply-To: <20190710125954.GA5628@rei.lan>
References: <20190607095213.13372-1-liwang@redhat.com>
 <20190703131005.GA1712@rei>
 <CAEemH2fGUABOfz=Yq6xONgmHwjaiU6n_q=9EXyZz2EUedpuK8Q@mail.gmail.com>
 <CAEemH2eMA78=5eNwJnZPJ1kw1GZnimSyBsQ+e_wrAu3E+JOoPg@mail.gmail.com>
 <20190710125954.GA5628@rei.lan>
Message-ID: <CAEemH2ffEk0QT_LHdo6NEuy2FRkwe4j1rRgf9C0E8HzQE-V_eA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Jul 10, 2019 at 9:00 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > > iteration, the mmap() will be failed with ENOMEM(since we only have 1
> huge
> > > page in /proc/.../nr_hugepages).
> > >
> >
> > Sentence correction:
> >     It is not "only have 1 huge page in nr_hugepages", I mixed this test
> > with another case, sorry about that.
> >
> > But the justification is the same, we don't have enough memory for the
> > parent does mmap(..., MAP_HUGETLB) in a new loop.
>
> I guess I get it now, if we attempt to continue after EBUSY we unmap()
> the memory but that unmap() will happen asynchronously because the
> migration is in progress and we hit ENOMEM just in the next iteration of
> the loop.
>
> Should we then attempt to retry the mmap() on ENOMEM as well, ideally
> with exponential backoff?
>

Not very sure if that worth to do.

>
> Unfortunately we cannot reuse the TST_RETRY_FUNC() as it is because it
> exits the test with TBROK on failure, we need a function that actually
> returns the last function return value on timeout.
>

Yes, we could define a new TST_WAIT_FUNC() to return mmap() returned value
on timeout, but it seems hard to give an expected return(ERET) value for
that function, in this case, we could define the ERET as addr since we know
it, but for most situations, we can't make sure what is the address being
returned. Once the returned address is not equal ERET, then it will retry
the mmap() and do not unmmap() the previous memory. That will be terrible.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190715/6697d258/attachment.htm>
