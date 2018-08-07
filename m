From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 7 Aug 2018 11:16:25 +0200
Subject: [LTP] [PATCH v3] syscalls/alarm02: Rewrite to new library
In-Reply-To: <1533532298-7551-1-git-send-email-huangjh.jy@cn.fujitsu.com>
References: <20180802155433.GB21827@rei>
 <1533532298-7551-1-git-send-email-huangjh.jy@cn.fujitsu.com>
Message-ID: <20180807091625.GA19406@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with minor changes, thanks.

* TEST_RETURN -> TST_RET
* There is no need to tst_reap_children() if child did exit(0).
* etc.

-- 
Cyril Hrubis
chrubis@suse.cz
