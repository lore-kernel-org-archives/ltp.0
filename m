From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 6 Nov 2019 10:28:37 -0500 (EST)
Subject: [LTP] [PATCH v2 1/2] read_all: move blacklist to source
In-Reply-To: <87o8xpdw0l.fsf@rpws.prws.suse.cz>
References: <4647b3bced96c66c040078a32c13dab65558816d.1572956488.git.jstancek@redhat.com>
 <87o8xpdw0l.fsf@rpws.prws.suse.cz>
Message-ID: <2124877733.10763434.1573054117742.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> > +static char *blacklist[] = {
> > +	NULL, /* reserved for -e parameter */
> > +	"/sys/power/wakeup_count",
> > +};
> 
> The problem with this is that it is only required if we are running as a
> privileged user. If -p is specified then it would be a bug if nobody can
> read from any of these files.
> 
> So I guess we could disable the builtin blacklist if drop_privs (switch
> to nobody) is specified

Good point. I just saw your reply that you plan to send a patch, thank you.

> and run this test twice on /sys with and without
> -p.
 
greg-kh wasn't very happy to hear about privileged runs in the other thread.
He was suggesting whitelist approach, but I don't know how we would keep it
up to date, deal with different configs, etc.

