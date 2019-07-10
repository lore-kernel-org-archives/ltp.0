From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 10 Jul 2019 14:59:54 +0200
Subject: [LTP] [PATCH RFC] move_pages12: handle errno EBUSY for
 madvise(..., MADV_SOFT_OFFLINE)
In-Reply-To: <CAEemH2eMA78=5eNwJnZPJ1kw1GZnimSyBsQ+e_wrAu3E+JOoPg@mail.gmail.com>
References: <20190607095213.13372-1-liwang@redhat.com>
 <20190703131005.GA1712@rei>
 <CAEemH2fGUABOfz=Yq6xONgmHwjaiU6n_q=9EXyZz2EUedpuK8Q@mail.gmail.com>
 <CAEemH2eMA78=5eNwJnZPJ1kw1GZnimSyBsQ+e_wrAu3E+JOoPg@mail.gmail.com>
Message-ID: <20190710125954.GA5628@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > iteration, the mmap() will be failed with ENOMEM(since we only have 1 huge
> > page in /proc/.../nr_hugepages).
> >
> 
> Sentence correction:
>     It is not "only have 1 huge page in nr_hugepages", I mixed this test
> with another case, sorry about that.
> 
> But the justification is the same, we don't have enough memory for the
> parent does mmap(..., MAP_HUGETLB) in a new loop.

I guess I get it now, if we attempt to continue after EBUSY we unmap()
the memory but that unmap() will happen asynchronously because the
migration is in progress and we hit ENOMEM just in the next iteration of
the loop.

Should we then attempt to retry the mmap() on ENOMEM as well, ideally
with exponential backoff?

Unfortunately we cannot reuse the TST_RETRY_FUNC() as it is because it
exits the test with TBROK on failure, we need a function that actually
returns the last function return value on timeout.

-- 
Cyril Hrubis
chrubis@suse.cz
