From: Michael Moese <mmoese@suse.de>
Date: Wed, 25 Apr 2018 09:41:16 +0200
Subject: [LTP] [RFC PATCH v3 10/10] ima: Print /proc/cmdline and IMA
 kernel config
In-Reply-To: <20180424183556.2368-1-pvorel@suse.cz>
References: <20180424183556.2368-1-pvorel@suse.cz>
Message-ID: <20180425074116.hic5a3nfunyxamcd@g206.suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi Petr,
 
On Tue, Apr 24, 2018 at 08:35:56PM +0200, Petr Vorel wrote:  
> +print_ima_config()
> +{
> +	local config="/boot/config-$(uname -r)"
Just a small remark here: not all distributions have /boot/config-* files
in place. I don't remember which ones this were.
Wouldn't it make sense to check this file, if it does not exist check
if /proc/config.gz is available? 
> +	local i
> +
> +	tst_res TINFO "/proc/cmdline: $(cat /proc/cmdline)"
> +
> +	if [ -r "$config" ]; then
> +		tst_res TINFO "IMA kernel config"
> +		for i in $(grep ^CONFIG_IMA $config); do
> +			tst_res TINFO "$i"
> +		done
> +	fi
> +}

Kind regards,
Michael

-- 
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
