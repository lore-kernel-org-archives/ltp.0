From: Li Wang <liwang@redhat.com>
Date: Mon, 29 Mar 2021 10:09:47 +0800
Subject: [LTP] [PATCH] syscalls/shmctl: Using TERRNO to macth errno
In-Reply-To: <F3D3F6AC3820BB4C9FCA340DB5C32CB40389DCB7@dggeml531-mbx.china.huawei.com>
References: <F3D3F6AC3820BB4C9FCA340DB5C32CB40389DCB7@dggeml531-mbx.china.huawei.com>
Message-ID: <CAEemH2foLxSYEGrmLOeXJAKWx7cBHEEkD9BrUFXKAyoCpE6rug@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Mar 29, 2021 at 9:56 AM zhaogongyi <zhaogongyi@huawei.com> wrote:

> Hi Li,
>
>
>
> Actually, I have no effective tools to find out all of this type problems.
>
>

Indeed, the wrong usage of TTERRNO you find mostly occurred in bad code
logic.
That's hard to correct them in an automatic way.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210329/b41fbf6c/attachment.htm>
