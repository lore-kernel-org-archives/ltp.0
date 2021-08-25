From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 25 Aug 2021 11:20:22 +0200
Subject: [LTP] [PATCH 0/3] New API: Rename LTP_IPC_PATH -> TST_IPC_PATH
In-Reply-To: <YSYIt9TqTBU0AVKk@pevik>
References: <20210825080933.12949-1-pvorel@suse.cz> <YSYGy3cewt9Sseb/@yuki>
 <YSYIt9TqTBU0AVKk@pevik>
Message-ID: <YSYLVsq/UshH9wFx@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > As it is it's pretty clear where the environment variable comes from, if
> > we rename it to TST_IPC_PATH it's not obvious that this has been
> > exported by LTP test.
> I was thinking about it as well (just forget to write that into cover letter).
> 
> > Generally things that are visible on the running system tends to be
> > prefixed with LTP_ or ltp_ rather than TST_ or tst_...
> Sure. I just thought that LTP_ is for variables which are expected to be set by
> user. But let's keep the old name. How about the first commit (cleanup)?

There is no such rule I guess.

It has been case by case, for instance we do have KCONFIG_PATH which we
agreed on with the testing community to be a canonical variable name
that is shared between different frameworks.

-- 
Cyril Hrubis
chrubis@suse.cz
