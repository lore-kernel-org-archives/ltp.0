From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 4 Dec 2020 14:55:58 +0100
Subject: [LTP] [PATCH 2/5] syscalls/fanotify: Use generic checks for
 fanotify_init flags
In-Reply-To: <20201204095930.866421-3-amir73il@gmail.com>
References: <20201204095930.866421-1-amir73il@gmail.com>
 <20201204095930.866421-3-amir73il@gmail.com>
Message-ID: <X8o/7qGeKEUD31XB@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Amir,

> Convert remaining tests to SAFE_FANOTIFY_INIT and use the generic
> helpers to check requires kernel/fs support for fanotify_init flags
> in advance.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
