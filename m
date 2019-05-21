From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 21 May 2019 16:01:18 +0200
Subject: [LTP] [PATCH] lapi/ustat.h: Replace daddr_t with long
In-Reply-To: <20190520214911.1460-1-pvorel@suse.cz>
References: <20190520214911.1460-1-pvorel@suse.cz>
Message-ID: <20190521140118.GC19326@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> daddr_t is usually typedef to __kernel_daddr_t,
> which is int or long.

Well the size must match, so unless you have checked that it's defined
to int only in cases where sizeof(int) == sizeof(long) this change is
not correct.

-- 
Cyril Hrubis
chrubis@suse.cz
