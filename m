From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 26 Aug 2019 15:55:50 +0200
Subject: [LTP] [PATCH v2 5/5] kernel/uevent: Add uevent03
In-Reply-To: <1566464435.3467.4.camel@suse.de>
References: <20190820151831.7418-1-chrubis@suse.cz>
 <20190820151831.7418-6-chrubis@suse.cz>
 <1566464435.3467.4.camel@suse.de>
Message-ID: <20190826135550.GC15568@haruka>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > +	handler1 = strtok(handlers, " ");
> Not sure if it's possible that we will get none or only one handler?

Well that would be a bug. As far as I can tell we have to get eventX
handler and mouseY handler for each device that looks like a mouse.

I guess that checking the content of handler1 and handler2 wouldn't harm
though.

> > +	get_minor_major(handler1, minor_event1, major_event1,
> > MINOR_MAJOR_SIZE);
> > +
> > +	handler2 = strtok(NULL, " ");
> > +	get_minor_major(handler2, minor_event2, major_event2,
> > MINOR_MAJOR_SIZE);
> > +
> > +	destroy_uinput_mouse();
> > +
> > +	tst_res(TINFO, "Sysname: %s", sysname);
> > +	tst_res(TINFO, "Handlers: %s", handlers);
> Because of strtok(), we do not see all handlers here.

Ah my bad, we have to move that before the strtok() call.

-- 
Cyril Hrubis
chrubis@suse.cz
