From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 24 Jun 2016 08:40:16 -0400 (EDT)
Subject: [LTP] [PATCH] syscalls/removexattr02:skip the test if no
	xattr	support
In-Reply-To: <1466739362-5914-1-git-send-email-shuang.qiu@oracle.com>
References: <1466739362-5914-1-git-send-email-shuang.qiu@oracle.com>
Message-ID: <1959236773.1678649.1466772016581.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "shuang qiu" <shuang.qiu@oracle.com>
> To: ltp@lists.linux.it
> Sent: Friday, 24 June, 2016 5:36:02 AM
> Subject: [LTP] [PATCH] syscalls/removexattr02:skip the test if no xattr	support
> 
> From: Shuang Qiu <shuang.qiu@oracle.com>
> 
> Return TCONF if there is no xattr support in fs or mount without user_xattr
> option

Why only in removexattr02? Should we do the same for removexattr01?

Regards,
Jan
