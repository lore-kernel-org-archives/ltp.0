From: Li Wang <liwang@redhat.com>
Date: Wed, 9 Sep 2020 16:46:29 +0800
Subject: [LTP] LTP release
In-Reply-To: <20200908153659.GA16066@yuki.lan>
References: <20200908073138.GB2475@yuki.lan>
 <CAEemH2cHvM_KD7W6fyX6z3bc0qfVtkp=yEM8MDvvohouyj5N2w@mail.gmail.com>
 <20200908153659.GA16066@yuki.lan>
Message-ID: <CAEemH2eq0fwF8zt1uez5vuwM0vtrLtoFd_45sFqE=iQ8hpudfQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Sep 8, 2020 at 11:36 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > And I'd like to add the MAP_GROWSDOWN test too, but I haven't come up
> with
> > a way to solve the segment fault on s390x.
> > http://lists.linux.it/pipermail/ltp/2020-August/018416.html
>
> Maybe we end up allocating a mapping that is too close to something
> else, see:
>
>
> https://stackoverflow.com/questions/56888725/why-is-map-growsdown-mapping-does-not-grow
>
> I guess that we should make the initial mmap in find_free_range() larger
> and return and adress that is quaranteed not to have a mapping that is
> closer than 256 pages in the direction we want to grow.
>

Sounds reasonable. I tried to reserve more space for the mapping grows, and
that works for me:).

static void *find_free_range(size_t size)
{
    void *mem;

    /*
    * To avoid the mapping grows to within a page of the high end of
    * the next lower mapping, which might result in a SIGSEGV signal.
    * Here reserve twifold memory spaces for growing, especially for s390x.
    */
    mem = SAFE_MMAP(NULL, size * 2, PROT_READ | PROT_WRITE,
    MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
    SAFE_MUNMAP(mem, size * 2);

    return mem;
}

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200909/6a41a5be/attachment.htm>
