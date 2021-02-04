From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 4 Feb 2021 17:54:15 +0800
Subject: [LTP] [PATCH v1 1/3] syscalls/mallinfo01: Add a basic test for
 mallinfo
In-Reply-To: <CAEemH2f++GH=b29S_Y3CV8MPtunFnZdz=fTEWoXpKe0sACXXYA@mail.gmail.com>
References: <1611654925-8994-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <CAEemH2f++GH=b29S_Y3CV8MPtunFnZdz=fTEWoXpKe0sACXXYA@mail.gmail.com>
Message-ID: <601BC447.1090008@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li
> Hi Xu,
>
>     +static void
>     +print_mallinfo(const char *msg, struct mallinfo *m)
>
>
> What about moving this print_mallinfo() into a mallinfo_common.h file
> to avoid the duplicated code in each test?
Good suggestion. Will do it.
>
> --
> Regards,
> Li Wang



