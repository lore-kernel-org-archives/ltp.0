From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 6 Sep 2021 15:02:04 +0200
Subject: [LTP] [PATCH 4/7] syscalls/kill05: Use any two unprivileged
 users
In-Reply-To: <YTYOpPM5uupQrayf@yuki>
References: <20210903154848.18705-1-mdoucha@suse.cz>
 <20210903154848.18705-5-mdoucha@suse.cz> <YTYJUPFc75TuOJSb@yuki>
 <77fd98d9-5257-c1da-a01b-77d8cc1b6bce@suse.cz>
 <YTYOpPM5uupQrayf@yuki>
Message-ID: <YTYRTG9uXJdUaGtg@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > We could just use UID 1 and 2 for this test but I'd rather not assume
> > that set*uid() functions allow setting unused UIDs. Even if it works
> > now, it could easily break in the future or on some special system auth
> > backends.
> 
> Don't we already depend on being able to use unused GID? How is this
> different?

Hmm we pass the unused GID mostly to chown(), but still.

The Linux manual page specify that setuid() may fail to change if
the UID is not valid inside a namespace, that means that either there is
no UID map or particular UID is missing from the UID map. So reading
/etc/passwd hypotetically help if we are inside of a thight container
and /etc/passwd matches the UID map, but I'm not sure if this is worth
of the effort.

-- 
Cyril Hrubis
chrubis@suse.cz
