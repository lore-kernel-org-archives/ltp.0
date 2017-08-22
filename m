From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 22 Aug 2017 10:53:56 +0200
Subject: [LTP] [PATCH] input/input06: Ignore auto-repeat config events
In-Reply-To: <20170814233205.10933-1-sspatil@google.com>
References: <20170814233205.10933-1-sspatil@google.com>
Message-ID: <20170822085356.GA22360@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
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

I do not like much that we added a just another loop that fills in
the event array here. Maybe we should rewrite this as a recursive
descent parser now.

I.e.

	while (have_events()) {
		ev = next_event();

		switch (ev.type)
		case EV_REP:
			parse_rep(ev);
		break;
		case EV_KEY:
			parse_key(ev);
		break;
	}


The parse_rep() would check that we got correct sequence of
configuration events and the parse_key() would check that we have a
correct sequence of key press events, i.e. key down (1) a few key repeat
(2) and key up (0), which would be something as:

parse_key()
{
	if (!check_event(ev, EV_KEY, KEY_X, 1))
		tst_res(TFAIL, ...);

	ev = next_event();

	if (!check_event(ev, EV_KEY, KEY_X, 2))
		tst_res(TFAIL, ...);

	do {
		ev = next_event();
	} while (!check_event(ev, EV_KEY, KEY_X, 2);

	if (!chek_event(ev, EV_KEY, KEY_X, 0))
		tst_res(TFAIL, ...);
}

>  	if (rd > 0 && check_event(&iev[i], EV_KEY, KEY_X, 1))
>  		i++;
>  
>  	while (check_bound(i, rd) && !check_event(&iev[i], EV_KEY, KEY_X, 0)) {
>  
>  		if (iev[i].type != EV_SYN
> +			&& iev[i].type != EV_REP

What is this here for? Shouldn't all the configuration events be read at
this point?

>  			&& !check_event(&iev[i], EV_KEY, KEY_X, 2)) {
>  			tst_resm(TINFO,
>  				"Didn't receive EV_KEY KEY_X with value 2");
> -- 
> 2.14.0.434.g98096fd7a8-goog
> 

-- 
Cyril Hrubis
chrubis@suse.cz
