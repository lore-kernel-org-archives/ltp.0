From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 27 Nov 2018 03:54:42 -0500 (EST)
Subject: [LTP] [PATCH v2] mtest06/mmap1: rewrite to newlib
In-Reply-To: <CAEemH2eOUxC+M17kagF=9fOPeEBHJFEFYYBO20LnhUtwa+qmNA@mail.gmail.com>
References: <0e62adebbb4e5c8e3aa28440f860234b937d3e56.1543219161.git.jstancek@redhat.com>
 <CAEemH2eOUxC+M17kagF=9fOPeEBHJFEFYYBO20LnhUtwa+qmNA@mail.gmail.com>
Message-ID: <1068520574.79012810.1543308882560.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> On Mon, Nov 26, 2018 at 4:21 PM Jan Stancek <jstancek@redhat.com> wrote:
> 
> > +static void sig_handler(int signal, siginfo_t *info,
> > +       LTP_ATTRIBUTE_UNUSED void *ut)
> > +{
> > +       int ar_m, ar_u;
> > +
> > +       switch (signal) {
> > +       case SIGSEGV:
> > +               /* if we hit SIGSEGV between map/unmap, something is wrong
> > */
> > +               ar_u = tst_atomic_load(&unmapcnt);
> > +               ar_m = tst_atomic_load(&mapcnt);
> > +               if (was_area_mapped(br_map, br_unmap, ar_m, ar_u)) {
> > +                       tst_res(TFAIL, "got sigsegv while mapped");
> > +                       _exit(TFAIL);
> 
> why not use tst_brk() here?

Because it calls exit(), which is not advised to do in signal handler.
(doc/test-writing-guidelines.txt, line 841)

> 
> > +               }
> > +
> > +               mapped_sigsegv_count++;
> > +               longjmp(jmpbuf, 1);
> > +               break;
> > +       default:
> > +               tst_res(TFAIL, "Unexpected signal - %d, addr: %p,
> > exiting\n",
> > +                       signal, info->si_addr);
> > +               _exit(TBROK);
> 
> tst_brk() ?
> 
> > +       }
> > +}
> > +
> > +void *map_write_unmap(void *ptr)
> > +{
> > +       long *args = ptr;
> > +       void *tmp;
> 
> remove tmp pointer?

It introduces warning in safe_munmap(), because map_address is volatile.
That is why I kept 'tmp'.

> 
> Beside these tiny issues, patch v2 looks good to me.
> 
> Reviewed-by: Li Wang <liwang@redhat.com>

Thanks,
Jan

> 
> --
> Regards,
> Li Wang
> 
