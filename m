From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 3 Sep 2018 15:01:31 +0200
Subject: [LTP] [PATCH v4 2/2] lib/tst_test.c: Add .needs_devfs flag
In-Reply-To: <5B8C98F4.1060304@cn.fujitsu.com>
References: <20180830144943.GA20702@rei.lan>
 <1535774861-27429-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <20180831123102.GC30263@rei.lan> <5B8C98F4.1060304@cn.fujitsu.com>
Message-ID: <20180903130131.GC21765@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> This is a patch set, and i have factored out tst_path_has_mnt_flags() by 
> the first patch:
> http://lists.linux.it/pipermail/ltp/2018-August/009013.html

Ah, right, my bad, the rest of the patchset still applies.

I've modified that part so that we do not pass the NULL cleanup argument
in newlib tests (so that it's easier to remove the cleanup callback
completely it once the two oldlib tests that use the API are converted).

I've also cleaned up the last patch in the series so that we do not have
to pass the OFFSET to each tst_res() call, now we calculate the right
pointer at the start of the test.

And pushed the whole patchset, thanks!

-- 
Cyril Hrubis
chrubis@suse.cz
