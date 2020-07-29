From: Li Wang <liwang@redhat.com>
Date: Wed, 29 Jul 2020 15:37:32 +0800
Subject: [LTP] [PATCH v1 2/2] libs/libltpnewipc: Add libmsgctl.c into
 new ipc library
In-Reply-To: <1595911224-12470-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1595911224-12470-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1595911224-12470-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <CAEemH2eFrsa0rNfjcKrdQpUkV6YvbQR10tbzy4F5jXVQOrra7w@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xu,

On Tue, Jul 28, 2020 at 12:40 PM Yang Xu <xuyang2018.jy@cn.fujitsu.com>
wrote:

> Add libmsgctl.c into new ipc library, so we can use it
> in new api msgstress test case.
>

It's fine to maintain only a single System V IPC library in LTP.
BTW, do you have a plan to remove the old libmsgctl.c after merging this?
Series:
Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200729/41bb5323/attachment.htm>
