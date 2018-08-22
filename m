From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 22 Aug 2018 02:49:23 -0400 (EDT)
Subject: [LTP] [PATCH v2] syscalls/execveat03: Fix compiler errors
In-Reply-To: <1534902864-19343-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1642007852.41615039.1534852963645.JavaMail.zimbra@redhat.com>
 <1534902864-19343-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <290094759.41782706.1534920563792.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it


----- Original Message -----
> According to open(2) and linkat(2) manpages, O_PATH and AT_EMPTY_PATH
> flags were added since kernel v2.6.39, so these undefined flags led
> to the following errors on older kernels(e.g. v2.6.32):
> ---------------------------------------------------------
> execveat03.c:66: error: ‘O_PATH’ undeclared (first use in this function)
> execveat03.c:69: error: ‘AT_EMPTY_PATH’ undeclared (first use in this
> function)
> ---------------------------------------------------------
> 
> 1) Add AT_EMPTY_PATH into lapi/fcntl.h
> 2) Include lapi/fcntl.h in execveat03.c
> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>

Pushed.

We could add also minimum kernel version check, but since test
is using ltp_syscall(), it handles ENOSYS. I'll leave it as it
is for now.

Thanks,
Jan
