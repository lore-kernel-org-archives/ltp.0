From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 13 Aug 2019 13:31:21 +0200
Subject: [LTP] [PATCH] syscalls/setxattr03: Ported into new library
In-Reply-To: <1565083417-2294-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1565083417-2294-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20190813113120.GB31571@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with minor changes, thanks.

* Changed the SPDX identifier to GPL-v2.0 to match the original license

* Adjusted the PASS/FAIL reporting a bit, made it use the tst_strerrno()

* Added if (fd > 0) before the SAFE_CLOSE() in cleanup, otherwise we
  would produce TWARN in a case attributes are not supported and the setup()
  called the tst_brk(TCONF, ...)

-- 
Cyril Hrubis
chrubis@suse.cz
