From: Li Wang <liwang@redhat.com>
Date: Mon, 29 Mar 2021 09:49:58 +0800
Subject: [LTP] [PATCH] syscalls/shmctl: Using TERRNO to macth errno
In-Reply-To: <20210327102344.1620-1-zhaogongyi@huawei.com>
References: <20210327102344.1620-1-zhaogongyi@huawei.com>
Message-ID: <CAEemH2dDzuXU=YPGVPM8cAuwq5VEHMDtdPimksRsv1AMmE7L_A@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Gongyi,

On Sat, Mar 27, 2021 at 6:24 PM Zhao Gongyi <zhaogongyi@huawei.com> wrote:

> When "shmid == -1", we need print the errno with TERRNO. It must have no
> error in
> TEST, otherwise it has return early.
>

Right, but it is mostly caused by copy&past.

And, I guess you are working on fix the TERRNO/TTERRNO issues currently,
so it would be great to combine them together in one patch, other than
sending
it one by one separately.

Anyway, I help push this. Thanks!

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210329/5328249d/attachment.htm>
