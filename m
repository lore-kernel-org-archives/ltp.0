From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 30 Nov 2017 15:20:56 +0100
Subject: [LTP] [PATCH] commands/unshare: Add new testcase to test
 unshare(1)
In-Reply-To: <1509615297-2798-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1509615297-2798-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20171130142056.GF2924@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	if [[ "${verify_cmd}" =~ 'id' ]]; then
> +		if [ $(cat temp) -ne ${exp_result} ]; then
> +			tst_res TFAIL "${unshare_cmd} got wrong uid/gid"
> +			return
> +		fi
> +	fi
> +
> +	if [[ "${verify_cmd}" =~ 'mount' ]]; then
> +		if [ "${exp_result}" = "unmounted" ]; then
> +			if ls test_B | grep -q 'A'; then
> +				tst_res TFAIL "${unshare_cmd} got bind info"
> +				umount test_B
> +				return
> +			fi
> +		else
> +			if ! ls test_B | grep -q 'A'; then
> +				tst_res TFAIL "${unshare_cmd} did not get bind info"
> +				return
> +			fi
> +			umount test_B
> +		fi
> +	fi

The double square operator is bash specific. The portable way who to
check for a start of a string is to use case as:

	case "$verify_cmd" in
	id*) echo starts with id;;
	mount*) echo starts with mount;;
	esac

And it may be a bit cleaner to put the checks into a separate functions
the indentation is getting out of the hand here.

> +	tst_res TPASS "${unshare_cmd} succeeded as expected"
> +}
> +
> +do_test()
> +{
> +	case $1 in
> +	1) unshare_test "--user" "id -u" "65534";;
> +	2) unshare_test "--user" "id -g" "65534";;
> +	3) unshare_test "--user --map-root-user" "id -u" "0";;
> +	4) unshare_test "--user --map-root-user" "id -g" "0";;
> +	5) unshare_test "--mount" "mount --bind test_A test_B" "unmounted";;
> +	6) unshare_test "--mount --propagation shared" \
> +			"mount --bind test_A test_B" "mounted";;
> +	7) unshare_test "--user --map-root-user --mount" \
> +			"mount --bind test_A test_B" "unmounted";;
> +	8) unshare_test "--user --map-root-user --mount --propagation shared" \
> +			"mount --bind test_A test_B" "unmounted";;
> +	esac
> +}
> +
> +tst_run
> -- 
> 1.8.3.1
> 
> 
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
