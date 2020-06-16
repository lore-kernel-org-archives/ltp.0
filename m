From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 16 Jun 2020 15:26:34 +0200
Subject: [LTP] [PATCH v1 1/2] libs/libltpnewipc: Add missing libmsgctl.c
In-Reply-To: <1592298082-21792-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1592298082-21792-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20200616132634.GC2790@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Add libmsgctl.c into ltp new ipc libs, so the upcoming msgstress cleanup cases
> can use its functions.

First of all the code should be ported into new library, which among
other things, means that the printf() should be replaced with tst_res(),
and there would no longer be a reason to return the PASS/FAIL since that
would be handled by the test library from that point on.

-- 
Cyril Hrubis
chrubis@suse.cz
