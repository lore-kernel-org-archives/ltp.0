From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 30 Oct 2020 11:31:16 +0100
Subject: [LTP] [PATCH 04/19] Unify error handling in lib/safe_file_ops.c
In-Reply-To: <fbb52689-5797-7615-e4b8-a8bcabee09e8@suse.cz>
References: <20201026164756.30556-1-mdoucha@suse.cz>
 <20201026164756.30556-5-mdoucha@suse.cz>
 <20201029155907.GC8378@yuki.lan> <20201029160222.GD8378@yuki.lan>
 <af6cdfdd-23e8-1593-9509-43685e4706c3@suse.cz>
 <20201029161714.GE8378@yuki.lan>
 <fbb52689-5797-7615-e4b8-a8bcabee09e8@suse.cz>
Message-ID: <20201030103116.GA27262@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >> These safe file functions could use some additional improvements but
> >> changing the return value is out of scope of my patchset. That would
> >> probably require reviewing and modifying some test code as well. The
> >> patchset is over 4000 lines long as is.
> > 
> > It's actually not since you are chaning the void functions to return
> > int, if you kept them void that would mean that it's out of scope.
> 
> Changing return type from void to int is fully backwards compatible
> because the return value is ignored everywhere anyway.

However it exposes suboptimal interface that shouldn't have been exposed
in the first place. So I would rather leave these to return void so that
no new code starts to depend on the current behavior.

-- 
Cyril Hrubis
chrubis@suse.cz
