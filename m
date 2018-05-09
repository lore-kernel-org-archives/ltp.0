From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 9 May 2018 13:31:41 +0200
Subject: [LTP] [PATCH] lib/tst_test.sh: Detect quoted parameters
	correctly
In-Reply-To: <1525863262-29703-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20180508075025.kiwhybpeticscmbh@dell5510>
 <1525863262-29703-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20180509113140.qeagydu6jyo73dfu@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> If we assign "$@" containing quoted parameters to TST_ARGS variable and pass
> the variable into getopts, only the first number from quoted parameters can be
> processed.  "$@" seems to be treated as an array by default, and declaring
> TST_ARGS as an array could fix this issue.

> You can reproduce the issue by the folliwng url:
> [1] https://lists.linux.it/pipermail/ltp/2018-May/008042.html

> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>

...
> -	while getopts "hi:$TST_OPTS" name $TST_ARGS; do
> +	while getopts "hi:$TST_OPTS" name "${TST_ARGS[@]}"; do
...

> -	TST_ARGS="$@"
> +	TST_ARGS=("$@")

Thanks for your patch.

NACK. Why: arrays are bashism :(.
IMHO this doesn't have a solution which would be POSIX compliant

I recommend testing shell related changes with checkbashisms script from Debian [1].
Also testing it on dash can reveal bashisms (change /bin/sh symlink from bash to dash as
some distros have as default).


Kind regards,
Petr

[1] https://anonscm.debian.org/cgit/collab-maint/devscripts.git/plain/scripts/checkbashisms.pl
