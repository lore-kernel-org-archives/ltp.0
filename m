From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 6 Nov 2019 14:27:52 +0100
Subject: [LTP] [PATCH v2 1/2] read_all: move blacklist to source
In-Reply-To: <87o8xpdw0l.fsf@rpws.prws.suse.cz>
References: <4647b3bced96c66c040078a32c13dab65558816d.1572956488.git.jstancek@redhat.com>
 <87o8xpdw0l.fsf@rpws.prws.suse.cz>
Message-ID: <20191106132751.GB8135@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > +static char *blacklist[] = {
> > +	NULL, /* reserved for -e parameter */
> > +	"/sys/power/wakeup_count",
> > +};
> 
> The problem with this is that it is only required if we are running as a
> privileged user. If -p is specified then it would be a bug if nobody can
> read from any of these files.

Good point.

> So I guess we could disable the builtin blacklist if drop_privs (switch
> to nobody) is specified and run this test twice on /sys with and without

Sounds reasonable, will you send a patch?

-- 
Cyril Hrubis
chrubis@suse.cz
