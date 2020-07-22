From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 22 Jul 2020 17:01:24 +0200
Subject: [LTP] [PATCH v2 1/2] libs/libltpnewipc: Add libnewmsgctl.c
In-Reply-To: <20200618094139.24579-1-xuyang_jy_0410@163.com>
References: <20200618094139.24579-1-xuyang_jy_0410@163.com>
Message-ID: <20200722150124.GA2714@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Add libnewmsgctl.c into ltp new ipc libs, so the upcoming msgstress cleanup cases
> can use doreader/dowirter functions such as old libmsgctl.c does.
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> ---
>  include/libnewmsgctl.h           |  22 +++++++
>  libs/libltpnewipc/libnewmsgctl.c | 102 +++++++++++++++++++++++++++++++
>  2 files changed, 124 insertions(+)
>  create mode 100644 include/libnewmsgctl.h
>  create mode 100644 libs/libltpnewipc/libnewmsgctl.c

As far as I can tell this is only used in msgstress testcases right?

So unless we plan to use it from different tests it does not make much
sense to export it to the top level include and libs.

Or alternatively we do have libltpnewipc we can pust put the
libnewmsgctl.c to that directory and with that we will have a single
System V IPC helper library.

-- 
Cyril Hrubis
chrubis@suse.cz
