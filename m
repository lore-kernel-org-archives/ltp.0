From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 8 Sep 2020 15:03:20 +0200
Subject: [LTP] [PATCH v2] syscalls/msgrcv03: Add error test for MSG_COPY
 flag
In-Reply-To: <1597722208-3672-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <20200813152536.GH13292@yuki.lan>
 <1597722208-3672-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20200908130320.GA17482@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with minor changes, thanks.

I've edited the strings so that they do not break over several lines and
also shortened some.

In LKML coding style strings that are printed as messages shouldn't be
broken into several parts in order to be able to grep for them in the
sources.

-- 
Cyril Hrubis
chrubis@suse.cz
