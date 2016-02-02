From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 2 Feb 2016 19:04:48 +0100
Subject: [LTP] [PATCH V2 15/32] mincore01: Rename PAGESIZE to pagesize
In-Reply-To: <1452302060-103643-15-git-send-email-raj.khem@gmail.com>
References: <1452302060-103643-1-git-send-email-raj.khem@gmail.com>
 <1452302060-103643-15-git-send-email-raj.khem@gmail.com>
Message-ID: <20160202180448.GU19199@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> PAGESIZE conflicts with system headers on musl

I've pushed this patch, but I think that it should be reported as musl
bug as well, since IMHO the only public visible identificators defined
by libc should be the UNIX/Linux API as defined in manuals and
identifiers starting with underscore (for internal definitions).

-- 
Cyril Hrubis
chrubis@suse.cz
