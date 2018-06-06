From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 6 Jun 2018 15:48:13 +0200
Subject: [LTP] [PATCH 3/3] syscalls/fchmod02.c: Cleanup && convert to
 new API
In-Reply-To: <1522407404-6877-3-git-send-email-huangjh.jy@cn.fujitsu.com>
References: <1522407404-6877-1-git-send-email-huangjh.jy@cn.fujitsu.com>
 <1522407404-6877-3-git-send-email-huangjh.jy@cn.fujitsu.com>
Message-ID: <20180606134813.zv4a7y46strvec6i@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jinhui,

> Signed-off-by: Jinhui Huang <huangjh.jy@cn.fujitsu.com>
Acked-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/kernel/syscalls/fchmod/fchmod02.c | 227 +++++++---------------------
>  1 file changed, 53 insertions(+), 174 deletions(-)

>  #include <sys/types.h>
>  #include <sys/stat.h>
..
> +#include <unistd.h>
These 3 headers aren't needed. I'll change it before commit.


Kind regards,
Petr
