From: Li Wang <liwang@redhat.com>
Date: Fri, 26 Mar 2021 17:01:38 +0800
Subject: [LTP] [PATCH 0/4] Convert swapon/swapon0{1..3} to the new API
In-Reply-To: <20210325181906.40688-1-qi.fuli@fujitsu.com>
References: <20210325181906.40688-1-qi.fuli@fujitsu.com>
Message-ID: <CAEemH2fFciCEAdVFETCEuoWegiVrYL6pp9Vv_t3atXivPzhEDg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Fuli,


On Fri, Mar 26, 2021 at 2:20 AM QI Fuli <fukuri.sai@gmail.com> wrote:

> From: QI Fuli <qi.fuli@fujitsu.com>
>
> Convert syscalls/swapon/swapon0{1..3} to the new API
>
> QI Fuli (4):
>   libs/libltpswap: Rename and Convert libs/libltpswapon to the new API
>

I appreciate your help to convert the libltpswapon to the new API, but at
the first sight of your patchset, I was quite curious why not complete the
leftover two test swapoff/ to new then we can remove the old API totally.

So in other words, it probably makes people confusing that there exist
libltpswap/ and libltpswapon/ at the same time.

Could you help finish the rest work? :)



>   syscalls/swapon/swapon01: Convert swapon01 to the new API
>   syscalls/swapon/swapon02: Convert swapon02 to the new API
>   syscalls/swapon/swapon03: Convert swapon03 to the new API
>
>  include/libswap.h                           |  24 +++
>  libs/libltpswap/Makefile                    |  12 ++
>  libs/libltpswap/libswap.c                   |  63 ++++++
>  testcases/kernel/syscalls/swapon/Makefile   |   4 +-
>  testcases/kernel/syscalls/swapon/swapon01.c |  83 ++-----
>  testcases/kernel/syscalls/swapon/swapon02.c | 145 +++++--------
>  testcases/kernel/syscalls/swapon/swapon03.c | 227 ++++++++------------
>  7 files changed, 258 insertions(+), 300 deletions(-)
>  create mode 100644 include/libswap.h
>  create mode 100644 libs/libltpswap/Makefile
>  create mode 100644 libs/libltpswap/libswap.c
>
> --
> 2.30.2
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>
>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210326/1e8eda26/attachment.htm>
