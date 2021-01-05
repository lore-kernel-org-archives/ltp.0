From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 5 Jan 2021 12:47:33 +0100
Subject: [LTP] [PATCH] lsmod01.sh: Fix failure when CONFIG_MODULE_UNLOAD
 is not set
In-Reply-To: <20201221115111.31982-1-radoslav.kolev@suse.com>
References: <20201221115111.31982-1-radoslav.kolev@suse.com>
Message-ID: <X/RR1SenUB+8sZTv@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Radoslav,

> If CONFIG_MODULE_UNLOAD is not set lsmod shows '-2' (-ENOENT) for
> the used by column, but /proc/modules has only '-' there.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Merged, thanks!

Kind regards,
Petr
