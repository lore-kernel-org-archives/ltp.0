From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 14 May 2019 15:02:35 +0200
Subject: [LTP] [PATCH] syscall/ioctl: fix compiler error
In-Reply-To: <1557711965-11638-1-git-send-email-huangjh.jy@cn.fujitsu.com>
References: <1557711965-11638-1-git-send-email-huangjh.jy@cn.fujitsu.com>
Message-ID: <20190514130234.GB31720@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jinhui,

> "CLONE_NEWPID" and "CLONE_NEWUSER" are not defined on some old distros,
> so include "lapi/namespaces_constants.h" to fix it.

Can you be more specific, which distros?
CLONE_* has been added into glibc in 2008 (released in glibc 2.8).

> Signed-off-by: Jinhui huang <huangjh.jy@cn.fujitsu.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>

@Cyril: this could go before release as well.

Kind regards,
Petr
