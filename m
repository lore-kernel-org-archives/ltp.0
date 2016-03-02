From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 2 Mar 2016 15:09:06 +0100
Subject: [LTP] [PATCH] syscalls/recvmsg02: Add header file lapi/socket.h
In-Reply-To: <1456913026-10877-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1456913026-10877-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20160302140906.GB25763@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Compilation failed on RHEL5.11GA because SOCK_CLOEXEC is
> not included in sys/socket.h on RHEL5.11GA, so fix it.

Pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
