From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 23 Nov 2018 06:37:30 -0500 (EST)
Subject: [LTP] [PATCH RFC] mtest06/mmap1: rewrite to newlib
In-Reply-To: <CAEemH2dyAM7joV2d9vWJOH+yikyCUj74YipzUk0ozYtafi=OTg@mail.gmail.com>
References: <bb56352d02aac0b65a5fa53ae29014e15c929b24.1542707357.git.jstancek@redhat.com>
 <CAEemH2dyAM7joV2d9vWJOH+yikyCUj74YipzUk0ozYtafi=OTg@mail.gmail.com>
Message-ID: <2101236614.78046900.1542973050144.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> On Tue, Nov 20, 2018 at 5:56 PM Jan Stancek <jstancek@redhat.com> wrote:
> >
> > Fixes: #165
> >
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (c) 2018 Jan Stancek. All rights reserved.
> > + */
> > +/*
> > + * Test: Spawn 2 threads. First thread maps, writes and unmaps
> > + * an area. Second thread tries to read from it. Second thread
> > + * races against first thread. There is no synchronization
> > + * between threads, but each mmap/munmap increases a counter
> > + * that is checked to determine when has read occurred. If a read
> > + * hit SIGSEGV in between mmap/munmap it is a failure. If a read
> > + * between mmap/munmap worked, then its value must match expected
> > + * value.
> > + */
> > +#include <errno.h>
> > +#include <float.h>
> > +#include <pthread.h>
> > +#include <sched.h>
> > +#include <setjmp.h>
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include "tst_test.h"
> > +#include "tst_safe_pthread.h"
> > +
> > +#define DISTANT_MMAP_SIZE (64*1024*1024)
> > +#define TEST_FILENAME "ashfile"
> > +
> > +/* seconds remaining before reaching timeout */
> > +#define STOP_THRESHOLD 10
> > +
> > +#define PROGRESS_SEC 3
> > +
> > +static int file_size = 1024;
> > +static int num_iter = 5000;
> > +static float exec_time = 0.05; /* default is 3 min */
> 
> Maybe we can tweak(or remove) the parameter in runtest file, since
> here we already take use of 'exec_time = 0.05' as the default
> execution time.
> 
> $ grep "mmap1\ " runtest/*
> runtest/mm:mtest06   mmap1 -x 0.05

Fine by me.

> 
> > +
> > +static void *distant_area;
> > +static char *str_exec_time;
> > +static jmp_buf jmpbuf;
> > +static volatile unsigned char *map_address;
> > +static unsigned long page_sz;
> > +
> > +static unsigned long mapped_sigsegv_count;
> > +static unsigned long map_count;
> > +static unsigned long threads_spawned;
> > +static unsigned long data_matched;
> > +
> > +/* sequence id for each map/unmap performed */
> > +static int mapcnt, unmapcnt;
> > +/* stored sequence id before making read attempt */
> > +static int br_map, br_unmap;
> > +
> > +static struct tst_option options[] = {
> > +       {"x:", &str_exec_time, "Exec time (hours)"},
> > +       {NULL, NULL, NULL}
> > +};
> > +
> > +/* compare "before read" counters  with "after read" counters */
> > +static inline int was_area_mapped(int br_m, int br_u, int ar_m, int ar_u)
> > +{
> > +       return (br_m == ar_m && br_u == ar_u && br_m > br_u);
> > +}
> > +
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
> > +       }
> > +}
> > +
> > +void *map_write_unmap(void *ptr)
> > +{
> > +       long *args = ptr;
> > +       void *tmp;
> 
> why involve tmp pointer here, can we remove it?

Ack, looks like leftover.

> 
> > +       int i, j;
> > +
> > +       for (i = 0; i < num_iter; i++) {
> > +               map_address = SAFE_MMAP(distant_area,
> > +                       (size_t) file_size, PROT_WRITE | PROT_READ,
> > +                       MAP_SHARED, (int)args[0], 0);
> 
> Maybe shared memory is not necessary here, I'm guessing 'MAP_PRIVATE'
> could satisfy this test too.

Not sure, I kept it because original test used it.

> 
> > +               tst_atomic_inc(&mapcnt);
> > +
> > +               for (j = 0; j < file_size; j++)
> > +                       map_address[j] = 'a';
> 
> My question is why not write 'b' to the mapped area? since the mapped
> file is already initialized with full of 'a', if here we still use 'a'
> how can we know it works or not when reading from a parallel thread?

I think this is more for the purpose to dirty mapped memory.

The check for 'a' doesn't check only write, it races against entire
duration of mmap. Read and mmap can race in a way, where address will be
already valid, but if you read from it before mmap completes you get 0.

> 
> > +
> > +               tmp = (void *)map_address;
> > +               tst_atomic_inc(&unmapcnt);
> > +               SAFE_MUNMAP(tmp, file_size);
> > +
> > +               map_count++;
> > +       }
> > +
> > +       return NULL;
> > +}
> > +
> > +void *read_mem(LTP_ATTRIBUTE_UNUSED void *ptr)
> > +{
> > +       int i, j, ar_map, ar_unmap;
> > +       unsigned char c;
> > +
> > +       for (i = 0; i < num_iter; i++) {
> > +               if (setjmp(jmpbuf) == 1)
> > +                       continue;
> > +
> > +               for (j = 0; j < file_size; j++) {
> > +                       br_map = tst_atomic_load(&mapcnt);
> > +                       br_unmap = tst_atomic_load(&unmapcnt);
> > +
> > +                       c = map_address[j];
> > +
> > +                       ar_unmap = tst_atomic_load(&unmapcnt);
> > +                       ar_map = tst_atomic_load(&mapcnt);
> > +
> > +                       /*
> > +                        * Read above is racing against munmap and mmap
> > +                        * in other thread. While the address might be
> > valid
> > +                        * the mapping could be in various stages of being
> > +                        * 'ready'. We only check the value, if we can be
> > sure
> > +                        * read hapenned in between single mmap and munmap
> > as
> > +                        * observed by first thread.
> > +                        */
> > +                       if (was_area_mapped(br_map, br_unmap, ar_map,
> > ar_unmap)) {
> > +                               if (c != 'a') {
> 
> If map_write_unmap() wrote into 'b' as I suggested, here we should
> check with 'b'.

That won't work as you noted below.

> 
> And btw, without synchronization between these two threads, I doubt
> that increases counter can guarantee a read perfectly between
> man/unmap. 

Writing 'b' would be one more layer you need to care about, because
not only you have to write between map and unmap, but you also need
to make sure you read only that memory where you wrote 'b' previously.

> Or, do we only care about the read process but not the
> result? I'm not sure I have fully understood this method but got many
> failures after replace to wrote 'b' in above functions:

Here's a thread from last year with other ideas:
  https://lists.linux.it/pipermail/ltp/2017-November/006323.html

We could add mutexes, write/check 'b', but then read wold never race
with mmap/munmap - which by my understanding was the intention.

> 
> # ./mmap1
> tst_test.c:1085: INFO: Timeout per run is 0h 05m 00s
> tst_test.c:1085: INFO: Timeout per run is 0h 03m 00s
> mmap1.c:142: FAIL: value at offset 0 is 61
> mmap1.c:142: FAIL: value at offset 0 is 61
> mmap1.c:142: FAIL: value at offset 0 is 61
> mmap1.c:142: FAIL: value at offset 0 is 61
> mmap1.c:142: FAIL: value at offset 0 is 61
> mmap1.c:142: FAIL: value at offset 0 is 61
> mmap1.c:142: FAIL: value at offset 0 is 61
> mmap1.c:142: FAIL: value at offset 0 is 61
> 
> > +                                       tst_res(TFAIL, "value at offset %d
> > is %02x",
> 
> I prefer to print letter but not number for friendly reading:
>      tst_res(TFAIL, "value at offset %d is %c",
> 
> > +                                               j, c);
> > +                                       break;
> > +                               }
> > +                               data_matched++;
> > +                       }
> > +               }
> > +       }
> > +
> > +       return NULL;
> > +}
> > +
> > +int mkfile(int size)
> > +{
> > +       int fd, i;
> > +
> > +       fd = SAFE_OPEN(TEST_FILENAME, O_RDWR | O_CREAT, 0600);
> > +       SAFE_UNLINK(TEST_FILENAME);
> > +
> > +       for (i = 0; i < size; i++)
> > +               SAFE_WRITE(1, fd, "a", 1);
> > +       SAFE_WRITE(1, fd, "\0", 1);
> > +
> > +       if (fsync(fd) == -1)
> > +               tst_brk(TBROK | TERRNO, "fsync()");
> > +
> > +       return fd;
> > +}
> > +
> > +static void setup(void)
> > +{
> > +       struct sigaction sigptr;
> > +
> > +       page_sz = getpagesize();
> > +
> > +       /*
> > +        * Used as hint for mmap thread, so it doesn't interfere
> > +        * with other potential (temporary) mappings from libc
> > +        */
> > +       distant_area = SAFE_MMAP(0, DISTANT_MMAP_SIZE, PROT_WRITE |
> > PROT_READ,
> > +                       MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
> > +       SAFE_MUNMAP(distant_area, (size_t)DISTANT_MMAP_SIZE);
> > +       distant_area += DISTANT_MMAP_SIZE / 2;
> > +
> > +       if (tst_parse_float(str_exec_time, &exec_time, 0, FLT_MAX)) {
> > +               tst_brk(TBROK, "Invalid number for exec_time '%s'",
> > +                       str_exec_time);
> > +       }
> > +
> > +       sigptr.sa_sigaction = sig_handler;
> > +       sigemptyset(&sigptr.sa_mask);
> > +       sigptr.sa_flags = SA_SIGINFO | SA_NODEFER;
> > +       SAFE_SIGACTION(SIGSEGV, &sigptr, NULL);
> > +
> > +       tst_set_timeout((int)(exec_time * 3600));
> > +}
> > +
> > +static void run(void)
> > +{
> > +       pthread_t thid[2];
> > +       long chld_args[1];
> > +       int remaining = tst_timeout_remaining();
> > +       int elapsed = 0;
> > +
> > +       while (tst_timeout_remaining() > STOP_THRESHOLD) {
> > +               int fd = mkfile(file_size);
> 
> What about moving mkfile(file_size) out of this while loop, because it
> will do initialized work over and over again then slow down the test.

But it would also make it cached the entire time. I'd rather keep it,
it's only 1kB file.

> 
> > +
> > +               tst_atomic_store(0, &mapcnt);
> > +               tst_atomic_store(0, &unmapcnt);
> > +
> > +               chld_args[0] = fd;
> > +               SAFE_PTHREAD_CREATE(&thid[0], NULL, map_write_unmap,
> > chld_args);
> > +               SAFE_PTHREAD_CREATE(&thid[1], NULL, read_mem, chld_args);
> > +               threads_spawned += 2;
> > +
> > +               SAFE_PTHREAD_JOIN(thid[0], NULL);
> > +               SAFE_PTHREAD_JOIN(thid[1], NULL);
> > +
> > +               close(fd);
> > +
> > +               if (remaining - tst_timeout_remaining() > PROGRESS_SEC) {
> > +                       remaining = tst_timeout_remaining();
> > +                       elapsed += PROGRESS_SEC;
> > +                       tst_res(TINFO, "[%d] mapped: %lu, sigsegv hit: %lu,
> > "
> > +                               "threads spawned: %lu, data matched: %lu",
> > +                               elapsed, map_count, mapped_sigsegv_count,
> > +                               threads_spawned, data_matched);
> > +               }
> > +       }
> > +       tst_res(TPASS, "System survived.");
> > +}
> > +
> > +static struct tst_test test = {
> > +       .test_all = run,
> > +       .setup = setup,
> > +       .options = options,
> > +       .needs_tmpdir = 1,
> > +};
> > --
> > 1.8.3.1
> >
> >
> > --
> > Mailing list info: https://lists.linux.it/listinfo/ltp
> 
> 
> 
> --
> Regards,
> Li Wang
> 
