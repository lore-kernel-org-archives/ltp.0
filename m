From: Joerg Vehlow <lkml@jv-coder.de>
Date: Wed, 25 Aug 2021 11:08:55 +0200
Subject: [LTP] [PATCH 2/3] C API: Rename LTP_IPC_PATH -> TST_IPC_PATH
In-Reply-To: <YSYGrt7xn32GxeUm@pevik>
References: <20210825080933.12949-1-pvorel@suse.cz>
 <20210825080933.12949-3-pvorel@suse.cz>
 <ba968568-5f0d-07f8-e5df-78f62148a3da@jv-coder.de> <YSYGrt7xn32GxeUm@pevik>
Message-ID: <519f189d-9219-629d-196e-29237d9417f9@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

On 8/25/2021 11:00 AM, Petr Vorel wrote:
> Hi Joerg,
>
> ...
>>> NOTE: IPC is not supported in the legacy API.
>> Do you mean legacy c api here? It is supported. See old_checkpoints.h.
> Ah good, point, thanks! (include/old/old_checkpoint.h). But if I look correctly,
> LTP_IPC_PATH is not used there, right?
It uses the same code as the new implementation (tst_checkpoint.c). So 
no changes necessary,
but the commit message is misleading.

Joerg
