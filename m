From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 2 Aug 2018 07:20:06 -0400 (EDT)
Subject: [LTP] [PATCH 3/5] syscalls/flock03: Rewrite to new library
In-Reply-To: <1533182024-18841-3-git-send-email-huangjh.jy@cn.fujitsu.com>
References: <1533182024-18841-1-git-send-email-huangjh.jy@cn.fujitsu.com>
 <1533182024-18841-3-git-send-email-huangjh.jy@cn.fujitsu.com>
Message-ID: <1348756569.37573503.1533208806908.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> Signed-off-by: Jinhui huang <huangjh.jy@cn.fujitsu.com>
> ---
>  testcases/kernel/syscalls/flock/flock03.c | 203
>  ++++++++----------------------
>  1 file changed, 53 insertions(+), 150 deletions(-)

ACK
