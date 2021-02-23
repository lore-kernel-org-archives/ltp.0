From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Tue, 23 Feb 2021 09:45:23 +0800
Subject: [LTP] [PATCH v3 3/4] syscalls/mallinfo02: Add a basic test to
 check use mmap or sbrk
In-Reply-To: <CAEemH2crZjLK1MtzkEYyxCU0-Pbqp8G5MR4CU7UEG4VQr-ksVQ@mail.gmail.com>
References: <YCFZB1/VMSsfxyPA@yuki.lan>
 <1613627572-5213-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1613627572-5213-3-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <CAEemH2crZjLK1MtzkEYyxCU0-Pbqp8G5MR4CU7UEG4VQr-ksVQ@mail.gmail.com>
Message-ID: <60345E33.7090007@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li
> Hi Xu,
>
> For patch 1/4 ~ 3/4, looks good to me.
> Reviewed-by: Li Wang <liwang@redhat.com <mailto:liwang@redhat.com>>
Thanks for you review. I have merged this patchset and drop the last one.
>
> For 4/4, I slightly think it does not make much sense to test, because
> it just verifies the info.hblkhd integer overflow at unsuggested usage.
> Anyway, that's only my thoughts, maybe a one-sided view:).
>
> --
> Regards,
> Li Wang



