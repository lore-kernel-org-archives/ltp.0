From: Li Wang <liwang@redhat.com>
Date: Thu, 4 Feb 2021 14:42:09 +0800
Subject: [LTP] [PATCH v1 1/3] syscalls/mallinfo01: Add a basic test for
 mallinfo
In-Reply-To: <1611654925-8994-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1611654925-8994-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <CAEemH2f++GH=b29S_Y3CV8MPtunFnZdz=fTEWoXpKe0sACXXYA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xu,


> +static void
> +print_mallinfo(const char *msg, struct mallinfo *m)
>

What about moving this print_mallinfo() into a mallinfo_common.h file
to avoid the duplicated code in each test?

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210204/04b5897c/attachment.htm>
