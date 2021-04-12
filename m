From: Joerg Vehlow <lkml@jv-coder.de>
Date: Mon, 12 Apr 2021 13:41:21 +0200
Subject: [LTP] [PATCH v2 1/1] pec: Convert to the new API
In-Reply-To: <20210330072727.16565-1-pvorel@suse.cz>
References: <20210330072727.16565-1-pvorel@suse.cz>
Message-ID: <adcaa3fe-5ef2-8cc4-381b-2a753f3207a9@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,


On 3/30/2021 9:27 AM, Petr Vorel wrote:
> From: Joerg Vehlow <joerg.vehlow@aox-tech.de>
>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Hi Joerg,
>
> few fixes for this commit:
> * event_generator uses SAFE_EXECVP() instead of SAFE_EXECV()
> * use ROD for event_generator (it checks startup failure for us)
> * remove bashism (SIGINT => INT), use #!/bin/sh
> * remove useless exit 0
> * add local
> * few minor reword
>
> It also expects tst_safe_macros: Add SAFE_EXECVP() patch [1].
>
> Kind regards,
> Petr
>
> [1] https://patchwork.ozlabs.org/project/ltp/patch/20210329174135.23890-1-pvorel@suse.cz/
sorry for the long delay, I was on vacation.
I'll catch up with this in the next few days.

J?rg

