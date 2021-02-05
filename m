From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Fri, 5 Feb 2021 16:15:13 +0800
Subject: [LTP] [PATCH v2 4/5] syscalls/mallinfo02: Add a basic test to
 check use mmap or sbrk
In-Reply-To: <CAEemH2ehgnR0Ad5VzR63KgtjFBoqH5N_1b13T7f5Gw6n3EkzdA@mail.gmail.com>
References: <CAEemH2eiTY7YgSYLr6_skK6PaRZb2_GchbmHUJKVuW7btA15rQ@mail.gmail.com>
 <1612440762-22389-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1612440762-22389-4-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <CAEemH2ehgnR0Ad5VzR63KgtjFBoqH5N_1b13T7f5Gw6n3EkzdA@mail.gmail.com>
Message-ID: <601CFE91.2030909@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li

I have reply this email, but I don't see it on inbox or patchwork, so again
>     +
>     +#ifdef HAVE_MALLINFO
>     +void test_mallopt(void)
>
>
> what about renaming to test_mallinfo(void) ?
Yes, sorry for this typo.
>
>     +{
>     + struct mallinfo info;
>     + int size;
>     + char *buf;
>     +
>     + buf = SAFE_MALLOC(20480);
>     +
>     + info = mallinfo();
>     + if (info.uordblks > 20480 && info.hblkhd == 0) {
>     + tst_res(TPASS, "malloc() uses sbrk when size < 128k");
>     + } else {
>     + tst_res(TFAIL, "malloc() use mmap when size < 128k");
>     + tst_print_mallinfo("Test malloc(20480)", &info);
>     + }
>     + free(buf);
>     +
>     + info = mallinfo();
>     + size = MAX(info.fordblks, 131072);
>     +
>     + buf = SAFE_MALLOC(size);
>     + info = mallinfo();
>     + if (info.hblkhd > size && info.hblks > 0) {
>     + tst_res(TPASS, "malloc() uses mmap when size >= 128k");
>     + } else {
>     + tst_res(TFAIL, "malloc uses sbrk when size >= 128k");
>
>
> Why not 'TFAIL | TERRNO' ?
mallinfo should always succeed.
>
>     + tst_print_mallinfo("Test malloc(1024*128)", &info);
>     + }
>     +
>     + free(buf);
>     +}
>     +
>     +static void setup(void)
>     +{
>     + if (mallopt(M_MMAP_THRESHOLD, 131072) == 0)
>     + tst_res(TFAIL, "mallopt(M_MMAP_THRESHOLD, 128K) failed");
>
>
> Here as well.
mallopt man-pages said even mallopt fails, return 0 and it doesn't set 
errno.
>
>     +}
>     +
>     +static struct tst_test test = {
>     + .setup = setup,
>     + .test_all = test_mallopt,
>     +};
>     +
>     +#else
>     +TST_TEST_TCONF("system doesn't implement non-POSIX mallinfo()");
>     +#endif
>     --
>     2.23.0
>
>
>
>
>
> --
> Regards,
> Li Wang



