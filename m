From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 20 Aug 2021 12:59:14 +0200
Subject: [LTP] [PATCH v2 1/2] shell: Add checkpoints api for new lib
In-Reply-To: <20210812043807.3497492-1-lkml@jv-coder.de>
References: <20210812043807.3497492-1-lkml@jv-coder.de>
Message-ID: <YR+LAmVDEUcZ51Wt@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Joerg,

LGTM, good idea.

But I'd rename $LTP_IPC_PATH to $TST_IPC_PATH to follow conventions to new API
(There are also some LTP_* definitions in the legacy C API which were renamed as
TST_* in the new API).


> +	if [ -n "$TST_NEEDS_CHECKPOINTS" -a -f "${LTP_IPC_PATH}" ]; then
nit (remove unnecessary {}):
    if [ -n "$TST_NEEDS_CHECKPOINTS" -a -f "$TST_IPC_PATH" ]; then
> +		rm ${LTP_IPC_PATH}
and here:
		rm $TST_IPC_PATH

Kind regards,
Petr
