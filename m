From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 2 Aug 2018 07:03:32 -0400 (EDT)
Subject: [LTP] [PATCH 1/5] syscalls/flock01: Rewrite to new library
In-Reply-To: <1533182024-18841-1-git-send-email-huangjh.jy@cn.fujitsu.com>
References: <1533182024-18841-1-git-send-email-huangjh.jy@cn.fujitsu.com>
Message-ID: <1493862685.37571893.1533207812034.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> Signed-off-by: Jinhui huang <huangjh.jy@cn.fujitsu.com>
> ---
>  testcases/kernel/syscalls/flock/flock01.c | 186
>  ++++++------------------------
>  1 file changed, 35 insertions(+), 151 deletions(-)

ACK

Just a nit:
        if (fd > 0)
                SAFE_CLOSE(fd);

fd == 0 can also be valid fd, but skipping this close would
be fine anyway. (no need to repost)

Regards,
Jan
