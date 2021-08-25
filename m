From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 25 Aug 2021 11:09:11 +0200
Subject: [LTP] [PATCH 0/3] New API: Rename LTP_IPC_PATH -> TST_IPC_PATH
In-Reply-To: <YSYGy3cewt9Sseb/@yuki>
References: <20210825080933.12949-1-pvorel@suse.cz>
 <YSYGy3cewt9Sseb/@yuki>
Message-ID: <YSYIt9TqTBU0AVKk@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> Hi!
> > Petr Vorel (3):
> >   lib: Move IPC_ENV_VAR definition into header
> >   C API: Rename LTP_IPC_PATH -> TST_IPC_PATH
> >   shell API: Rename LTP_IPC_PATH -> TST_IPC_PATH

> Is this really a good idea?

> As it is it's pretty clear where the environment variable comes from, if
> we rename it to TST_IPC_PATH it's not obvious that this has been
> exported by LTP test.
I was thinking about it as well (just forget to write that into cover letter).

> Generally things that are visible on the running system tends to be
> prefixed with LTP_ or ltp_ rather than TST_ or tst_...
Sure. I just thought that LTP_ is for variables which are expected to be set by
user. But let's keep the old name. How about the first commit (cleanup)?

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/wiki/User-Guidelines
