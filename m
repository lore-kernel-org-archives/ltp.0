From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 30 Jan 2017 14:13:43 +0100
Subject: [LTP] [PATCH 3/3] netstress.c: convert to new library API
In-Reply-To: <837482ef-0ac4-0a3b-3c4e-598ed6ce96e1@oracle.com>
References: <1482154595-4641-1-git-send-email-alexey.kodanev@oracle.com>
 <1482154595-4641-3-git-send-email-alexey.kodanev@oracle.com>
 <20170123145734.GC25788@rei.lan>
 <837482ef-0ac4-0a3b-3c4e-598ed6ce96e1@oracle.com>
Message-ID: <20170130131342.GC29227@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >>   	shutdown(*fd, SHUT_WR);
> >> -	SAFE_CLOSE(cleanup, *fd);
> >> +	SAFE_CLOSE(*fd);
> >>   	*fd = -1;
> > FYI the SAFE_CLOSE() already sets fd to -1.
> 
> Ah, it's not, 'fd' passed by value there... I've blindly removed it
> from code but now I need to return it back.

Are you sure? SAFE_CLOSE() is a macro which expands to:

	do {
		safe_close("foo", 42, NULL, (*fd));
		(*fd) = -1;
	} while (0)

-- 
Cyril Hrubis
chrubis@suse.cz
