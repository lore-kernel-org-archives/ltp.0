From: Sandeep Patil <sspatil@google.com>
Date: Mon, 21 Aug 2017 12:59:43 -0700
Subject: [LTP] [PATCH] input/input06: Ignore auto-repeat config events
In-Reply-To: <20170814233205.10933-1-sspatil@google.com>
References: <20170814233205.10933-1-sspatil@google.com>
Message-ID: <20170821195943.GF84377@sspatil-desktop.mtv.corp.google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

(bumping up the thread)

On Mon, Aug 14, 2017 at 04:32:05PM -0700, Sandeep Patil wrote:
> The test currently fails on some android devices because the kernel
> sends the EV_REP event with the codes REP_DELAY and REP_PERIOD and
> their corresponding values for the uinput device the test creates.
> 
> This results in incorrect test failure as follows:
> 
>  input06     0  TINFO  :  Didn't receive EV_KEY KEY_X with value 2
>  input06     1  TFAIL  :  external/ltp/testcases/kernel/input/input06.c:64: Wrong data received in
>                          eventX
> 
> Signed-off-by: Sandeep Patil <sspatil@google.com>
> ---
>  testcases/kernel/input/input06.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/testcases/kernel/input/input06.c b/testcases/kernel/input/input06.c
> index c4fc1ef57..8d04db8c6 100644
> --- a/testcases/kernel/input/input06.c
> +++ b/testcases/kernel/input/input06.c
> @@ -137,12 +137,26 @@ static int check_events(void)
>  
>  	check_size(rd);
>  
> +	/*
> +	 * Ignore auto-repeat configuration codes
> +	 * (EV_REP, {REP_PERIOD, REP_TYPE), value)
> +	 */
> +	while (iev[i].type == EV_REP) {
> +		i++;
> +		if (i == rd / sizeof(struct input_event)) {
> +			i = 0;
> +			rd = read(fd2, iev, sizeof(iev));
> +			check_size(rd);
> +		}
> +	}
> +
>  	if (rd > 0 && check_event(&iev[i], EV_KEY, KEY_X, 1))
>  		i++;
>  
>  	while (check_bound(i, rd) && !check_event(&iev[i], EV_KEY, KEY_X, 0)) {
>  
>  		if (iev[i].type != EV_SYN
> +			&& iev[i].type != EV_REP
>  			&& !check_event(&iev[i], EV_KEY, KEY_X, 2)) {
>  			tst_resm(TINFO,
>  				"Didn't receive EV_KEY KEY_X with value 2");
> -- 
> 2.14.0.434.g98096fd7a8-goog
> 
