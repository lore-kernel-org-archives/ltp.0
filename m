From: Joerg Vehlow <lkml@jv-coder.de>
Date: Wed, 25 Aug 2021 10:15:49 +0200
Subject: [LTP] [PATCH 2/3] C API: Rename LTP_IPC_PATH -> TST_IPC_PATH
In-Reply-To: <20210825080933.12949-3-pvorel@suse.cz>
References: <20210825080933.12949-1-pvorel@suse.cz>
 <20210825080933.12949-3-pvorel@suse.cz>
Message-ID: <ba968568-5f0d-07f8-e5df-78f62148a3da@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

On 8/25/2021 10:09 AM, Petr Vorel wrote:
> To follow the conventions in the new API.
>
> Update also C API docs.
>
> NOTE: IPC is not supported in the legacy API.
Do you mean legacy c api here? It is supported. See old_checkpoints.h.

Joerg
