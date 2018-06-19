From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 19 Jun 2018 08:34:58 -0400 (EDT)
Subject: [LTP] [PATCH] syscalls/fallocate05: Add missing
 FALLOC_FL_KEEP_SIZE	flag
In-Reply-To: <1528339200-15655-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1528339200-15655-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <377528418.27491781.1529411698918.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> According to fallocate(2) manpage and kernel source code, if fallocate(2)
> only specify FALLOC_FL_PUNCH_HOLE flag, it always gets EOPNOTSUPP.  We
> should specify both FALLOC_FL_PUNCH_HOLE and FALLOC_FL_KEEP_SIZE.
> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>

Pushed.

Thanks,
Jan
