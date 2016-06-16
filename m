From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 16 Jun 2016 04:49:09 -0400 (EDT)
Subject: [LTP] [PATCH] lib/tst_test.c: fix Segmentation fault in
 tst_vbrk_
In-Reply-To: <1466063524-13140-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1466063524-13140-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <547888132.6984380.1466066949440.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Xiao Yang" <yangx.jy@cn.fujitsu.com>
> To: ltp@lists.linux.it
> Sent: Thursday, 16 June, 2016 9:52:04 AM
> Subject: [LTP] [PATCH] lib/tst_test.c: fix Segmentation fault in tst_vbrk_
> 
> We can't allocate resources to results pointer before checking
> kernel version, so do_exit() will fail if we print results pointer.
> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>

Thanks, I pushed a patch that fixes do_exit() instead. So we
preserve do_exit as a single place for library process to exit.

Regards,
Jan

