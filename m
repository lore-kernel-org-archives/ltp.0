From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 4 Feb 2021 18:01:02 +0800
Subject: [LTP] [PATCH v1 3/3] syscalls/mallinfo03: Add an overflow test
 when setting 2G size
In-Reply-To: <CAEemH2eiTY7YgSYLr6_skK6PaRZb2_GchbmHUJKVuW7btA15rQ@mail.gmail.com>
References: <1611654925-8994-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1611654925-8994-3-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <CAEemH2eiTY7YgSYLr6_skK6PaRZb2_GchbmHUJKVuW7btA15rQ@mail.gmail.com>
Message-ID: <601BC5DE.506@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li
> Hi Xu,
>
>     +void test_mallinfo(void)
>     +{
>     + struct mallinfo info;
>     + char *buf;
>     + size_t size = 2UL * 1024UL * 1024UL * 1024UL;
>     +
>     + buf = SAFE_MALLOC(size);
>     + info = mallinfo();
>     + if (info.hblkhd < 0) {
>     + print_mallinfo("Test malloc 2G", &info);
>     + tst_res(TFAIL, "The member of struct mallinfo overflow, we should
>     use mallinfo2");
>
> TPASS?
>
>     + } else {
>     + /*We will never get here*/
>     + tst_res(TPASS, "The member of struct mallinfo doesn't overflow");
>
>
> TFAIL?
>
>     + }
>     + free(buf);
>     +}

It is a "always" fail test.  We should use mallinfo2 in the future. I 
guess failure may attract user's attention than pass.

>
>
>
> --
> Regards,
> Li Wang



