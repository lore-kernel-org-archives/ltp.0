From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 21 Jun 2021 16:50:02 +0200
Subject: [LTP] [PATCH] io/ltp-aiodio: fix function return value
In-Reply-To: <1622790418-36793-1-git-send-email-liubo03@inspur.com>
References: <1622790418-36793-1-git-send-email-liubo03@inspur.com>
Message-ID: <YNCnGpf8oQowhoMV@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
This makes it slightly better but still the most imporant part, the
check in the child process, is ignored.

Easiest fix would be rewriting the tests to the new test library so that
we could use tst_res(TFAIL, ...) in the child processess as well.

-- 
Cyril Hrubis
chrubis@suse.cz
