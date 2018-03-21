From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 21 Mar 2018 17:31:31 +0100
Subject: [LTP] [PATCH] testcases: fix file path to control access to cron
In-Reply-To: <20180321023515.11356-1-dan.rue@linaro.org>
References: <20180321023515.11356-1-dan.rue@linaro.org>
Message-ID: <20180321163130.GA17287@ai>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
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
> +
> +setup_path() {
> +	# Support paths used by older distributions of RHEL or SLES.
> +	export CRON_DENY="$(man crontab 2>/dev/null | grep -m 1 -o '/[\/a-z.]*deny$' || echo "/etc/cron.deny")"
> +	export CRON_ALLOW="$(man crontab 2>/dev/null | grep -m 1 -o '/[\/a-z.]*allow$' || echo "/etc/cron.allow")"
> +}

FYI I do have three crontab manual pages installed on my system, two by
the cron package and one by man-pages-posix package. The 'man 1 crontab'
seems to be the one we want to parse though, it will be picked by
default since the predefined order starts with the section 1, but we may
as well specify it explicitly.

Also I will check my collection of virtual machines, with a bit of luck
all of the SLES versions that used /var/spool/cron/ are out of support
now.

-- 
chrubis@suse.cz
