From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 27 Mar 2017 15:42:32 +0200
Subject: [LTP] [PATCH] commands/keyctl01: Add new regression test
In-Reply-To: <1489576439-15122-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <1489576439-15122-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <20170327134232.GA21272@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	ORIG_KEYSZ=`grep -w "0:" $PATH_KEYSTAT | awk '{print $5}' | \
> +		cut -d '/' -f1`

This looks too complicated for what it does, we can probably simplify
this by something as:

awk -F' +|/' '/0:/ {print $9}' /proc/key-users
      ^        ^     ^
      |        |     This prints last number in the line
      |        This matches lines that contain 0:
      This sets field separator to any sequence of spaces or single /


> +	ORIG_MAXKEYSZ=`cat $PATH_KEYQUOTA`
> +}
> +
> +cleanup()
> +{
> +	if [ -n "$ORIG_MAXKEYSZ" ]; then
> +		echo $ORIG_MAXKEYSZ >$PATH_KEYQUOTA
> +	fi
> +}
> +
> +do_test()
> +{
> +	local maxkeysz=$((ORIG_KEYSZ + 100))
> +
> +	while true
> +	do
> +		echo $maxkeysz >$PATH_KEYQUOTA
> +
> +		keyctl request2 user debug:fred negate @t >temp 2>&1
> +		grep -q -E "quota exceeded" temp
> +		if [ $? -eq 0 ]; then
> +			break
> +		fi
> +
> +		local key=`keyctl show | grep -w "debug:fred" | \
> +			awk '{print $1}'`

Here as well, simple awk '/debug:fred/ {print $1}' should do.

> +		if [ -n "$key" ]; then
> +			keyctl unlink $key @s >/dev/null
> +			tst_sleep 100ms

Is this sleep here necessary? For how much time the test takes?

> +		fi
> +
> +		((maxkeysz -= 4))
> +	done
> +
> +	tst_res TPASS "Bug not reproduced"
> +}
> +
> +tst_run
> -- 
> 1.8.4.2
> 
> 
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
