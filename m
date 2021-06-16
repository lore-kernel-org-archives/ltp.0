From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 16 Jun 2021 13:16:51 +0200
Subject: [LTP] [PATCH v3] ssh-stress: Convert to new api
In-Reply-To: <20210616081856.3026223-1-lkml@jv-coder.de>
References: <20210616081856.3026223-1-lkml@jv-coder.de>
Message-ID: <YMndo2/ts98PpdCn@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Joerg, Alexey,

> Apart from pure conversion:
>  - Use "StrictModes no" in ssh config, to get rid of
>    access permission problems; All part of the path of the
>    authorized_keys file must not be writeable by anyone but the owner.
>    This allows writing the file to the default temp directory
>  - Moved all rhost scripts into ssh-stress.sh

> Changes in v3:
> - use pkill instead of ps | awk | xargs
> - Changed test descriptions slightly
>   * include actual ip version
>   * dropped "for a long time", the tests do not run
>     for a long time with the default config
> - Use netstress -B and ssh -f for background processes
>   This implies using pgrep to get the pids of these processes.

LGTM.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
