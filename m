From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 29 Jul 2020 15:51:34 +0800
Subject: [LTP] [PATCH v1 2/2] libs/libltpnewipc: Add libmsgctl.c into
 new ipc library
In-Reply-To: <CAEemH2eFrsa0rNfjcKrdQpUkV6YvbQR10tbzy4F5jXVQOrra7w@mail.gmail.com>
References: <1595911224-12470-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1595911224-12470-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <CAEemH2eFrsa0rNfjcKrdQpUkV6YvbQR10tbzy4F5jXVQOrra7w@mail.gmail.com>
Message-ID: <9916b020-27b6-bc12-919b-9046dc7dcee5@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li


> Hi Xu,
> 
> On Tue, Jul 28, 2020 at 12:40 PM Yang Xu <xuyang2018.jy@cn.fujitsu.com 
> <mailto:xuyang2018.jy@cn.fujitsu.com>> wrote:
> 
>     Add libmsgctl.c into new ipc library, so we can use it
>     in new api msgstress test case.
> 
> 
> It's fine to maintain only a single System V IPC library in LTP.
> BTW, do you have a plan to remove the old libmsgctl.c after merging this?
Yes. I have a plan[1] to  remove this old libmsgctl when I clean up 
msgstress case(I am doing it).
Also, I plan to remove get_max_msgqueues()  function in old libipc.c 
because we can directly use SAFE_FILE_SCANF("/proc/sys/kernel/msgmni", 
"%d", &nr_msgqs) in test case.

[1]https://patchwork.ozlabs.org/project/ltp/patch/20200618094139.24579-1-xuyang_jy_0410@163.com/

Best Regards
Yang Xu
> Series:
> Reviewed-by: Li Wang <liwang@redhat.com <mailto:liwang@redhat.com>>
> 
> -- 
> Regards,
> Li Wang


