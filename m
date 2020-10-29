From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 29 Oct 2020 17:17:14 +0100
Subject: [LTP] [PATCH 04/19] Unify error handling in lib/safe_file_ops.c
In-Reply-To: <af6cdfdd-23e8-1593-9509-43685e4706c3@suse.cz>
References: <20201026164756.30556-1-mdoucha@suse.cz>
 <20201026164756.30556-5-mdoucha@suse.cz>
 <20201029155907.GC8378@yuki.lan> <20201029160222.GD8378@yuki.lan>
 <af6cdfdd-23e8-1593-9509-43685e4706c3@suse.cz>
Message-ID: <20201029161714.GE8378@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > That's true for printf() scanf returns EOF instead. But I guess that
> > anything < 0 would work better than 1 which means that one input item
> > was matched successfuly...
> 
> These safe file functions could use some additional improvements but
> changing the return value is out of scope of my patchset. That would
> probably require reviewing and modifying some test code as well. The
> patchset is over 4000 lines long as is.

It's actually not since you are chaning the void functions to return
int, if you kept them void that would mean that it's out of scope.

Also actually FILE_PRINTF() can be replaced SAFE_FILE_PRINTF() for all
new library tests since tst_brk() does not exit cleanup() anymore so it
may as well be easier to just get rid of FILE_PRINTF() in new test
library.

-- 
Cyril Hrubis
chrubis@suse.cz
