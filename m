From: Li Wang <liwang@redhat.com>
Date: Tue, 25 May 2021 21:18:22 +0800
Subject: [LTP] [PATCH] syscalls/statx04: use stx_attributes_mask before
 test
In-Reply-To: <1571975625-6322-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <20190911124714.GA21670@rei.lan>
 <1571975625-6322-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <CAEemH2dxhzBk+fbR8YnxAKqQSYhsb=HW2B2rov18yOjk9a+5Uw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi all,

Yang Xu <xuyang2018.jy@cn.fujitsu.com> wrote:

>
> stx_attributes_mask shows what's supported in stx_attributes.
> Set supp_{append,compr,immutable,nodump} attributes only on filesystems
> which actually support it.
>
> Also merge duplicate code.
>
> ---------------
> v2->v3:
> 1.add kernel version check for stx_attributes_mask
> 2. use test_flag(int) instead of test_flagged and test_unflagged
> ---------------
>
> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>

Reviewed-by: Li Wang <liwang@redhat.com>

This patch makes sense to me, I'm not sure if any blocker issue for
holding the apply process. If _no_ I would help to merge it:).

-- 
Regards,
Li Wang

