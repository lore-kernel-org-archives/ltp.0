From: Li Wang <liwang@redhat.com>
Date: Thu, 4 Feb 2021 19:02:11 +0800
Subject: [LTP] [PATCH] bugfix for lib/tst_capability.c
 sched_setaffinity/sched_setaffinity01.c timerfd/timerfd04.c
In-Reply-To: <20210204092114.8726-1-zhaogongyi@huawei.com>
References: <20210204092114.8726-1-zhaogongyi@huawei.com>
Message-ID: <CAEemH2f_EXhBKDCgBVNh6qnEmcagyrOXMZAWLtazmba4ZPg7xw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Gongyi,

On Thu, Feb 4, 2021 at 5:22 PM zhao gongyi <zhaogongyi@huawei.com> wrote:

> Use TERRNO because we're not using the TEST() macro.
>

I rewrote the subject and applied it. Thanks!

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210204/aaf317d6/attachment.htm>
