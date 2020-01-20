From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 20 Jan 2020 15:05:28 +0100
Subject: [LTP] [PATCH 2/2] tst_device: Move tst_dev_sync() into from
 header to source file
In-Reply-To: <20200120135533.GC21132@rei.lan>
References: <20200120133646.8629-1-pvorel@suse.cz>
 <20200120133646.8629-2-pvorel@suse.cz>
 <20200120135243.GA10589@dell5510> <20200120135533.GC21132@rei.lan>
Message-ID: <20200120140528.GA12381@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> Besides of that we need either of the two patches to fix the problem,
> now I do wonder which one should we apply before the release.

> I guess that moving the function to the library code is a bit more
> conservative move after all, so we may as well apply that and fix the
> socketcall test after the release.
+1.

Kind regards,
Petr
