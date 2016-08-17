From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 17 Aug 2016 11:37:59 +0200
Subject: [LTP] [PATCH] tst_test.h: fix tst_test->tid for unsupported
	cases
In-Reply-To: <20160817092938.GD5817@rei.lan>
References: <1471425396-26898-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <20160817092211.GC5817@rei.lan> <20160817092938.GD5817@rei.lan>
Message-ID: <20160817093759.GE5817@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Hmm, we do not print the tid in case of TCONF, I thought we did, so we
> can proceed with your patch as well.

Pushed with minor change and added commit that broke it into the
changelog, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
