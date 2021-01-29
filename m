From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 29 Jan 2021 21:15:50 +0100
Subject: [LTP] [PATCH v2 6/6] zram: Increase timeout according to used
 devices
In-Reply-To: <YBRroFhaxdqCLv2i@pevik>
References: <20210129194144.31299-1-pvorel@suse.cz>
 <20210129194144.31299-7-pvorel@suse.cz> <YBRroFhaxdqCLv2i@pevik>
Message-ID: <YBRs9sySYXT6Bwlk@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> Hi,

> > +	TST_TIMEOUT=$((dev_num*200))
> Actually on heavy loaded machine this is not enough due BTRFS.
> I can add something like dev_num*600 or even -1 (then previous commit would not
> be needed, but IMHO still useful).
And bad thing is that it breaks other zram tests, because the timer probably
does not allow to run the cleanup:

_tst_setup_timer()
{
...
	sleep $sec && tst_res TBROK "test killed, timeout! If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1" && kill -9 -$pid &

I'm not sure if shell allow us to do it better. Maybe sent different signal than
SIGKILL and define 'trap _tst_do_exit' for that signal?

Kind regards,
Petr
