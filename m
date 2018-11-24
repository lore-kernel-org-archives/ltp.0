From: Jan Stancek <jstancek@redhat.com>
Date: Sat, 24 Nov 2018 03:51:40 -0500 (EST)
Subject: [LTP] [PATCH RFC] mtest06/mmap1: rewrite to newlib
In-Reply-To: <CAEemH2cUshFdN7UWOLJOZ=+bYPhmsqX22us39fgOOW7v-XrunA@mail.gmail.com>
References: <bb56352d02aac0b65a5fa53ae29014e15c929b24.1542707357.git.jstancek@redhat.com>
 <CAEemH2dyAM7joV2d9vWJOH+yikyCUj74YipzUk0ozYtafi=OTg@mail.gmail.com>
 <2101236614.78046900.1542973050144.JavaMail.zimbra@redhat.com>
 <CAEemH2cUshFdN7UWOLJOZ=+bYPhmsqX22us39fgOOW7v-XrunA@mail.gmail.com>
Message-ID: <1913947285.78238506.1543049500421.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> On Fri, Nov 23, 2018 at 7:37 PM Jan Stancek <jstancek@redhat.com> wrote:
> > >
> > > My question is why not write 'b' to the mapped area? since the mapped
> > > file is already initialized with full of 'a', if here we still use 'a'
> > > how can we know it works or not when reading from a parallel thread?
> >
> > I think this is more for the purpose to dirty mapped memory.
> >
> > The check for 'a' doesn't check only write, it races against entire
> > duration of mmap. Read and mmap can race in a way, where address will be
> > already valid, but if you read from it before mmap completes you get 0.
> 
> Ok, I think I got your point.
> 
> > > And btw, without synchronization between these two threads, I doubt
> > > that increases counter can guarantee a read perfectly between
> > > map/unmap.
> >
> > Writing 'b' would be one more layer you need to care about, because
> > not only you have to write between map and unmap, but you also need
> > to make sure you read only that memory where you wrote 'b' previously.
> 
> I have a simple way to solve that additional layer issue, what we can
> try is just go back to read again if the mapped area have not been
> updated. It gives more chance to visit that memory area and doesn't
> break anything in race condition. Maybe this is superfluous to verify
> thread_A writes correctly, but it implements that thread_B reading
> follow up with thread_A writing.

This is interesting idea. It adds a check that memory will be
eventually updated. And it's also guaranteed to not loop
indefinitely. And re-generating the file now has more sense too :-)

I'll let it run over weekend and can post v2 next week.

Thanks,
Jan

> 
> Something maybe like:
> -----------------------------
> void *read_mem(LTP_ATTRIBUTE_UNUSED void *ptr)
> {
>     int i, j, ar_map, ar_unmap;
>     unsigned char c;
> 
>     for (i = 0; i < num_iter; i++) {
>         if (setjmp(jmpbuf) == 1)
>             continue;
> 
>         for (j = 0; j < file_size; j++) {
> read_again:
>             br_map = tst_atomic_load(&mapcnt);
>             br_unmap = tst_atomic_load(&unmapcnt);
> 
>             c = map_address[j];
> 
>             ar_unmap = tst_atomic_load(&unmapcnt);
>             ar_map = tst_atomic_load(&mapcnt);
> 
>             if (was_area_mapped(br_map, br_unmap, ar_map, ar_unmap)) {
>                 switch(c){
>                     case 'a':
>                         goto read_again;
>                     case 'b':
>                         data_matched++;
>                         break;
>                     default:
>                         tst_res(TFAIL, "value at offset %d is %c", j, c);
>                         break;
>                 }
>             }
>         }
>     }
> 
>     return NULL;
> }
> 
> >
> > > Or, do we only care about the read process but not the
> > > result? I'm not sure I have fully understood this method but got many
> > > failures after replace to wrote 'b' in above functions:
> >
> > Here's a thread from last year with other ideas:
> >   https://lists.linux.it/pipermail/ltp/2017-November/006323.html
> >
> > We could add mutexes, write/check 'b', but then read would never race
> > with mmap/munmap - which by my understanding was the intention.
> 
> I think you are right, thread synchronization seems not satisfy for
> this situation.
> 
> --
> Regards,
> Li Wang
> 
