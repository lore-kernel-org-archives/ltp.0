From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 26 Oct 2015 17:08:52 +0100
Subject: [LTP] [PATCH]  commans/sar: Add new testcases for sar
In-Reply-To: <1445562528-228220-1-git-send-email-cuibixuan@huawei.com>
References: <1445562528-228220-1-git-send-email-cuibixuan@huawei.com>
Message-ID: <20151026160852.GC6772@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +TCID=sar01
> +TST_TOTAL=19
> +. test.sh
> +
> +setup()
> +{
> +	tst_check_cmds sar
> +
> +	tst_tmpdir
> +}
> +
> +cleanup()
> +{
> +	tst_rmdir
> +}
> +
> +sar_test()
> +{
> +	$1 >${TCID}.temp 2>&1

Since we call tst_tmpdir() in setup we are guaranteed to be executed in
unique temorary directory. So we can just do:

$1 >temp 2>&1

And we do not need to worry about some other test rewriting our file.

> +	if [ $? -ne 0 ]; then
> +		tst_resm TFAIL "'$1' failed."
> +		return
> +	fi
> +
> +	grep $2 ${TCID}.temp >/dev/null

Grep has -q (quiet) switch.

> +	if [ $? -eq 0 ]; then
> +		tst_resm TPASS "'$1' passed."
> +	else
> +		tst_resm TFAIL "'$1' failed."
> +	fi

Grepping one word is pretty loose criteria for pass/fail for a program
that actually prints several pages of statistics.

A few things that can be done here are:

* Number of cpus is detected correctly

* The CPU load sums to 100%


More complicated tests can also do:

* Run a program with bussy loop on a background and check that
  it consumes CPU cycles (load at least 100/NCPU over all cpus)

* Run a program that reads and writes files on background
  and check that corresponding I/O statistics are reasonable

* ...


Getting this right would require substantial amount of effort, but
as this test is now it's not much useful as it would pass even if sar
was broken really badly.

-- 
Cyril Hrubis
chrubis@suse.cz
