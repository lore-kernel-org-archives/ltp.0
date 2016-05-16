From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 16 May 2016 16:05:25 +0200
Subject: [LTP] [PATCH 2/2] commands/passwd: Added new testcase to test
 passwd
In-Reply-To: <1462875541-7474-2-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1462875541-7474-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1462875541-7474-2-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20160516140525.GB6959@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +passwd_test()
> +{
> +	local opt=`echo "$2" | awk -F ' ' '{print $1}'`
> +	local value=`echo "$2" | awk -F ' ' '{print $2}'`

This is ugly, why don't you just pass the option and value separately?

I.e.

...
passwd_test "passwd" "-n" "1" "ltp_test"
...
passwd_test "passwd" "-d" "" "ltp_test"

> +	local name=$3
> +	local pw_cmd="$1 $2 $3"
> +
> +	eval $pw_cmd > temp 2>&1
> +	if [ $? -ne 0 ]; then
> +		grep -q -E "unrecognized option|invalid option|unknown option" temp
> +		if [ $? -eq 0 ]; then
> +			tst_resm TCONF "$pw_cmd not supported"
> +		else
> +			tst_resm TFAIL "$pw_cmd failed"
> +		fi
> +		return
> +	fi
> +
> +	if [ "$name" != "" ]; then
> +		local pw=`grep "$name" /etc/shadow | awk -F ':' '{print $2}'`
> +		local mod=`grep "$name" /etc/shadow | awk -F ':' '{print $3}'`
> +		local min=`grep "$name" /etc/shadow | awk -F ':' '{print $4}'`
> +		local max=`grep "$name" /etc/shadow | awk -F ':' '{print $5}'`
> +		local war=`grep "$name" /etc/shadow | awk -F ':' '{print $6}'`
> +		local ina=`grep "$name" /etc/shadow | awk -F ':' '{print $7}'`
> +	fi

Hmm, I do not think that parsing /etc/shadow here is a good idea. As
this only asserts that the configuration file was changed rather than
testing if the system does what it should do.

For instance we should rather check that we can login without password
after password was deleted with -d.

We should check that password we cannot login at all if account was
locked, etc.

> +	case $opt in
> +		-d|--delete)
> +			if [ "$pw" != "" ]; then
> +				tst_resm TFAIL "passwd failed with $opt option."
> +				return
> +			fi
> +			;;
> +		-l|--lock)
> +			echo "$pw" | grep -q "!!" > temp 2>&1
> +			if [ $? -ne 0 ]; then
> +				tst_resm TFAIL "passwd failed with $opt option."
> +				return
> +			fi
> +			;;
> +		-u|--unlock)
> +			echo "$pw" | grep -q "!!" > temp 2>&1
> +			if [ $? -eq 0 ]; then
> +				tst_resm TFAIL "passwd failed with $opt option."
> +				return
> +			fi
> +			;;
> +		-n|--minimum)
> +			if [ $min -ne $value ]; then
> +				tst_resm TFAIL "passwd failed with $opt option."
> +				return
> +			fi
> +			;;
> +		-x|--maximum)
> +			if [ $max -ne $value ]; then
> +				tst_resm TFAIL "passwd failed with $opt option."
> +				return
> +			fi
> +			;;
> +		-w|--warning)
> +			if [ $war -ne $value ]; then
> +				tst_resm TFAIL "passwd failed with $opt option."
> +				return
> +			fi
> +			;;
> +		-i|--inactive)
> +			if [ $ina -ne $value ]; then
> +				tst_resm TFAIL "passwd failed with $opt option."
> +				return
> +			fi
> +			;;
> +		-e|--expire)
> +			if [ $mod -ne 0 ]; then
> +				tst_resm TFAIL "passwd failed with $opt option."
> +				return
> +			fi
> +			;;
> +	esac

This is ugly, why don't we rather write a function for each check and
pass it as a parameter to the passwd_test.

i.e.

check_passwordless()
{
	...
}

passwd_test "passwd" "-d" "" ltp_test check_passwordless

and call it from the passwd_test as:

...
	local check="$4"

...

	if [ -n "$check" ]; then
		$check
	else
		tst_resm TPASS "passwd passed with $opt option."
	fi
}

-- 
Cyril Hrubis
chrubis@suse.cz
