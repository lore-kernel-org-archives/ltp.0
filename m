From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 4 Sep 2018 04:20:02 -0400 (EDT)
Subject: [LTP] [PATCH] syscalls/mlock203: Add new regression testcase
In-Reply-To: <1535008217-27041-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1535008217-27041-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1090164327.44377797.1536049202389.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> This issue has been fixed in kernel:
> 'b155b4fde5bd("mm: mlock: avoid increase mm->locked_vm on mlock() when
> already mlock2(,MLOCK_ONFAULT)")'
> 
> Note:
> This patch is based on the following patch set:
> http://lists.linux.it/pipermail/ltp/2018-August/009086.html
> http://lists.linux.it/pipermail/ltp/2018-August/009085.html
> http://lists.linux.it/pipermail/ltp/2018-August/009084.html
> http://lists.linux.it/pipermail/ltp/2018-August/009087.html
> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>

Pushed with tweaked commit message.

Thanks,
Jan
