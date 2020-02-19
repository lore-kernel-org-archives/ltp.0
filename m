From: Li Wang <liwang@redhat.com>
Date: Wed, 19 Feb 2020 11:57:30 +0800
Subject: [LTP] [PATCH] cleanup: avoid to generate many redundant obj
 files
In-Reply-To: <a3d98743-8c77-3282-97dd-a2864886e8c6@163.com>
References: <20200218115918.32203-1-liwang@redhat.com>
 <a3d98743-8c77-3282-97dd-a2864886e8c6@163.com>
Message-ID: <CAEemH2cg=r3tjefzm=dSj0FZca-gMorGue3C0uGugpniSnZjBA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Yang,

On Tue, Feb 18, 2020 at 10:21 PM Yang Xu <xuyang_jy_0410@163.com> wrote:

> Hi Li
>
> This patch looks good to me, feel free to add
> Reviewed-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com> <xuyang2018.jy@cn.fujitsu.com>
>
> Also, I think we can replace GPL with SPDX-License-Identifier in these makefiles
>
> Yes, I have fixed that as you suggest and pushed. Thanks!


> (Also for
> all ltp makefiles, we have converted SPDX-License-Identifier in few header since commit b288957a88b1 ).
>
> Good point, but I haven't found a way to do the replacement for whole
files.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200219/556d1f05/attachment.htm>
