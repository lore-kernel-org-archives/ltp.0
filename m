From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 25 Jul 2016 18:21:33 +0200
Subject: [LTP] [PATCH 1/4] syscalls/socket01: convert to new API
In-Reply-To: <1466759093-15755-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1466759093-15755-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20160725162133.GC4052@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've traced down the kernel patch that changed the ESOCKTNOSUPPORT to
EPROTONOSUPPORT and changed the testcase to expect the only correct
errno EPROTONOSUPPORT from 2.6.16 on.

Pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
