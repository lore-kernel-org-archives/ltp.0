From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 2 Feb 2016 17:48:30 +0100
Subject: [LTP] [PATCH V2 20/32] getdents: define getdents/getdents64
 only for glibc
In-Reply-To: <1452302060-103643-20-git-send-email-raj.khem@gmail.com>
References: <1452302060-103643-1-git-send-email-raj.khem@gmail.com>
 <1452302060-103643-20-git-send-email-raj.khem@gmail.com>
Message-ID: <20160202164829.GJ19199@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> getdents/getdents64 are implemented in musl and when we define static
> functions with same name, it errors out.

It would be better if this was a configure check and moved to
include/lapi/ where the rest of the fallback definitions is.

-- 
Cyril Hrubis
chrubis@suse.cz
