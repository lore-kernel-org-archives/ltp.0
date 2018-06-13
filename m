From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 13 Jun 2018 12:49:34 +0200
Subject: [LTP] [RFC PATCH 2/9] tst_safe_sysv_ipc: SAFE_{SHMCTL,
 MSGCTL} return retval
In-Reply-To: <20180612154631.435-3-chrubis@suse.cz>
References: <20180612154631.435-1-chrubis@suse.cz>
 <20180612154631.435-3-chrubis@suse.cz>
Message-ID: <20180613104934.vos6o6ty56lpydql@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> These calls do return index into kernel internal array or IPC id for
> Linux specific cmds, hence we need to propagate the return value.

> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
> ---


Kind regards,
Petr
