From: Li Wang <liwang@redhat.com>
Date: Wed, 29 Jul 2020 16:16:38 +0800
Subject: [LTP] [PATCH v1 2/2] libs/libltpnewipc: Add libmsgctl.c into
 new ipc library
In-Reply-To: <9916b020-27b6-bc12-919b-9046dc7dcee5@cn.fujitsu.com>
References: <1595911224-12470-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1595911224-12470-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <CAEemH2eFrsa0rNfjcKrdQpUkV6YvbQR10tbzy4F5jXVQOrra7w@mail.gmail.com>
 <9916b020-27b6-bc12-919b-9046dc7dcee5@cn.fujitsu.com>
Message-ID: <CAEemH2ckxPDkncT9m2nyv0-tvJ70SKogun7EfzAN912sc5662A@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Yang Xu <xuyang2018.jy@cn.fujitsu.com> wrote:

> ...
> > It's fine to maintain only a single System V IPC library in LTP.
> > BTW, do you have a plan to remove the old libmsgctl.c after merging this?
> Yes. I have a plan[1] to  remove this old libmsgctl when I clean up
> msgstress case(I am doing it).
>

Great, thank you!


> Also, I plan to remove get_max_msgqueues()  function in old libipc.c
> because we can directly use SAFE_FILE_SCANF("/proc/sys/kernel/msgmni",
> "%d", &nr_msgqs) in test case.
>

+1

Or, maybe if you'd like to do more in next, the libipc.c also could be
merged into libnewipc.c since they have some overlaps too. Anyway, it
depends on your thoughts :).

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200729/8710f6e6/attachment.htm>
