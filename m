From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 6 Mar 2018 14:16:11 +0100
Subject: [LTP] [RFC PATCH v2 1/1] rpc: Use libtirpc for all RPC tests +
 detect headers location
In-Reply-To: <20180306124322.28876-1-pvorel@suse.cz>
References: <20180306124322.28876-1-pvorel@suse.cz>
Message-ID: <20180306131611.GD16934@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> RPC implementation in glibc has been deprecated since glibc 2.16
> (headers + bindings were available via --enable-obsolete-rpc) and other
> libc ususaly don't implement rpc anyway, it's time to move on and link
> against libtirpc. While this fixes problem on these libc
> implementations, without libtirpc we obviously end up with no RPC tests.

Looks good to me, acked.

-- 
Cyril Hrubis
chrubis@suse.cz
