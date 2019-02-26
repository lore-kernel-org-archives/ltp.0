From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 26 Feb 2019 11:03:43 -0500 (EST)
Subject: [LTP] [PATCH v3] syscalls/cma: fix the failure of compiling
 with O2 option
In-Reply-To: <1551147760-52601-1-git-send-email-kerneljasonxing@linux.alibaba.com>
References: <1551145346-34128-1-git-send-email-kerneljasonxing@linux.alibaba.com>
 <1551147760-52601-1-git-send-email-kerneljasonxing@linux.alibaba.com>
Message-ID: <1264466852.2951440.1551197023500.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> This issue is triggered by the commit 9b02cd465f70 which I wrote. If
> compile the process_vm_readv03.c with O2 option and run, it will return
> TFAIL. By casting the int type to unsigned long type in the ltp_syscall
> calling functions can we avoid this failure. Thus I modify all the
> testcases which might be affected by the previous commit.
> 
> Signed-off-by: Jason Xing <kerneljasonxing@linux.alibaba.com>

Pushed.

Thanks,
Jan
