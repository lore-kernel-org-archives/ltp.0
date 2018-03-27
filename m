From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 27 Mar 2018 15:33:30 +0200
Subject: [LTP] [PATCH] testcases: fix file path to control access to cron
In-Reply-To: <20180321023515.11356-1-dan.rue@linaro.org>
References: <20180321023515.11356-1-dan.rue@linaro.org>
Message-ID: <20180327133329.2dt6zqct2heiayp6@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> From: Lucas Magasweran <lucas.magasweran@ieee.org>

> crontab uses /etc/cron.{allow,deny} to control access on most distributions, as
> well as RHEL. To maintain backwards compatibility with older still supported
> distributions, the test setup will search the man page for the correct paths
> (e.g. /var/spool/cron/allow). If the man page is not available (e.g. on an
> embedded device), it will default to the /etc paths. This method supports
> vixie-cron, cronie, etc...

> The repeating code has been moved into a common shell script library to
> simplify maintenance.

> Reported-by: Myungho Jung <mhjungk@gmail.com>
> Signed-off-by: Lucas Magasweran <lucas.magasweran@ieee.org>
> Tested-by: Dan Rue <drue@therub.org>
> ---
<snip>
> -if [ "$tvar" = "redhat" -o "$tvar" = "redhat-linux" ]
> -then
> -CRON_ALLOW="/etc/cron.allow"
> -else
> -CRON_ALLOW="/var/spool/cron/allow"
> -fi
> +. cron_common.sh
We've decided to drop support for /var/spool/cron/{allow,deny} entirely.
Please change your patch.

If you wonder why we drop the support:
This old path used original Vixie-cron / ISC, cronie which is a fork of Vixie-cron version
4.1 used changed the path in 2007 [1], [2].
Original patch used for RHEL /etc/cron.{allow,deny} anyway, even SLE 9.3 used vixie-cron
with patched to the new path.
Debian changed the path in it's vixie-cron in 1999 [3]


Kind regards,
Petr

[1] https://github.com/cronie-crond/cronie/commit/7f6c24bc5aaddcc95556764fa3f801f2166e86b9
[2] https://github.com/cronie-crond/cronie/commit/9ff26cfe84d14af46dcf8af39fba9c25534df6f7
[3] https://anonscm.debian.org/cgit/pkg-cron/pkg-cron.git/commit/?id=546d93985f662362005109e2f069ebe15c0112aa
