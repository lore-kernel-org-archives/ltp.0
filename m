From: Li Wang <liwang@redhat.com>
Date: Wed, 9 Sep 2020 20:16:47 +0800
Subject: [LTP] LTP release
In-Reply-To: <CAEemH2eq0fwF8zt1uez5vuwM0vtrLtoFd_45sFqE=iQ8hpudfQ@mail.gmail.com>
References: <20200908073138.GB2475@yuki.lan>
 <CAEemH2cHvM_KD7W6fyX6z3bc0qfVtkp=yEM8MDvvohouyj5N2w@mail.gmail.com>
 <20200908153659.GA16066@yuki.lan>
 <CAEemH2eq0fwF8zt1uez5vuwM0vtrLtoFd_45sFqE=iQ8hpudfQ@mail.gmail.com>
Message-ID: <CAEemH2es3sMSfAar8Xj4_Vr+2nsD0isPws4v=8=csLyYROAQGQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Sep 9, 2020 at 4:46 PM Li Wang <liwang@redhat.com> wrote:

>
>
> On Tue, Sep 8, 2020 at 11:36 PM Cyril Hrubis <chrubis@suse.cz> wrote:
>
>> Hi!
>> > And I'd like to add the MAP_GROWSDOWN test too, but I haven't come up
>> with
>> > a way to solve the segment fault on s390x.
>> > http://lists.linux.it/pipermail/ltp/2020-August/018416.html
>>
>> Maybe we end up allocating a mapping that is too close to something
>> else, see:
>>
>>
>> https://stackoverflow.com/questions/56888725/why-is-map-growsdown-mapping-does-not-grow
>>
>> I guess that we should make the initial mmap in find_free_range() larger
>> and return and adress that is quaranteed not to have a mapping that is
>> closer than 256 pages in the direction we want to grow.
>>
>
> Sounds reasonable. I tried to reserve more space for the mapping grows,
> and that works for me:).
>

To precisely, we could reserve 256 pages size at the end of the free-range
memory to let the stack keep away from a preceding mapping in its growing
then.
(my only concern is the stack_guard_gap can be changed via kernel command
line, but I assume that happen rarely, so here use the default 256 pages)

If there is no objection, I'd make these changes in patch V4.

--------

static void *find_free_range(size_t size)
{
    void *mem;
    long stack_guard_gap = 256 * getpageszie();

    /*
    * Since the newer kernel does not allow a MAP_GROWSDOWN mapping to grow
    * closer than stack_guard_gap pages away from a preceding mapping.
    * The guard then ensures that the next-highest mapped page remains more
    * than stack_guard_gap below the lowest stack address, and if not then
    * it will trigger a segfault. So, here let's reserve 256 pages memory
    * spacing for stack growing safely.
    */
    mem = SAFE_MMAP(NULL, size + stack_guard_gap, PROT_READ | PROT_WRITE,
                      MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
    SAFE_MUNMAP(mem, size + stack_guard_gap);

    return mem;
}

static void split_unmapped_plus_stack(void *start, size_t size)
{
    /* start           start + size
    * +---------------------+----------------------+-----------+
    * + unmapped            | mapped               | 256 pages |
    * +---------------------+----------------------+-----------+
    *                       stack
    */
    stack = SAFE_MMAP(start + size, size, PROT_READ | PROT_WRITE,
                             MAP_FIXED | MAP_PRIVATE | MAP_ANONYMOUS |
MAP_GROWSDOWN,
                             -1, 0);
}

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200909/47ddab4d/attachment-0001.htm>
