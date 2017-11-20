From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 20 Nov 2017 06:18:42 -0500 (EST)
Subject: [LTP] [PATCH] fs_fill: switch the SAFE MACROs back to
	ordinary	syscall
In-Reply-To: <20171110111519.27872-1-liwang@redhat.com>
References: <20171110111519.27872-1-liwang@redhat.com>
Message-ID: <1515676468.42550872.1511176722601.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> To fix those brokens:
>   safe_macros.c:225: BROK: tst_fill_fs.c:43:
>   open(mntpoint/thread48/file0,65,0700) failed: ENOSPC
>   safe_macros.c:169: BROK: fs_fill.c:49: mkdir(mntpoint/thread21,0700)
>   failed: ENOSPC
> 
> Signed-off-by: Li Wang <liwang@redhat.com>

Pushed.

Thanks,
Jan
