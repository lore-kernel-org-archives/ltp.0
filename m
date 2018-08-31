From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 31 Aug 2018 14:10:25 +0200
Subject: [LTP] [PATCH v2] newlib_tests/test_exec.c: Fix compiler error
 before glibc v2.11
In-Reply-To: <1535328355-16759-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20180824145656.GA5131@rei>
 <1535328355-16759-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20180831121025.GA1242@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xiao,

> Before glibc v2.11, execvpe() was not introduced and resulted in
> compiler error, so we replace execvpe() with execve() and update
> test-writing-guidelines.txt.
Oh, that's a history :). But as it's forward compatible, why not.

> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>


Kind regards,
Petr
