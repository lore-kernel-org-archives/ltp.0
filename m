From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 31 Aug 2017 14:45:47 +0200
Subject: [LTP] [PATCH v3] input/input06: Fix auto-repeat key test
In-Reply-To: <20170824201207.62652-1-sspatil@google.com>
References: <20170824201207.62652-1-sspatil@google.com>
Message-ID: <20170831124546.GA1487@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static struct input_event *next_event()
                                         ^
					 Old style definition,
					 checkpatch.pl should warn about
					 these
> +{
> +	struct input_event *ev = NULL;
                            ^
			    Why do we initialize the value here if it's
			    not used at all?

> -	rd = read(fd2, iev, sizeof(iev));
> +	if (!have_events())
> +		read_events();
>  
> -	check_size(rd);
> +	ev = &events[ev_iter++];
> +	return ev;

Why not just return &events[ev_iter++]; ?

> +}
>  
> -	if (rd > 0 && check_event(&iev[i], EV_KEY, KEY_X, 1))
> -		i++;
> +static int check_sync_event(void)
> +{
> +	return check_event_code(next_event(), EV_SYN, SYN_REPORT);
> +}
>  
> -	while (check_bound(i, rd) && !check_event(&iev[i], EV_KEY, KEY_X, 0)) {
> +static int parse_autorepeat_config(struct input_event *iev)
> +{
> +	if (!check_event_code(iev, EV_REP, REP_DELAY)) {
> +		tst_resm(TFAIL,
> +			 "Didn't get EV_REP configuration with code REP_DELAY");
> +		return 0;
> +	}
> +
> +	if (!check_event_code(next_event(), EV_REP, REP_PERIOD)) {
> +		tst_resm(TFAIL,
> +			 "Didn't get EV_REP configuration with code REP_PERIOD");
> +		return 0;
> +	}
> +
> +	return 1;
> +}
> +
> +static int parse_key(struct input_event *iev)
> +{
> +	int autorep_count = 0;
> +
> +	if (!check_event(iev, EV_KEY, KEY_X, 1) || !check_sync_event()) {
> +		tst_resm(TFAIL, "Didn't get expected key press for KEY_X");
> +		return 0;
> +	}
>  
> -		if (iev[i].type != EV_SYN
> -			&& !check_event(&iev[i], EV_KEY, KEY_X, 2)) {
> -			tst_resm(TINFO,
> -				"Didn't receive EV_KEY KEY_X with value 2");
> +	iev = next_event();
> +	while (check_event(iev, EV_KEY, KEY_X, 2) && check_sync_event()) {
> +		autorep_count++;
> +		iev = next_event();
> +	}
> +
> +	/* make sure we have atleast one auto-repeated key event */
> +	if (!autorep_count) {
> +		tst_resm(TFAIL,
> +			 "Didn't get autorepeat events for the key - KEY_X");
> +		return 0;
> +	}
> +
> +	if (!check_event(iev, EV_KEY, KEY_X, 0) || !check_sync_event()) {
> +		tst_resm(TFAIL,
> +			 "Didn't get expected key release for KEY_X");
> +		return 0;
> +	}
> +
> +	tst_resm(TINFO,
> +		 "Received %d repititions for KEY_X", autorep_count);
> +
> +	return 1;
> +}
> +
> +static int check_events(void)
> +{
> +	struct input_event *iev;
> +	int ret;
> +	int rep_config_done = 0;
> +	int rep_keys_done = 0;
> +
> +	read_events();
> +
> +	while (have_events()) {
> +		iev = next_event();
> +		switch (iev->type) {
> +		case EV_REP:
> +			ret = parse_autorepeat_config(iev);
> +			if (!rep_config_done)
                        ^
			This if is useless here.
> +				rep_config_done = 1;
> +			break;
> +		case EV_KEY:
> +			ret = parse_key(iev);
> +			if (!rep_keys_done)
                        ^
			Here as well.
> +				rep_keys_done = 1;
> +			break;
> +		default:
> +			tst_resm(TFAIL,
> +				 "Unexpected event type '0x%04x' received",
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
> +		if (!ret || (rep_config_done && rep_keys_done))
> +			break;
>  	}
>  
> -	return (nb > 0 && check_bound(i, rd)
> -		&& check_event(&iev[i], EV_KEY, KEY_X, 0));
> +	return ret;
>  }

Also I would disagree that the value for sync event is undefined, it has
been 0 since the beginning and if you look into the kernel input.h
header it has:

static inline void input_sync(struct input_dev *dev)
{
        input_event(dev, EV_SYN, SYN_REPORT, 0);
}



Apart from that it looks OK.

-- 
Cyril Hrubis
chrubis@suse.cz
