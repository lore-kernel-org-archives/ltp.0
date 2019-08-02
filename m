From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 2 Aug 2019 10:46:05 +0800
Subject: [LTP] [PATCH] syscalls/copy_file_range02: correct wrong
 loop_devn judgment
In-Reply-To: <1564712813-2291-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1564712813-2291-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <5D43A3ED.7010504@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2019/08/02 10:26, Yang Xu wrote:
> We should open dev_path when loop_devn is not equal to -1.
> Since Amir has pointed this obvious error on v6, I forgot it.
> Sorry for everyone.
Hi Xu,

Pushed, thanks.

Best Regards,
Xiao Yang


