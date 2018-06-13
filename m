From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 13 Jun 2018 12:32:12 +0200
Subject: [LTP] [RFC PATCH 1/9] tst_safe_sysv_ipc: Make safe_shmctl() and
 safe_msgctl() safer
In-Reply-To: <20180612154631.435-2-chrubis@suse.cz>
References: <20180612154631.435-1-chrubis@suse.cz>
 <20180612154631.435-2-chrubis@suse.cz>
Message-ID: <20180613103212.yc25ctzap3qvtpeh@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> We recently had a regression in Sys V IPC when IPC_STAT returned
> non-zero integer on success wrongly, which wasn't caught by LTP test but
> breaks software in the wild.

> This commit changes safe_shmctl() and safe_msgctl() to check the return
> value with != 0 for IPC_STAT, IPC_SET and IPC_RMID and with == -1
> otherwise.
LGTM. I'm surprised this is the first time, I'd expect it for more syscalls.

> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
> ---


Kind regards,
Petr
