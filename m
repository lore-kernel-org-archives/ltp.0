From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 7 Oct 2020 07:03:04 -0400 (EDT)
Subject: [LTP] [PATCH] crypto/af_alg07: Skip this case when not having
 sockfs_setattr
In-Reply-To: <1601966875-5375-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1601966875-5375-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <327178228.17133052.1602068584591.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> From: "Yang Xu" <xuyang2018.jy@cn.fujitsu.com>
> To: ltp@lists.linux.it
> Sent: Tuesday, 6 October, 2020 8:47:55 AM
> Subject: [LTP] [PATCH] crypto/af_alg07: Skip this case when not having sockfs_setattr
> 
> Since kernel 4.10-rc1 commit 86741ec25462 ("net: core: Add a UID field to
> struct sock."),
> it introduced sockfs_setattr function. This test needs to use this function
> to trigger this cve bug, so skip it if kernel < 4.10.
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>

Pushed.

Thanks,
Jan

