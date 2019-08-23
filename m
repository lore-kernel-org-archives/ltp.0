From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Fri, 23 Aug 2019 15:13:47 +0800
Subject: [LTP] [PATCH] syscalls/copy_file_range02: use .needs_tmpdir and
 MAX_LEN
In-Reply-To: <CAEemH2fT1_ATcKB5bD9OvsnJP1vsRbib_MGyB1Bk_U=Ccd1VVg@mail.gmail.com>
References: <1566541374-2225-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <CAEemH2fT1_ATcKB5bD9OvsnJP1vsRbib_MGyB1Bk_U=Ccd1VVg@mail.gmail.com>
Message-ID: <5D5F922B.1050506@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2019/08/23 14:55, Li Wang wrote:
> Hi Xu,
>
> Seems you have to apply Petr's patch first, then do a new
> modification. Because that patch fixes another compiling issue.
>
> [1] http://lists.linux.it/pipermail/ltp/2019-August/013239.html
Hi Li


Petr' patch looks ok but I don't know why it isn't merged on master branch.

I am not sure Petr's patch whether having the next version, so I don't rebase it.

IMO, merge Petr's patch then I rebase it. Or Merge my patch then Petr rebases it.
It depends on ltp community.


Thanks
Yang Xu

> --
> Regards,
> Li Wang
>
>
>



