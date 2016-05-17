From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 17 May 2016 15:45:14 +0200
Subject: [LTP] [PATCH v2] syscalls/access01: Fix the test to run both
 under nobody and root
In-Reply-To: <1463464914-7679-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20160516122326.GB6454@rei.lan>
 <1463464914-7679-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20160517134513.GE12051@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've changed the test to fork a child and call setuid() instead of doing
TCONF when the test should be executed as a nobody and pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
