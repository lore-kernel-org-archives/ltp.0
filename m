From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 5 Mar 2020 14:08:48 +0100
Subject: [LTP] [PATCH v4 3/3] lsmod01: Add kernel module
In-Reply-To: <20191210080419.128773-4-lkml@jv-coder.de>
References: <20191210080419.128773-1-lkml@jv-coder.de>
 <20191210080419.128773-4-lkml@jv-coder.de>
Message-ID: <20200305130848.GA24788@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Joerg,

patchset merged, with tiny style changes.
Sorry for the delay with reviewing it.

...
> +module_inserted=0
We prefer in the shell library empty over 0.

> +
> +setup()
> +{
> +	if [ -z "$(cat /proc/modules)"  ]; then
> +		tst_res TINFO "Loading dummy kernel module"
> +		tst_require_module "ltp_lsmod01.ko"
> +		tst_require_root
> +		tst_require_cmds insmod
> +		insmod "$TST_MODPATH"
> +		if [ $? -ne 0 ]; then
> +			tst_res TBROK "insmod failed"
> +			return
> +		fi
> +
> +		module_inserted=1
> +	fi
> +}
> +
> +cleanup()
> +{
> +	if [ $module_inserted -ne 0 ]; then
> +		tst_res TINFO "Unloading dummy kernel module"
> +		rmmod ltp_lsmod01
> +		if [ $? -ne 0 ]; then
> +			tst_res TWARN "rmmod failed"
> +		fi
> +		module_inserted=0
This is not needed, thus omitted.

Kind regards,
Petr
