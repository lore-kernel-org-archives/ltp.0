From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 1 Jun 2020 16:25:58 +0200
Subject: [LTP] [PATCH] LIB: Use INTERNAL_LIB for ltp lib
In-Reply-To: <1590730943-23463-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1590730943-23463-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20200601142558.GA24805@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> ./lib/libltp.a

I wonder if we break some third party testsuite by ommitting the
libltp.a from being installed but I guess that unless anybody objects
here we do not care that much.

-- 
Cyril Hrubis
chrubis@suse.cz
