From: Li Wang <liwang@redhat.com>
Date: Thu, 4 Feb 2021 16:54:53 +0800
Subject: [LTP] [PATCH v1 3/3] syscalls/mallinfo03: Add an overflow test
 when setting 2G size
In-Reply-To: <1611654925-8994-3-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1611654925-8994-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1611654925-8994-3-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <CAEemH2eiTY7YgSYLr6_skK6PaRZb2_GchbmHUJKVuW7btA15rQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xu,


> +void test_mallinfo(void)
> +{
> +       struct mallinfo info;
> +       char *buf;
> +       size_t size = 2UL * 1024UL * 1024UL * 1024UL;
> +
> +       buf = SAFE_MALLOC(size);
> +       info = mallinfo();
> +       if (info.hblkhd < 0) {
> +               print_mallinfo("Test malloc 2G", &info);
> +               tst_res(TFAIL, "The member of struct mallinfo overflow, we
> should use mallinfo2");
>

TPASS?


> +       } else {
> +               /*We will never get here*/
> +               tst_res(TPASS, "The member of struct mallinfo doesn't
> overflow");
>

TFAIL?



> +       }
> +       free(buf);
> +}
>


-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210204/101b8c8d/attachment.htm>
