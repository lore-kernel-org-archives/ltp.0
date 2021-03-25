From: Li Wang <liwang@redhat.com>
Date: Thu, 25 Mar 2021 17:29:25 +0800
Subject: [LTP] [PATCH] syscalls/capset: modify incorrect use of TTERRNO
 for capset/capset01.c
In-Reply-To: <20210325090118.143355-1-xieziyao@huawei.com>
References: <20210325090118.143355-1-xieziyao@huawei.com>
Message-ID: <CAEemH2fEVw0uo=GqQPuqEcG=WMU8=h3hknKMrW7G8ushPeKPDw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Mar 25, 2021 at 5:01 PM Xie Ziyao <xieziyao@huawei.com> wrote:

> Use TEST() to check the return value of the tst_syscall.
>
> Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
>

Pushed, thanks for the fix!

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210325/f7493912/attachment.htm>
