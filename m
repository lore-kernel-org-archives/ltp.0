From: Eric Biggers <ebiggers3@gmail.com>
Date: Mon, 6 Nov 2017 21:24:44 -0800
Subject: [LTP] [PATCH v2] syscalls/request_key03: new test for key
 instantiation races
In-Reply-To: <20171103130428.GA22844@rei>
References: <20171102191354.24733-1-ebiggers3@gmail.com>
 <20171103130428.GA22844@rei>
Message-ID: <20171107052444.GA6957@zzz.localdomain>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Nov 03, 2017 at 02:04:28PM +0100, Cyril Hrubis wrote:
> Hi!
> When I run the test as an ordinary user I got EDQUOT from add_key() from
> time to time. So we either have to add .needs_root = 1 so that quotas
> does not apply or change the test to ignore the EDQUOT as well while we
> are adding the key.
> 
> Otherwise the test is OK.
> 

Ugh, it seems this happens because the kernel frees space from the quota during
an asynchronous garbage collection phase, rather than immediately when the keys
are unlinked.  That's arguably a bug in its own right, but it's always been like
that and for now I guess I'll just make the test ignore EDQUOT.

Eric
