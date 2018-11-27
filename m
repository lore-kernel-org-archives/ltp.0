From: Li Wang <liwan@redhat.com>
Date: Tue, 27 Nov 2018 14:37:27 +0800
Subject: [LTP] [PATCH v2] mtest06/mmap1: rewrite to newlib
In-Reply-To: <0e62adebbb4e5c8e3aa28440f860234b937d3e56.1543219161.git.jstancek@redhat.com>
References: <0e62adebbb4e5c8e3aa28440f860234b937d3e56.1543219161.git.jstancek@redhat.com>
Message-ID: <CAEemH2eOUxC+M17kagF=9fOPeEBHJFEFYYBO20LnhUtwa+qmNA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Nov 26, 2018 at 4:21 PM Jan Stancek <jstancek@redhat.com> wrote:

> +static void sig_handler(int signal, siginfo_t *info,
> +       LTP_ATTRIBUTE_UNUSED void *ut)
> +{
> +       int ar_m, ar_u;
> +
> +       switch (signal) {
> +       case SIGSEGV:
> +               /* if we hit SIGSEGV between map/unmap, something is wrong */
> +               ar_u = tst_atomic_load(&unmapcnt);
> +               ar_m = tst_atomic_load(&mapcnt);
> +               if (was_area_mapped(br_map, br_unmap, ar_m, ar_u)) {
> +                       tst_res(TFAIL, "got sigsegv while mapped");
> +                       _exit(TFAIL);

why not use tst_brk() here?

> +               }
> +
> +               mapped_sigsegv_count++;
> +               longjmp(jmpbuf, 1);
> +               break;
> +       default:
> +               tst_res(TFAIL, "Unexpected signal - %d, addr: %p, exiting\n",
> +                       signal, info->si_addr);
> +               _exit(TBROK);

tst_brk() ?

> +       }
> +}
> +
> +void *map_write_unmap(void *ptr)
> +{
> +       long *args = ptr;
> +       void *tmp;

remove tmp pointer?

Beside these tiny issues, patch v2 looks good to me.

Reviewed-by: Li Wang <liwang@redhat.com>

--
Regards,
Li Wang
