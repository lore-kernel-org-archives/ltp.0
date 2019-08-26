From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 26 Aug 2019 13:47:43 +0200
Subject: [LTP] [PATCH v2 2/5] kernel/uevent: Add uevent01
In-Reply-To: <1566405322.3587.21.camel@suse.de>
References: <20190820151831.7418-1-chrubis@suse.cz>
 <20190820151831.7418-3-chrubis@suse.cz>
 <1566405322.3587.21.camel@suse.de>
Message-ID: <20190826114743.GB15568@haruka>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > +
> > +	dev_num = tst_find_free_loopdev(dev_path, sizeof(dev_path));
> 
> Maybe it isn't worth to check if dev_num is a valid number.

Sure.

> > +
> > +	snprintf(ev_msg, sizeof(ev_msg),
> > +	         "change@/devices/virtual/block/loop%i", dev_num);
> > +
> > +	snprintf(ev_dev_path, sizeof(ev_dev_path),
> > +	         "DEVPATH=/devices/virtual/block/loop%i", dev_num);
> > +
> > +	snprintf(ev_dev_minor, sizeof(ev_dev_minor), "MINOR=%i",
> > dev_num);
> > +	snprintf(ev_dev_name, sizeof(ev_dev_name), "DEVNAME=loop%i",
> > dev_num);
> > +
> > +	const struct uevent_desc *const uevents[] = {
> > +		&desc,
> > +		&desc,
> > +		NULL
> > +	};
> > +
> > +	pid = SAFE_FORK();
> > +	if (!pid) {
> > +		fd = open_uevent_netlink();
> > +		TST_CHECKPOINT_WAKE(0);
> > +		wait_for_uevents(fd, uevents);
> 
> For me it wasn't obvious that wait_for_uevents() does the exit(). Not
> sure if we should do the exit better here or name the function like
> exit_on_uevents().

I was just lazy, I guess that the cleanest solution would be to call the
exit here after the wait_for_uevents() call.

> > +	}
> > +
> > +	TST_CHECKPOINT_WAIT(0);
> > +
> > +	generate_device_events(dev_path);
> > +
> > +	wait_for_pid(pid);
> > +}
> > +
> > +static struct tst_test test = {
> > +	.test_all = verify_uevent,
> > +	.forks_child = 1,
> > +	.needs_tmpdir = 1,
> 
> Just curious, where do we need the tmpdir?

We are creating a disk image to be attached to the loop device in the
generate_device_events().

-- 
Cyril Hrubis
chrubis@suse.cz
