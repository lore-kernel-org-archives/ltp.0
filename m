From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 29 Jan 2021 15:37:19 +0100
Subject: [LTP] [PATCH] quota_remount_test01: update to new API
In-Reply-To: <20210128171052.6025-1-kory.maincent@bootlin.com>
References: <20210128171052.6025-1-kory.maincent@bootlin.com>
Message-ID: <YBQdn3S9sPJT/wea@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li, Jan,

> +	# some distros (CentOS 6.x, for example) doesn't permit creating
> +	# of quota files in a directory with SELinux file_t type
Could you please check if this is still relevant?
If yes, would be enough to detect this case with tst_selinux_enabled
(from tst_security.sh)? I.e. considering only SELinux in enforce mode
(detecting with /sys/fs/selinux/enforce or /selinux/enforce).

> +	if [ -x /usr/sbin/selinuxenabled ] && /usr/sbin/selinuxenabled; then
> +		chcon -t tmp_t $MNTDIR || tst_brk TFAIL "Could not change SELinux file type"
> +		tst_res TINFO "Successfully changed SELinux file type"
> +	fi

Kind regards,
Petr
