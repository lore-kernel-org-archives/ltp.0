From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 11 Sep 2018 00:41:18 +0200
Subject: [LTP] [PATCH v2] newlib_tests/test_exec.c: Fix compiler error
 before glibc v2.11
In-Reply-To: <1535328355-16759-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20180824145656.GA5131@rei>
 <1535328355-16759-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20180910224118.GA10554@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xiao,

> Before glibc v2.11, execvpe() was not introduced and resulted in
> compiler error, so we replace execvpe() with execve() and update
> test-writing-guidelines.txt.

> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>

Pushed, thanks!


Kind regards,
Petr
