From: xieziyao <xieziyao@huawei.com>
Date: Sat, 27 Mar 2021 01:31:46 +0000
Subject: [LTP] =?utf-8?b?562U5aSNOiAgW1BBVENIXSBzeXNjYWxscy9jbG9ja19hZGp0?=
 =?utf-8?q?ime=3A_fix_some_mistakes_for_commit_135affca95dca84bc9ce6b1e223?=
 =?utf-8?q?8e6db6e6b0f56?=
In-Reply-To: <CAEemH2ck0c+UAzw7-midEc0q=GS9EsBYSOo48Lwd_MF5tuJpeg@mail.gmail.com>
References: <20210326080530.11211-1-xieziyao@huawei.com>
 <CAEemH2ck0c+UAzw7-midEc0q=GS9EsBYSOo48Lwd_MF5tuJpeg@mail.gmail.com>
Message-ID: <13c58a4bb8ac48d3a00906aed3b0446e@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

I'll pay attention to this next time, thanks a lot. :)


--
Regards,
Xie Ziyao

???: Li Wang [mailto:liwang@redhat.com]
????: 2021?3?26? 17:43
???: xieziyao <xieziyao@huawei.com>
??: LTP List <ltp@lists.linux.it>
??: Re: [LTP] [PATCH] syscalls/clock_adjtime: fix some mistakes for commit 135affca95dca84bc9ce6b1e2238e6db6e6b0f56

Hi Ziyao,

On Fri, Mar 26, 2021 at 4:06 PM Xie Ziyao <xieziyao@huawei.com<mailto:xieziyao@huawei.com>> wrote:
- change TTERRNO to TERRNO after the safe_macros interface is not used;
- delete the unnecessary tst_res(TFAIL | TTERRNO, ...), which has been
  determined in the previous logic.

Signed-off-by: Xie Ziyao <xieziyao@huawei.com<mailto:xieziyao@huawei.com>>

As a convention, we add "Fixes: xxxxxxxxxx" here to track the commit id.

Anyway, I help to modified some format issues and pushed it, thanks!


--
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210327/3bc2c33a/attachment.htm>
