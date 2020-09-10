From: Li Wang <liwang@redhat.com>
Date: Thu, 10 Sep 2020 15:12:14 +0800
Subject: [LTP] LTP release
In-Reply-To: <20200909131327.GA3241@yuki.lan>
References: <20200908073138.GB2475@yuki.lan>
 <CAEemH2cHvM_KD7W6fyX6z3bc0qfVtkp=yEM8MDvvohouyj5N2w@mail.gmail.com>
 <20200908153659.GA16066@yuki.lan>
 <CAEemH2eq0fwF8zt1uez5vuwM0vtrLtoFd_45sFqE=iQ8hpudfQ@mail.gmail.com>
 <CAEemH2es3sMSfAar8Xj4_Vr+2nsD0isPws4v=8=csLyYROAQGQ@mail.gmail.com>
 <20200909131327.GA3241@yuki.lan>
Message-ID: <CAEemH2e7QZu3HeGfo2-+8jAOhVCatw7X+A4dEq_1PEasU3N1CQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Sep 9, 2020 at 9:13 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> ...
> > static void split_unmapped_plus_stack(void *start, size_t size)
> > {
> >     /* start           start + size
> >     * +---------------------+----------------------+-----------+
> >     * + unmapped            | mapped               | 256 pages |
> >     * +---------------------+----------------------+-----------+
> >     *                       stack
> >     */
>
> Shouldn't the 256 pages follow the unmapped part?
>

Yes, you're right. I made a mistake on draw that. Will fix in V4.


>
> If I'm not mistaken if stack grows down the address decreases with stack
> allocations, so it should be as:
>
> | 256 pages | unmapped | mapped |
>
>
> That would also mean that we should map the stack at address start +
> total_size - size if I'm not mistaken. I guess that we can put all the
> mess into a single function as well and have just allocate_stack() that
> will find a suitable address, mmap the stack together, splitting this
> into two functions is unnecessary confusing.
>

Good point, it makes sense to me.



>
> >     stack = SAFE_MMAP(start + size, size, PROT_READ | PROT_WRITE,
> >                              MAP_FIXED | MAP_PRIVATE | MAP_ANONYMOUS |
> > MAP_GROWSDOWN,
> >                              -1, 0);
> > }
>
> Also I would like to get rid of the -fno-optimize-sibling-calls in the
> Makefile, this makes the test a bit fragile and less portable.
>
> --
> Cyril Hrubis
> chrubis@suse.cz
>
>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200910/52c12c26/attachment.htm>
