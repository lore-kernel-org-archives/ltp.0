From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 11 Dec 2018 13:37:01 +0100
Subject: [LTP] Question about strncpy_2-1
In-Reply-To: <5C0F8A93.20800@cn.fujitsu.com>
References: <5C0F83AC.8070902@cn.fujitsu.com> <5C0F8A93.20800@cn.fujitsu.com>
Message-ID: <20181211123701.GB27346@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> In addition, this compiler error doesn't break the whole openposix compilation.

That is the desing of the openposix build system, compilation failures
are not fatal.

-- 
Cyril Hrubis
chrubis@suse.cz
