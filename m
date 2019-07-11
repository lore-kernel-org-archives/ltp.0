From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 11 Jul 2019 13:34:05 +0200
Subject: [LTP] [PATCH RESEND] syscalls/prctl06.c: New test for prctl()
 with PR_{SET, GET}_NO_NEW_PRIVS
In-Reply-To: <5D26EBEF.3090604@cn.fujitsu.com>
References: <20190709105303.GA4914@rei.lan>
 <1562366936-26456-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20190710105207.GC30934@rei.lan> <5D26EBEF.3090604@cn.fujitsu.com>
Message-ID: <20190711113405.GA27889@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > We are executing setuid binary that was created by root here so
> > shouldn't we just check that getuid() and getgid() returns 0?
> >
> I try it.  whether we set or not set new privs, the getuid() or getgid() return nobody in
> prctl06_execve.  Or, I misunderstand your advise?

Looking closely into the manuals the setuid and setgid bits are supposed
to set the effective ids, so I guess that the geteuid() and getegid()
will return 0 when the process was executed without the prctl().

-- 
Cyril Hrubis
chrubis@suse.cz
