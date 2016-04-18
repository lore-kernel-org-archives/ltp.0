From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 18 Apr 2016 17:44:19 +0200
Subject: [LTP] [PATCH v2] commands/insmod: add new testcase to test
	insmod(8)
In-Reply-To: <1458029005-8807-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <56A9E27E.5070102@cn.fujitsu.com>
 <1458029005-8807-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <20160418154419.GA11649@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +# Check a module file existence
> +# Should be called after tst_tmpdir()
> +tst_module_exists()
> +{
> +	local mod_name="$1"
> +
> +	if [ -f "$mod_name" ]; then
> +		TST_MODPATH="$mod_name"
> +		return
> +	fi
> +
> +	local mod_path="$LTPROOT/testcases/bin/$mod_name"
> +	if [ -f "$mod_path" ]; then
> +		TST_MODPATH="$mod_path"
> +		return
> +	fi
> +
> +	if [ -n "$TST_TMPDIR" ]; then
> +		mod_path="$TST_TMPDIR/$mod_name"
> +		if [ -f "$mod_path" ]; then
> +			TST_MODPATH="$mod_path"
> +			return
> +		fi
> +	fi

This is not what the lib/tst_module.c does. It tries test startwd which
is recorded before the test does chdir() to the newly created test
directory. Otherwise if the test calls tst_tmpdir() the module in the
directory the test was started in will not be found. So we have to
record the test start working directory in tst_tmpdir() and use it here.


Otherwise it looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
