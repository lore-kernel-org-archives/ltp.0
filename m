From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 25 Aug 2021 11:04:57 +0200
Subject: [LTP] [PATCH 3/3] shell API: Rename LTP_IPC_PATH -> TST_IPC_PATH
In-Reply-To: <8d74045f-3ebc-526d-f875-6ca121475a4d@jv-coder.de>
References: <20210825080933.12949-1-pvorel@suse.cz>
 <20210825080933.12949-4-pvorel@suse.cz>
 <8d74045f-3ebc-526d-f875-6ca121475a4d@jv-coder.de>
Message-ID: <YSYHuczVmaLlVG3D@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Joerg,

> > Keep the old name in the legacy API.
> That doesn't make sense. If you update the variable name in the c api, you
> also have to update the old shell api (i.e. test.sh).
Ah, shell API implementation obviously depends on C API. Thanks for info.

> Or maybe even remove the code from the old shell api completely. As far as I
> see there are no users of the checkpoint api anymore.
> Both tests (cn_pec and memcfg/functional) were rewritten. It is probably
> safe to just drop the old api?
I'll check it, if it's really not used in the legacy API, I'd be also for removing it.


Kind regards,
Petr
