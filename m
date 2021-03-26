From: Li Wang <liwang@redhat.com>
Date: Fri, 26 Mar 2021 17:43:01 +0800
Subject: [LTP] [PATCH] syscalls/clock_adjtime: fix some mistakes for
 commit 135affca95dca84bc9ce6b1e2238e6db6e6b0f56
In-Reply-To: <20210326080530.11211-1-xieziyao@huawei.com>
References: <20210326080530.11211-1-xieziyao@huawei.com>
Message-ID: <CAEemH2ck0c+UAzw7-midEc0q=GS9EsBYSOo48Lwd_MF5tuJpeg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Ziyao,

On Fri, Mar 26, 2021 at 4:06 PM Xie Ziyao <xieziyao@huawei.com> wrote:

> - change TTERRNO to TERRNO after the safe_macros interface is not used;
> - delete the unnecessary tst_res(TFAIL | TTERRNO, ...), which has been
>   determined in the previous logic.
>
> Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
>

As a convention, we add "Fixes: xxxxxxxxxx" here to track the commit id.

Anyway, I help to modified some format issues and pushed it, thanks!


-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210326/3d7388e1/attachment.htm>
