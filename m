From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 20 Jul 2017 15:40:22 +0200
Subject: [LTP] [PATCH 1/2] cpuhotplug05.sh: call sar -P  $CPU_TO_TEST
In-Reply-To: <1499265258-25521-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1499265258-25521-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <20170720134022.GA11392@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	online_status=$(tail -n 1 "$LOG_FILE")
> +	check_passed=0
> +	for i in $(seq 3 8); do
> +		field_offline=$(get_field "$offline_status" "$i")
> +		field_online=$(get_field "$online_status" "$i")
> +
> +		if [ "$field_online" != "$field_offline" ]; then

Hmm, we did assert that $field_offline == 0.00 in the previous loop,
didn't we? Why don't we simply compare $field_online against "0.00"
here?

Otherwise it looks fine.

-- 
Cyril Hrubis
chrubis@suse.cz
