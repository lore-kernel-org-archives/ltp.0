From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 27 Mar 2019 17:03:16 +0100
Subject: [LTP] [PATCH 1/1] shell: Fix handling default parameters in
	tst_mkfs()
In-Reply-To: <20190327155252.761-1-pvorel@suse.cz>
References: <20190327155252.761-1-pvorel@suse.cz>
Message-ID: <20190327160316.GA9691@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> fixes regression when testing df01.sh
> 
> Dash does not like shifting more than possible:
> /opt/ltp/testcases/bin/df01.sh: 291: shift: can't shift that many
> 
> Fixes: 465faf47f ("shell: Use $TST_FS_TYPE and $TST_DEVICE in tst_mkfs()")
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Hi,
> 
> don't like checking $# twice, but don't see right now way to do it
> simpler.

We can do the same thing twice as well, which may be a bit more
readable:

	[ $# -ge 1 ] && shift
	[ $# -ge 1 ] && shift

-- 
Cyril Hrubis
chrubis@suse.cz
