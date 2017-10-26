From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 26 Oct 2017 03:38:11 -0400 (EDT)
Subject: [LTP] [PATCH] syscalls/ptrace07.c: Fix compilation
	without	WIFEXITED and WEXITSTATUS
In-Reply-To: <1508989487-6715-1-git-send-email-huangjh.jy@cn.fujitsu.com>
References: <1508989487-6715-1-git-send-email-huangjh.jy@cn.fujitsu.com>
Message-ID: <1382839163.32286292.1509003491468.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> Compilation failed on some older distributions due to undefined
> WIFEXITED and WEXITSTATUS, so we include sys/wait.h to fix it.
> 
> Signed-off-by: Jinhui Huang <huangjh.jy@cn.fujitsu.com>

Pushed.

Thanks,
Jan
