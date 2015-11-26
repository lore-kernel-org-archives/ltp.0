From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 26 Nov 2015 21:05:09 +0300
Subject: [LTP] [PATCH v2] hugetlb/hugemmap: add new testcase hugemmap06.c
In-Reply-To: <CAEemH2fxCDRtB7jSazdBjAMzxaK0U2GwNZKLuAq00EDzbW679A@mail.gmail.com>
References: <1448506977-12479-1-git-send-email-liwang@redhat.com>
 <5656CF53.3030409@oracle.com>
 <CAEemH2fxCDRtB7jSazdBjAMzxaK0U2GwNZKLuAq00EDzbW679A@mail.gmail.com>
Message-ID: <565749D5.4060306@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
On 11/26/2015 03:25 PM, Li Wang wrote:
>
>
>
>         +               tst_brkm(TBROK | TERRNO, cleanup, "Cannot
>         allocate hugepage");
>         +       }
>         +
>         +       for (i = ARSZ - 1; i > 0; i--) {
>
>
>     Why this is done in reverse order?
>
>
> well, as Jan pointed in the previous comments:
>
> "How about allocating the largest area first and then mmaping smaller ones
> on top of it?
>
> That could prevent situation where first smallest area mmaps a gap between
> existing libraries/heap/etc. and then larger ones with same start overlap
> with those - since we write to those areas, bad things could happen."
>
> I think that is very clear to describe the potential issue. since I 
> run the program on some s390x for many times, it is easily to get 
> segment fault. after done in reverse order. the error gone.
>
> here I print the detailed mapings of the program, it show something that.
> -----

OK, but I meant that either we need to remove "sz" variable and use "i * 
hpage_size" or
make it straightforward as "i" doesn't influence on the actual size 
passed to mmap and threads.

So that both of the loops looks the same.

Also to use the full range of declared arrays, we should do as follows 
or declare them as ARSZ - 1:

struct mp mmap_sz[ARSZ];
pthread_t tid[ARSZ];

sz = ARSZ + 1;

...

for (i = 0; i < ARSZ; ++i, --sz) {
     mmap_sz[i].sz = sz;
     mmap_sz[i].addr = addr;
     ...
}

for (i = 0; i < ARSZ; ++i) {
     pthread_join(...);
}

> Program received signal SIGSEGV, Segmentation fault.
> 0x0000004cf80a68b0 in mmap64 () from /lib64/libc.so.6
> (gdb) bt
> #0  0x0000004cf80a68b0 in mmap64 () from /lib64/libc.so.6
> Cannot access memory at address 0x70
>
>
>           Start Addr           End Addr       Size Offset objfile
>           0x80000000         0x80001000 0x1000          
> 0                              /root/a.out
>           0x80001000         0x80002000     0x1000 
> 0x1000                              /root/a.out
>           0xb7a9b000         0xb7abc000 0x21000          0 [heap]
>         0x4cf7f73000       0x4cf7f94000 0x21000          
> 0                         /lib64/ld-2.12.so <http://ld-2.12.so>
>         0x4cf7f94000       0x4cf7f95000     0x1000 
> 0x20000                         /lib64/ld-2.12.so <http://ld-2.12.so>
>         0x4cf7f95000       0x4cf7f96000     0x1000 
> 0x21000                         /lib64/ld-2.12.so <http://ld-2.12.so>
>         0x4cf7f96000       0x4cf7f97000 0x1000          0
>         0x4cf7f9d000       0x4cf814d000 0x1b0000          
> 0                         /lib64/libc-2.12.so <http://libc-2.12.so>
>         0x4cf814d000       0x4cf8151000     0x4000 
> 0x1af000                         /lib64/libc-2.12.so <http://libc-2.12.so>
>         0x4cf8151000       0x4cf8152000     0x1000 
> 0x1b3000                         /lib64/libc-2.12.so <http://libc-2.12.so>
>         0x4cf8152000       0x4cf8157000 0x5000          0
>         0x4cf8159000       0x4cf8176000 0x1d000          
> 0                         /lib64/libpthread-2.12.so 
> <http://libpthread-2.12.so>
>         0x4cf8176000       0x4cf8177000     0x1000 
> 0x1c000                         /lib64/libpthread-2.12.so 
> <http://libpthread-2.12.so>
>         0x4cf8177000       0x4cf8178000     0x1000 
> 0x1d000                         /lib64/libpthread-2.12.so 
> <http://libpthread-2.12.so>
>
>
>         +               mmap_sz[i].sz = sz;
>         +               mmap_sz[i].addr = addr;
>         +
>         +               TEST(pthread_create(tid + i, NULL, thr,
>         &mmap_sz[i]));
>
>
>     This is not right, use tid[i] ( = tid + sizeof(pthread_t) * i),
>     not tid + i.
>
>
> sorry, probably you want say this:
>
>         (pthread_t *)((char *)tid + sizeof(pthread_t) * i)
>
> but I think the original way is right.

Yes, you are right, sorry for misleading you.

I would recommend to use the same style in one function, so

TEST(pthread_create(tid + i, NULL, thr, mmap_sz + i));
or
TEST(pthread_create(&tid[i], NULL, thr, &mmap_sz[i]));


> -----------
> # cat a.c
> #include <stdio.h>
> int main()
> {
>     int a[2];
>
>     *a = 'a';
>     *(a + 1) = 'b';
>
>     printf("a[1] = %d\n", a[1]);
>
>     printf("&a[0] = %p\n", a);
>     printf("&a[1] = %p\n", a + 1);
> }
>
> --------
> # ./a.out
> a[1] = 98
> &a[0] = 0x3ffffe25f18
> &a[1] = 0x3ffffe25f1c
>
>
>
>         +       }
>         +
>         +       for (++i; i < ARSZ; i++) {
>
>
>     Could you initialize "i" here explicitly?
>
> ok, no problem.
>
>
>         +       cleanup();
>         +       tst_exit();
>
>
>     Isn't tst_exit() calling cleanup?
>
>
> hmm, I checked the /lib/tst_res.c and got the function:
>
> ----
> void tst_exit(void)
> {
>     pthread_mutex_lock(&tmutex);
>
> #if DEBUG
>     printf("IN tst_exit\n");
>     fflush(stdout);
>     fflush(stdout);
> #endif
>
>     /* Call tst_flush() flush any output in the buffer. */
>     tst_flush();
>
>     /* Mask out TINFO result from the exit status. */
>     exit(T_exitval & ~TINFO);
> }
>
> I didn't saw there anyplace call the cleanup() function. :(

Right, I've read the mail thread recently about changing cleanup() to be 
declared as a signal handler before
and somehow thought it is already implemented in LTP...

Thanks,
Alexey

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20151126/81321814/attachment-0001.html>
