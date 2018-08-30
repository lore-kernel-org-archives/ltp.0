From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 30 Aug 2018 08:43:55 -0400 (EDT)
Subject: [LTP] [PATCH v2 4/4] syscalls/mlock202: Add new testcase
In-Reply-To: <1535699602-28185-2-git-send-email-yangx.jy@cn.fujitsu.com>
References: <864746561.43466655.1535545169373.JavaMail.zimbra@redhat.com>
 <1535699602-28185-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1535699602-28185-2-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1945225887.43673570.1535633035153.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Check various errnos for mlock2(2) since kernel v2.6.9.
> 
> Note:
> 1) We use tst_syscall() to check if mlock2() is supported.
> 2) since kernel v2.6.9, the limits and permissions of mlock2()
>    changed, so we just check mlock2() since the version.
> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>

Ack
