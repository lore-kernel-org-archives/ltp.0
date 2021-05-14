From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 14 May 2021 11:12:11 +0200
Subject: [LTP] [PATCH] syscalls/unshare02: Fix failures on Debian
In-Reply-To: <20210514080708.20036-1-chrubis@suse.cz>
References: <20210514080708.20036-1-chrubis@suse.cz>
Message-ID: <YJ4+6+QJPF2XmYio@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> The order of checks in kernel is not defined and on Debian we end up
> getting eperm even before the flags are checked which fails the invalid
> flags testcase.

> The fix is simple, we change the test to setuid() only for the EPERM
> test.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Tested-by: Petr Vorel <pvorel@suse.cz>

Thanks!

Kind regards,
Petr

