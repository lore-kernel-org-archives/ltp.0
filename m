From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 12 Nov 2019 13:37:44 +0100
Subject: [LTP] [PATCH] acct02: relax ac_btime checks
In-Reply-To: <95d94fede00533a07fc604de3252636b094fc8f8.1573550061.git.jstancek@redhat.com>
References: <95d94fede00533a07fc604de3252636b094fc8f8.1573550061.git.jstancek@redhat.com>
Message-ID: <20191112123744.GA760@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jan,

> ac_btime is calculated back from current time and isn't accurate.
> Problems include nanoseconds accumulation (lags behind gettimeofday),
> suspend/resume isn't taken into account and any adjtime() (like DST
> change) will cause ac_btime to jump as well.

> Relax the condition to ~2h around gettimeofday value at start of
> the test. That should be enough to cover usual DST time jumps.

> Signed-off-by: Jan Stancek <jstancek@redhat.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Tested-by: Petr Vorel <pvorel@suse.cz>
on both 390x and intel.

LGTM, although on in intel I got quite a lot of entries:

acct02.c:202: INFO: Number of accounting file entries tested: 159

> ---
>  testcases/kernel/syscalls/acct/acct02.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)

> diff --git a/testcases/kernel/syscalls/acct/acct02.c b/testcases/kernel/syscalls/acct/acct02.c
> index 890568b08774..2f1290fa287f 100644
> --- a/testcases/kernel/syscalls/acct/acct02.c
> +++ b/testcases/kernel/syscalls/acct/acct02.c
> @@ -74,7 +74,8 @@ static int verify_acct(void *acc, int elap_time)
>  {
>  	int sys_time  = UNPACK(ACCT_MEMBER(ac_stime));
>  	int user_time = UNPACK(ACCT_MEMBER(ac_stime));
> -	int ret = 0, tmp;
> +	unsigned int btime_diff;
> +	int ret = 0;
>  	float tmp2;
We could rename tmp2 to tmp (but understand if you don't want to bother
with it).

>  	if (strcmp(ACCT_MEMBER(ac_comm), COMMAND)) {
> @@ -83,15 +84,13 @@ static int verify_acct(void *acc, int elap_time)
>  		ret = 1;
>  	}

> -	if (ACCT_MEMBER(ac_btime) < start_time) {
> -		tst_res(TINFO, "ac_btime < %d (%d)", start_time,
> -			ACCT_MEMBER(ac_btime));
> -		ret = 1;
> -	}
> +	if (start_time > ACCT_MEMBER(ac_btime))
> +		btime_diff = start_time - ACCT_MEMBER(ac_btime);
> +	else
> +		btime_diff = ACCT_MEMBER(ac_btime) - start_time;

> -	tmp = ACCT_MEMBER(ac_btime) - start_time;
> -	if (tmp > 1) {
> -		tst_res(TINFO, "ac_btime - %d > 1 (%d)", start_time, tmp);
> +	if (btime_diff > 7200) {
IMHO It's probably obvious that it's time in seconds without digging in git, so
we don't have to bother with a constant definition.

> +		tst_res(TINFO, "ac_btime_diff %u", btime_diff);
>  		ret = 1;
>  	}

Kind regards,
Petr
