From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 20 Jan 2020 14:55:33 +0100
Subject: [LTP] [PATCH 2/2] tst_device: Move tst_dev_sync() into from
 header to source file
In-Reply-To: <20200120135243.GA10589@dell5510>
References: <20200120133646.8629-1-pvorel@suse.cz>
 <20200120133646.8629-2-pvorel@suse.cz>
 <20200120135243.GA10589@dell5510>
Message-ID: <20200120135533.GC21132@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Sorry for wrong patch.

Besides of that we need either of the two patches to fix the problem,
now I do wonder which one should we apply before the release.

I guess that moving the function to the library code is a bit more
conservative move after all, so we may as well apply that and fix the
socketcall test after the release.

-- 
Cyril Hrubis
chrubis@suse.cz
