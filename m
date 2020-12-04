From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 4 Dec 2020 14:52:50 +0100
Subject: [LTP] [PATCH 1/5] syscalls/fanotify: Generalize check for
 FAN_REPORT_FID support
In-Reply-To: <20201204095930.866421-2-amir73il@gmail.com>
References: <20201204095930.866421-1-amir73il@gmail.com>
 <20201204095930.866421-2-amir73il@gmail.com>
Message-ID: <X8o/MlfK7iUPeKLm@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Amir,

> Generalize the helpers to be able to check any fanotify_init() flags
> and pass FAN_REPORT_FID as argument in call sites.

> Add helper fanotify_init_flags_supported_by_kernel() to check for
> kernel support for fanotify_init flags without checking fs support
> for those flags.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
