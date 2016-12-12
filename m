From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 12 Dec 2016 15:28:47 +0100
Subject: [LTP] [PATCH v2 1/5] tst_test.h: move test result description
 to tst_res.h
In-Reply-To: <1481087800-20639-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20161123135513.GI3346@rei.lan>
 <1481087800-20639-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20161212142847.GD21828@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Move test result description to tst_res.h so that we
> can use them independently for new ipc.

Isn't definining TST_NO_DEFAULT_MAIN before you include tst_test.h
enough? Is there any other problem?

-- 
Cyril Hrubis
chrubis@suse.cz
