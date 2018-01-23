From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 23 Jan 2018 04:56:54 -0500 (EST)
Subject: [LTP] [PATCH v2] is_fuse: return zore if fs_type is NULL
In-Reply-To: <20180123094635.17931-1-liwang@redhat.com>
References: <20180123094635.17931-1-liwang@redhat.com>
Message-ID: <1241828969.3094937.1516701414599.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> This commmit 28507e514c(safe_mount: Do not try mount() syscall for FUSE fs)
> involves FUSE fs check in safe_mount(), but we'd better guarantee the
> "fs_type"
> is legal to check in is_fuse() function otherwise system will kill the
> program.
> 
>   cmdline="fanotify06"
>   contacts=""
>   analysis=exit
>   <<<test_output>>>
>   tst_test.c:980: INFO: Timeout per run is 0h 10m 00s
>   tst_test.c:1025: BROK: Test killed by SIGSEGV!
> 
> Signed-off-by: Li Wang <liwang@redhat.com>

Pushed with small tweak to commit message.

Regards,
Jan
