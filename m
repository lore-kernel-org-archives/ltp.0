From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 25 Aug 2021 11:00:59 +0200
Subject: [LTP] [PATCH 0/3] New API: Rename LTP_IPC_PATH -> TST_IPC_PATH
In-Reply-To: <20210825080933.12949-1-pvorel@suse.cz>
References: <20210825080933.12949-1-pvorel@suse.cz>
Message-ID: <YSYGy3cewt9Sseb/@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Petr Vorel (3):
>   lib: Move IPC_ENV_VAR definition into header
>   C API: Rename LTP_IPC_PATH -> TST_IPC_PATH
>   shell API: Rename LTP_IPC_PATH -> TST_IPC_PATH

Is this really a good idea?

As it is it's pretty clear where the environment variable comes from, if
we rename it to TST_IPC_PATH it's not obvious that this has been
exported by LTP test.

Generally things that are visible on the running system tends to be
prefixed with LTP_ or ltp_ rather than TST_ or tst_...

-- 
Cyril Hrubis
chrubis@suse.cz
