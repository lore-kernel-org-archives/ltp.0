From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 27 Aug 2019 12:16:44 +0200
Subject: [LTP] [PATCH v2] syscalls/statx04: use stx_attributes_mask
 before test
In-Reply-To: <20190827095858.GB28859@dell5510>
References: <20190802115046.GB27727@rei>
 <1566282838-2980-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20190827092520.GA28859@dell5510> <20190827095858.GB28859@dell5510>
Message-ID: <20190827101644.GA30582@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> also Cyril noted on Github issue #557 [1]:
> "However I'm not sure that we should do this since kernel devs declared this to be bug after all."
> 
> So maybe we should wait before applying it.
> 
> @Cyril: can you please post link to discussion in LKML?

I've talked to Jan Kara in person while developing these tests, so there
is no track of this discussion.

I guess that the best we can do here is to:

* Apply this patch, since the test should generally check only for flags
  that are supported in the bitflag returned by the syscall

* Add another test that checks that these bitflags are enabled for new
  enough kernels for certain set of filesystems

-- 
Cyril Hrubis
chrubis@suse.cz
