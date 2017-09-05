From: Sandeep Patil <sspatil@google.com>
Date: Tue, 5 Sep 2017 14:43:44 -0700
Subject: [LTP] [PATCH v3] input/input06: Fix auto-repeat key test
In-Reply-To: <20170831124546.GA1487@rei>
References: <20170824201207.62652-1-sspatil@google.com>
 <20170831124546.GA1487@rei>
Message-ID: <20170905214344.GR84377@sspatil-desktop.mtv.corp.google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Aug 31, 2017 at 02:45:47PM +0200, Cyril Hrubis wrote:
> Hi!
> > +static struct input_event *next_event()
>                                          ^
> 					 Old style definition,
> 					 checkpatch.pl should warn about
> 					 these

It didn't but my checkpatch.pl may have been slightly older. Will fix it
anyway.

> > +{
> > +	struct input_event *ev = NULL;
>                             ^
> 			    Why do we initialize the value here if it's
> 			    not used at all?

Agree, will fix.

> 
> > -	rd = read(fd2, iev, sizeof(iev));
> > +	if (!have_events())
> > +		read_events();
> >  
> > -	check_size(rd);
> > +	ev = &events[ev_iter++];
> > +	return ev;
> 
> Why not just return &events[ev_iter++]; ?

Wonder why I did that, but sure, will fix.

> 
> > +}
> >  
> > -	if (rd > 0 && check_event(&iev[i], EV_KEY, KEY_X, 1))
> > -		i++;
> > +static int check_sync_event(void)
> > +{
> > +	return check_event_code(next_event(), EV_SYN, SYN_REPORT);
> > +}
> >  
> > -	while (check_bound(i, rd) && !check_event(&iev[i], EV_KEY, KEY_X, 0)) {
> > +static int parse_autorepeat_config(struct input_event *iev)
> > +{
> > +	if (!check_event_code(iev, EV_REP, REP_DELAY)) {
> > +		tst_resm(TFAIL,
> > +			 "Didn't get EV_REP configuration with code REP_DELAY");
> > +		return 0;
> > +	}
> > +
> > +	if (!check_event_code(next_event(), EV_REP, REP_PERIOD)) {
> > +		tst_resm(TFAIL,
> > +			 "Didn't get EV_REP configuration with code REP_PERIOD");
> > +		return 0;
> > +	}
> > +
> > +	return 1;
> > +}
> > +
> > +static int parse_key(struct input_event *iev)
> > +{
> > +	int autorep_count = 0;
> > +
> > +	if (!check_event(iev, EV_KEY, KEY_X, 1) || !check_sync_event()) {
> > +		tst_resm(TFAIL, "Didn't get expected key press for KEY_X");
> > +		return 0;
> > +	}
> >  
> > -		if (iev[i].type != EV_SYN
> > -			&& !check_event(&iev[i], EV_KEY, KEY_X, 2)) {
> > -			tst_resm(TINFO,
> > -				"Didn't receive EV_KEY KEY_X with value 2");
> > +	iev = next_event();
> > +	while (check_event(iev, EV_KEY, KEY_X, 2) && check_sync_event()) {
> > +		autorep_count++;
> > +		iev = next_event();
> > +	}
> > +
> > +	/* make sure we have atleast one auto-repeated key event */
> > +	if (!autorep_count) {
> > +		tst_resm(TFAIL,
> > +			 "Didn't get autorepeat events for the key - KEY_X");
> > +		return 0;
> > +	}
> > +
> > +	if (!check_event(iev, EV_KEY, KEY_X, 0) || !check_sync_event()) {
> > +		tst_resm(TFAIL,
> > +			 "Didn't get expected key release for KEY_X");
> > +		return 0;
> > +	}
> > +
> > +	tst_resm(TINFO,
> > +		 "Received %d repititions for KEY_X", autorep_count);
> > +
> > +	return 1;
> > +}
> > +
> > +static int check_events(void)
> > +{
> > +	struct input_event *iev;
> > +	int ret;
> > +	int rep_config_done = 0;
> > +	int rep_keys_done = 0;
> > +
> > +	read_events();
> > +
> > +	while (have_events()) {
> > +		iev = next_event();
> > +		switch (iev->type) {
> > +		case EV_REP:
> > +			ret = parse_autorepeat_config(iev);
> > +			if (!rep_config_done)
>                         ^
> 			This if is useless here.
> > +				rep_config_done = 1;
> > +			break;
> > +		case EV_KEY:
> > +			ret = parse_key(iev);
> > +			if (!rep_keys_done)
>                         ^
> 			Here as well.

ack.

> > +				rep_keys_done = 1;
> > +			break;
> > +		default:
> > +			tst_resm(TFAIL,
> > +				 "Unexpected event type '0x%04x' received",
> > +				iev->type);
> > +			ret = 0;
> >  			break;
> >  		}
> > -		i++;
> > -		nb++;
> >  
> > -		if (i == rd / sizeof(struct input_event)) {
> > -			i = 0;
> > -			rd = read(fd2, iev, sizeof(iev));
> > -			check_size(rd);
> > -		}
> > +		if (!ret || (rep_config_done && rep_keys_done))
> > +			break;
> >  	}
> >  
> > -	return (nb > 0 && check_bound(i, rd)
> > -		&& check_event(&iev[i], EV_KEY, KEY_X, 0));
> > +	return ret;
> >  }
> 
> Also I would disagree that the value for sync event is undefined, it has
> been 0 since the beginning and if you look into the kernel input.h
> header it has:


I thought that too but then I saw a test incorrectly failing due to value
check for '0'. So, I went by the documentation ...

From: https://www.kernel.org/doc/Documentation/input/event-codes.txt
"
Event codes:
===========
Event codes define the precise type of event.

EV_SYN:
----------
EV_SYN event values are undefined. Their usage is defined only by when they are
sent in the evdev event stream.

* SYN_REPORT:
  - Used to synchronize and separate events into packets of input data changes
    occurring at the same moment in time. For example, motion of a mouse may set
    the REL_X and REL_Y values for one motion, then emit a SYN_REPORT. The next
    motion will emit more REL_X and REL_Y values and send anot
....
"


> 
> static inline void input_sync(struct input_dev *dev)
> {
>         input_event(dev, EV_SYN, SYN_REPORT, 0);
> }
> 
> 
> 
> Apart from that it looks OK.

ack, will re-spin a v4 with your comments addressed.

- ssp
