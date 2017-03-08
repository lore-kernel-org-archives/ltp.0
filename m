From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 8 Mar 2017 13:12:48 +0100
Subject: [LTP] [PATCH 1/1] cron: Rewrite and cleanup cron_tests.sh script
In-Reply-To: <20170301001146.2354-1-pvorel@suse.cz>
References: <20170301001146.2354-1-pvorel@suse.cz>
Message-ID: <20170308121248.GB30298@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +fail_test()
> +{
> +	tst_resm TFAIL "$@"
> +	TFAILCNT=$(($TFAILCNT+1))
> +}
> +
> +break_test()
> +{
> +	local file=$1
> +	local err_msg="$2"
> +	tst_brk TBROK $file NULL "$err_msg"
> +	TFAILCNT=$(($TFAILCNT+1))
> +}

Why don't we convert the testcase to the test library (ideally the new
one) instead of hacking around and adding custom failure counters?

Seriously the exit $TFAILCNT at the end of the test is broken as it will
produce bogus exit values. In a case that number of failures adds up so
that the bottom bits are cleared we may as well exit the test with
TCONF.

-- 
Cyril Hrubis
chrubis@suse.cz
