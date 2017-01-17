From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 17 Jan 2017 12:47:36 +0100
Subject: [LTP] [PATCH 2/4] getcwd02.c: cleanup && convert to new API
In-Reply-To: <1483949756-8685-2-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1483949756-8685-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1483949756-8685-2-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20170117114736.GD10880@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Hmm, this test has been testing the extension with NULL buffer pointer
and allocations for ages, so it looks like it's widely implemented
extension and we can safely use it.

-- 
Cyril Hrubis
chrubis@suse.cz
