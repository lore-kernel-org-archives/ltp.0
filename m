From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 22 Oct 2019 10:08:31 +0200
Subject: [LTP] [PATCH v4 4/5] Add newlib shell test for
 tst_multiply_timeout()
In-Reply-To: <20191018124502.25599-5-cfamullaconrad@suse.de>
References: <20191018124502.25599-1-cfamullaconrad@suse.de>
 <20191018124502.25599-5-cfamullaconrad@suse.de>
Message-ID: <20191022080830.GA17235@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> +do_test()
> +{
> +	LTP_TIMEOUT_MUL=2
> +	local sec=1
> +
> +	call_it 'tst_multiply_timeout sec' 'sec' 2
still some issue with this patchset. Making the function private
(_tst_multiply_timeout), we obviously get warning:
test_timeout_mul 1 TWARN: Private variable or function _tst_multiply_timeout used!

Unless we want to to add some special variable for library tests
(i.e. TST_IGNORE_WARN), the function cannot be used directly

I suggest to push the patchset change to use float (not to be postponed even
more), but without this patchset. Tests should be later added.

Kind regards,
Petr

> +	sec=1
> +	LTP_TIMEOUT_MUL="1.5"
> +	call_it 'tst_multiply_timeout sec' 'sec' 2
> +
> +	sec=1
> +	LTP_TIMEOUT_MUL=0.5
> +	call_it 'tst_multiply_timeout sec' 'sec' 1
> +
> +	sec=1
> +	LTP_TIMEOUT_MUL=2
> +	call_it 'tst_multiply_timeout sec' 'sec' 2
> +	call_it 'tst_multiply_timeout sec' 'sec' 4
> +	call_it 'tst_multiply_timeout sec' 'sec' 8
> +}
> +
> +tst_run
