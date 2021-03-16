From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 16 Mar 2021 17:40:14 +0100
Subject: [LTP] [PATCH 2/2] syscalls/getppid02: Convert to the new API
In-Reply-To: <20210304021304.1126635-2-ruansy.fnst@fujitsu.com>
References: <20210304021304.1126635-1-ruansy.fnst@fujitsu.com>
 <20210304021304.1126635-2-ruansy.fnst@fujitsu.com>
Message-ID: <YFDfbrziEwXgxpOS@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Ruan,

> +/*\
> + * [DESCRIPTION]
>   *
> + * Check that getppid() in child returns the same pid as getpid() in parent.
> +\*/
nit: this should be merged as */ only (drop leading \, see 96e964f97 ("docparse:
Use C standard comment end").

Kind regards,
Petr
