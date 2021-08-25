From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 25 Aug 2021 11:00:30 +0200
Subject: [LTP] [PATCH 2/3] C API: Rename LTP_IPC_PATH -> TST_IPC_PATH
In-Reply-To: <ba968568-5f0d-07f8-e5df-78f62148a3da@jv-coder.de>
References: <20210825080933.12949-1-pvorel@suse.cz>
 <20210825080933.12949-3-pvorel@suse.cz>
 <ba968568-5f0d-07f8-e5df-78f62148a3da@jv-coder.de>
Message-ID: <YSYGrt7xn32GxeUm@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Joerg,

...
> > NOTE: IPC is not supported in the legacy API.
> Do you mean legacy c api here? It is supported. See old_checkpoints.h.
Ah good, point, thanks! (include/old/old_checkpoint.h). But if I look correctly,
LTP_IPC_PATH is not used there, right?

Kind regards,
Petr
