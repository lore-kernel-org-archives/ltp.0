From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 21 Nov 2019 15:45:54 +0800
Subject: [LTP] [PATCH v4 1/5] syscalls/quotactl01: Add Q_GETNEXTQUOTA
 test
In-Reply-To: <20191121054507.GB59487@x230>
References: <1574241216-15168-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1574241216-15168-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20191120151244.GA28197@dell5510>
 <d1d72a63-fd3b-e670-4559-c0216176546c@cn.fujitsu.com>
 <20191121054507.GB59487@x230>
Message-ID: <d346af6e-c037-7ac7-748a-a53c9b12046b@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


on 2019/11/21 13:45, Petr Vorel wrote:

> Based on Jan's comment [1], maybe he meant it specifically for __kernel_fsid_t in
> fanotify.h, not as a general approach. __kernel_fsid_t is more complicated than
> uint64_t. That's why I'm asking whether there is a general approach we want to
> take.

Hi Petr

I see. Now, I think we should avoid to use <linux/types.h>?? because on musl? libc doesn't have it.

Also ,If we use uint64_t, they still failed on 2.6.32-754.el6.x86_64 with undefined  . Or, we should use TST_ABI to define uint64_t them

on myself.

Thanks
Yang Xu



-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20191121/90916f80/attachment-0001.htm>
