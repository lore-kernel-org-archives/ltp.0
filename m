From: Li Wang <liwang@redhat.com>
Date: Thu, 26 Mar 2020 13:42:14 +0800
Subject: [LTP] [PATCH] runtest/syscalls: add sendmsg03
In-Reply-To: <1585192647-16105-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1585192647-16105-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20200326054214.GA26570@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Mar 26, 2020 at 11:17:27AM +0800, Yang Xu wrote:
> Also, fix a possible warning in cleanup when SAFE_UNSHARE(CLONE_NEWUSER)
> failed on 3.10.0-1049.el7.x86_64. as below:
> 
> sendmsg03.c:43: CONF: unshare(268435456) unsupported: EINVAL (22)
> safe_macros.c:67: WARN: sendmsg03.c:65: close(-1) failed: EBADF (9)
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>

Pushed.

