From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 23 Aug 2017 12:49:29 +0200
Subject: [LTP] [PATCH v2] input/input06: Ignore auto-repeat config events
In-Reply-To: <20170822220817.14088-1-sspatil@google.com>
References: <20170822220817.14088-1-sspatil@google.com>
Message-ID: <20170823104928.GA19747@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> The test currently fails on some android devices because the kernel
> sends the EV_REP event with the codes REP_DELAY and REP_PERIOD and
> their corresponding values for the uinput device the test creates.

Minor note, the patch has coding style violations, we do follow LKML
coding style in LTP. You can use checkpatch.pl (from kernel source tree)
to check for these.

> Signed-off-by: Sandeep Patil <sspatil@google.com>
> ---
>  testcases/kernel/input/input06.c | 118 ++++++++++++++++++++++++++++++---------
>  1 file changed, 91 insertions(+), 27 deletions(-)
> 
> diff --git a/testcases/kernel/input/input06.c b/testcases/kernel/input/input06.c
> index c4fc1ef57..962546ead 100644
> --- a/testcases/kernel/input/input06.c
> +++ b/testcases/kernel/input/input06.c
> @@ -37,6 +37,9 @@ static void cleanup(void);
>  
>  static int fd;
>  static int fd2;
> +struct input_event events[64];
> +static int num_events;
> +static int ev_iter;
>  
>  char *TCID = "input06";
>  
> @@ -107,9 +110,9 @@ static int check_event(struct input_event *iev, int event, int code, int value)
>  	return iev->type == event && iev->code == code && iev->value == value;
>  }
>  
> -static int check_bound(unsigned int i, unsigned int rd)
> +static int check_config_event(struct input_event *iev, int event, int code)
>  {
> -	return i <= rd / sizeof(struct input_event);
> +	return iev->type == event && iev->code == code;
>  }
>  
>  static void check_size(int rd)
> @@ -123,43 +126,104 @@ static void check_size(int rd)
>  	}
>  }
>  
> -static int check_events(void)
> +static void read_events(void)
>  {
> -	struct input_event iev[64];
> -	unsigned int i;
> -	int nb;
> -	int rd;
> +	int rd = read(fd2, events, sizeof(events));
>  
> -	i = 0;
> -	nb = 0;
> +	check_size(rd);

The check_size() seems to be called only from this place now, hence
there is no need to keep these two if conditions in a separate function
anymore.

> -	rd = read(fd2, iev, sizeof(iev));
> +	ev_iter = 0;
> +	num_events = rd / sizeof(struct input_event);
> +}
>  
> -	check_size(rd);
> +static int have_events(void)
> +{
> +	return num_events !=0 && ev_iter < num_events;
> +}
>  
> -	if (rd > 0 && check_event(&iev[i], EV_KEY, KEY_X, 1))
> -		i++;
> +static struct input_event *next_event()
> +{
> +	struct input_event *ev = NULL;
>  
> -	while (check_bound(i, rd) && !check_event(&iev[i], EV_KEY, KEY_X, 0)) {
> +	if (!have_events()) {
> +		read_events();
> +	}
>  
> -		if (iev[i].type != EV_SYN
> -			&& !check_event(&iev[i], EV_KEY, KEY_X, 2)) {
> -			tst_resm(TINFO,
> -				"Didn't receive EV_KEY KEY_X with value 2");
> +	ev = &events[ev_iter++];
> +
> +	return ev;
> +}
> +
> +static int check_sync_event(void) {
> +	return check_event(next_event(), EV_SYN, 0, 0);
> +}
> +
> +static int parse_autorepeat_config(struct input_event *iev)
> +{
> +	if (!check_config_event(iev, EV_REP, REP_DELAY)) {
> +		tst_resm(TFAIL,
> +			"Didn't get EV_REP configuration with code REP_DELAY");
> +		return 0;
> +	}
> +
> +	if (!check_config_event(next_event(), EV_REP, REP_PERIOD)) {
> +		tst_resm(TFAIL,
> +			"Didn't get EV_REP configuration with code REP_PERIOD");
> +		return 0;
> +	}
> +
> +	return 1;
> +}
> +
> +static int parse_key(struct input_event *iev)
> +{
> +	if (!check_event(iev, EV_KEY, KEY_X, 1) || !check_sync_event()) {
> +		tst_resm(TFAIL, "Didn't get expected key press for KEY_X");
> +		return 0;
> +	}
> +
> +	iev = next_event();
> +	while (check_event(iev, EV_KEY, KEY_X, 2))
> +		iev = next_event();

I guess that we should check here that we got at least one autorepeat,
since as it is the test would pass even for just key_down + key_up
events.

> +	if (!check_event(iev, EV_KEY, KEY_X, 0) || !check_sync_event()) {
> +		tst_resm(TFAIL,
> +			"Didn't get expected key release for KEY_X");
> +		return 0;
> +	}
> +
> +	return 1;
> +}
> +
> +static int check_events(void)
> +{
> +	struct input_event *iev;
> +	int ret;
> +
> +	read_events();
> +
> +	while (have_events()) {
> +		iev = next_event();
> +		switch (iev->type) {
> +		case EV_REP:
> +			ret = parse_autorepeat_config(iev);
> +			break;
> +		case EV_KEY:
> +			ret = parse_key(iev);
> +			break;

Here as well, we should make sure that we got here once before we exit
the function.

So we should add a counter here and check that it's value == 1 before
we exit this function.

> +		default:
> +			tst_resm(TFAIL,
> +				"Unexpected event type '0x%04x' received",
> +				iev->type);
> +			ret = 0;
>  			break;
>  		}
> -		i++;
> -		nb++;
>  
> -		if (i == rd / sizeof(struct input_event)) {
> -			i = 0;
> -			rd = read(fd2, iev, sizeof(iev));
> -			check_size(rd);
> -		}
> +		if (!ret)
> +			break;
>  	}
>  
> -	return (nb > 0 && check_bound(i, rd)
> -		&& check_event(&iev[i], EV_KEY, KEY_X, 0));
> +	return ret;
>  }
>  
>  static void cleanup(void)
> -- 
> 2.14.1.480.gb18f417b89-goog
> 

-- 
Cyril Hrubis
chrubis@suse.cz
