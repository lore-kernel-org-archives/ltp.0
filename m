From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 12 Feb 2020 08:37:52 -0500 (EST)
Subject: [LTP] [PATCH v3] aio02: Drop O_DIRECT flag for tmpfs
In-Reply-To: <1581502051-17240-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <5E43C9A1.8090807@cn.fujitsu.com>
 <1581502051-17240-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <1078491624.7198409.1581514672304.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> tmpfs doesn't support O_DIRECT flag, drop it. So user still can run aio02
> with different filesystem by mounting specified filesystem on $TMPDIR.
> 
> Also remove unused static value initialization.
> 
> Reviewed-by: Xiao Yang <ice_yangxiao@163.com>
> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> ---
>  testcases/kernel/io/aio/aio02.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Acked-by: Jan Stancek <jstancek@redhat.com>

