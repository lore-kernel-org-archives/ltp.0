From: Joerg Vehlow <lkml@jv-coder.de>
Date: Wed, 25 Aug 2021 10:18:27 +0200
Subject: [LTP] [PATCH 3/3] shell API: Rename LTP_IPC_PATH -> TST_IPC_PATH
In-Reply-To: <20210825080933.12949-4-pvorel@suse.cz>
References: <20210825080933.12949-1-pvorel@suse.cz>
 <20210825080933.12949-4-pvorel@suse.cz>
Message-ID: <8d74045f-3ebc-526d-f875-6ca121475a4d@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

On 8/25/2021 10:09 AM, Petr Vorel wrote:
> To follow the conventions in the new API.
>
> Keep the old name in the legacy API.
That doesn't make sense. If you update the variable name in the c api, 
you also have to update the old shell api (i.e. test.sh).
Or maybe even remove the code from the old shell api completely. As far 
as I see there are no users of the checkpoint api anymore.
Both tests (cn_pec and memcfg/functional) were rewritten. It is probably 
safe to just drop the old api?

Joerg

