From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Mon, 22 Feb 2021 14:40:39 +0800
Subject: [LTP] [PATCH v3 3/4] syscalls/mallinfo02: Add a basic test to
 check use mmap or sbrk
In-Reply-To: <CAEemH2crZjLK1MtzkEYyxCU0-Pbqp8G5MR4CU7UEG4VQr-ksVQ@mail.gmail.com>
References: <YCFZB1/VMSsfxyPA@yuki.lan>
 <1613627572-5213-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1613627572-5213-3-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <CAEemH2crZjLK1MtzkEYyxCU0-Pbqp8G5MR4CU7UEG4VQr-ksVQ@mail.gmail.com>
Message-ID: <603351E7.4060008@cn.fujitsu.com>
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
>
> For 4/4, I slightly think it does not make much sense to test, because
> it just verifies the info.hblkhd integer overflow at unsuggested usage.
> Anyway, that's only my thoughts, maybe a one-sided view:).
I guess we can just add a valid test for mallinfo2 to test it still can 
get the correct info when setting 2G size instead of this case.

ps: I need to find a new enough system to have supported mallinfo2.

Best Regards
Yang Xu
>
> --
> Regards,
> Li Wang



