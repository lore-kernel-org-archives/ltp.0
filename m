From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 7 Nov 2017 11:20:03 +0100
Subject: [LTP] [PATCH v2] syscalls/request_key03: new test for key
 instantiation races
In-Reply-To: <20171107052444.GA6957@zzz.localdomain>
References: <20171102191354.24733-1-ebiggers3@gmail.com>
 <20171103130428.GA22844@rei>
 <20171107052444.GA6957@zzz.localdomain>
Message-ID: <20171107102003.GA6126@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > When I run the test as an ordinary user I got EDQUOT from add_key() from
> > time to time. So we either have to add .needs_root = 1 so that quotas
> > does not apply or change the test to ignore the EDQUOT as well while we
> > are adding the key.
> > 
> > Otherwise the test is OK.
> > 
> 
> Ugh, it seems this happens because the kernel frees space from the quota during
> an asynchronous garbage collection phase, rather than immediately when the keys
> are unlinked.  That's arguably a bug in its own right, but it's always been like
> that and for now I guess I'll just make the test ignore EDQUOT.

I guess that this is not that serious since I doubt that anybody will
add keys in a tight loop like we do in the tests.

I remeber that we had similar problems with the hugepage poll limits
where we had to set the limits to be twice of the actual allocations to
avoid failures when allocating and freeing these in a loop.

-- 
Cyril Hrubis
chrubis@suse.cz
