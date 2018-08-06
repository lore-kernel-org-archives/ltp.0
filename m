From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 6 Aug 2018 03:07:06 -0400 (EDT)
Subject: [LTP] [PATCH v2 5/5] syscalls/flock06: Rewrite to new library
In-Reply-To: <1533532135-7496-1-git-send-email-huangjh.jy@cn.fujitsu.com>
References: <1649896669.37585897.1533212964490.JavaMail.zimbra@redhat.com>
 <1533532135-7496-1-git-send-email-huangjh.jy@cn.fujitsu.com>
Message-ID: <765396439.38655246.1533539226649.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Signed-off-by: Jinhui huang <huangjh.jy@cn.fujitsu.com>
> ---
>  testcases/kernel/syscalls/flock/flock06.c | 213
>  ++++++++----------------------
>  1 file changed, 52 insertions(+), 161 deletions(-)

Hi,

Series pushed with few minor tweaks:

flock01: fd initialized to -1, checked for >= 0 in cleanup()
flock02: added close() to a branch calling return in verify_flock()
flock04: string passed to child() function changed to reflect child parameters
flock06: two conditions made more strict by changing "== -1" to "!= 0"

Thanks,
Jan
