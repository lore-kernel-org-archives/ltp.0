From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 21 Mar 2018 16:13:42 +0100
Subject: [LTP] [PATCH] testcases: fix file path to control access to cron
In-Reply-To: <20180321023515.11356-1-dan.rue@linaro.org>
References: <20180321023515.11356-1-dan.rue@linaro.org>
Message-ID: <20180321151342.i7iog53deduyo53f@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Dan,

thanks for your patch.
Cron scripts would deserver rewriting to use new shell API (+ cleanup).

> From: Lucas Magasweran <lucas.magasweran@ieee.org>

> crontab uses /etc/cron.{allow,deny} to control access on most distributions, as
> well as RHEL. To maintain backwards compatibility with older still supported
> distributions, the test setup will search the man page for the correct paths
> (e.g. /var/spool/cron/allow). If the man page is not available (e.g. on an
Do you know which distros and cron versions are really affected?
Is it RHEL 4? SLES 10 SP4 uses vixie cron 4.1 with files in /etc.
I wonder if we need still to support old path.

> embedded device), it will default to the /etc paths. This method supports
> vixie-cron, cronie, etc...
BTW (looking at busybox source) busybox crond does not support allow/deny, but that's
another issue.

> The repeating code has been moved into a common shell script library to
> simplify maintenance.

> Reported-by: Myungho Jung <mhjungk@gmail.com>
> Signed-off-by: Lucas Magasweran <lucas.magasweran@ieee.org>
> Tested-by: Dan Rue <drue@therub.org>
> ---
>  testcases/commands/cron/cron_allow01      | 12 +-----------
>  testcases/commands/cron/cron_common.sh    | 15 +++++++++++++++
>  testcases/commands/cron/cron_deny01       | 14 +-------------
>  testcases/commands/cron/cron_neg_tests.sh |  2 +-
>  testcases/commands/cron/cron_pos_tests.sh | 13 +------------
>  5 files changed, 19 insertions(+), 37 deletions(-)
>  create mode 100755 testcases/commands/cron/cron_common.sh

> diff --git a/testcases/commands/cron/cron_allow01 b/testcases/commands/cron/cron_allow01
> index 9a5e4d2406..7e05f7b7dd 100755
> --- a/testcases/commands/cron/cron_allow01
> +++ b/testcases/commands/cron/cron_allow01
> @@ -26,17 +26,7 @@

>  echo "This script contains bashism that needs to be fixed!"

> -iam=`whoami`
> -
> -tvar=${MACHTYPE%-*}
> -tvar=${tvar#*-}

> -
> -if [ "$tvar" = "redhat" -o "$tvar" = "redhat-linux" ]
> -then
> -CRON_ALLOW="/etc/cron.allow"
> -else
> -CRON_ALLOW="/var/spool/cron/allow"
> -fi
> +. cron_common.sh

>  TEST_USER1="ca_user1"
>  TEST_USER1_HOME="/home/$TEST_USER1"
> diff --git a/testcases/commands/cron/cron_common.sh b/testcases/commands/cron/cron_common.sh
> new file mode 100755
> index 0000000000..5ed90c4039
> --- /dev/null
> +++ b/testcases/commands/cron/cron_common.sh
> @@ -0,0 +1,15 @@
> +#!/bin/sh
> +
> +iam=`whoami`
> +
> +tvar=${MACHTYPE%-*}
> +tvar=${tvar#*-}
Can you please removed tvar? It's not needed any more and MACHTYPE is a bashism.
This will remove most of bashisms (the only left will be function keyword in
cron_pos_tests.sh).
> +
> +setup_path() {
> +	# Support paths used by older distributions of RHEL or SLES.
> +	export CRON_DENY="$(man crontab 2>/dev/null | grep -m 1 -o '/[\/a-z.]*deny$' || echo "/etc/cron.deny")"
> +	export CRON_ALLOW="$(man crontab 2>/dev/null | grep -m 1 -o '/[\/a-z.]*allow$' || echo "/etc/cron.allow")"
This has wrong quotation marks (although it's working. Better would be:
export CRON_DENY="$(man crontab 2>/dev/null | grep -m 1 -o '/[\/a-z.]*deny$' || echo '/etc/cron.deny')"
export CRON_ALLOW="$(man crontab 2>/dev/null | grep -m 1 -o '/[\/a-z.]*allow$' || echo '/etc/cron.allow')"

> +}
> +
> +setup_path
> +
> diff --git a/testcases/commands/cron/cron_deny01 b/testcases/commands/cron/cron_deny01
> index 9d32039251..263a7829b5 100755
> --- a/testcases/commands/cron/cron_deny01
> +++ b/testcases/commands/cron/cron_deny01
> @@ -26,19 +26,7 @@

>  echo "This script contains bashism that needs to be fixed!"

> -iam=`whoami`
> -
> -tvar=${MACHTYPE%-*}
> -tvar=${tvar#*-}
> -
> -if [ "$tvar" = "redhat" -o "$tvar" = "redhat-linux" ]
> -then
> -CRON_DENY="/etc/cron.deny"
> -CRON_ALLOW="/etc/cron.allow"
> -else
> -CRON_DENY="/var/spool/cron/deny"
> -CRON_ALLOW="/var/spool/cron/allow"
> -fi
> +. cron_common.sh

>  TEST_USER1="cd_user1"
>  TEST_USER1_HOME="/home/$TEST_USER1"
> diff --git a/testcases/commands/cron/cron_neg_tests.sh b/testcases/commands/cron/cron_neg_tests.sh
> index 9c3d6f6c7c..49c5c4e5d0 100755
> --- a/testcases/commands/cron/cron_neg_tests.sh
> +++ b/testcases/commands/cron/cron_neg_tests.sh
> @@ -9,7 +9,7 @@
>  #    12/03/04  Marty Ridgeway Pull RHEl4 tests out from script


> -iam=`whoami`
> +. cron_common.sh

>  if [ $iam = "root" ]; then
>  	if [ $# -lt 1 ] ; then
> diff --git a/testcases/commands/cron/cron_pos_tests.sh b/testcases/commands/cron/cron_pos_tests.sh
> index ece114c84c..a0ddaea57b 100755
> --- a/testcases/commands/cron/cron_pos_tests.sh
> +++ b/testcases/commands/cron/cron_pos_tests.sh
> @@ -2,18 +2,7 @@

>  # Positive tests for cron, that means these tests have to pass

> -iam=`whoami`
> -
> -tvar=${MACHTYPE%-*}
> -tvar=${tvar#*-}
> -
> -if [ "$tvar" = "redhat" -o "$tvar" = "redhat-linux" ]
> -then
> -	CRON_ALLOW="/etc/cron.allow"
> -else
> -	CRON_ALLOW="/var/spool/cron/allow"
> -fi
> -
> +. cron_common.sh

>  if [ $iam = "root" ]; then
>  	if [ $# -lt 1 ] ; then


Kind regards,
Petr
