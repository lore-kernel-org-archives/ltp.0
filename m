From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 19 Jul 2017 17:30:31 +0200
Subject: [LTP] [PATCH v2 1/2] lib/test.sh: Remove temporary directory
 only if we know the location
In-Reply-To: <20170718142500.2725-1-pvorel@suse.cz>
References: <20170718142500.2725-1-pvorel@suse.cz>
Message-ID: <20170719153031.GM1015@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> This is a problem when a test TCONF before calling tst_tmpdir, but has
> tst_rmdir in cleanup function (e.g. dhcp_lib.sh when failing on
> tst_check_cmds).

I was wondering if we should produce at least TINFO message that
something is probably wrong with the cleanup function, but nobody would
read that unless we used TWARN.

So I guess that the patch is OK as it is, pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
