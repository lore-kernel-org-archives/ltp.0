From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 10 Feb 2016 12:41:34 +0100
Subject: [LTP] Test library API changes
In-Reply-To: <1670220208.19308377.1455100978449.JavaMail.zimbra@redhat.com>
References: <20160105111136.GA32659@rei.lan>
 <1146864418.5284131.1452171696007.JavaMail.zimbra@redhat.com>
 <20160204105638.GA4615@rei> <20160208180211.GE9844@rei>
 <20160209164352.GC11823@rei.lan> <20160209165703.GA5441@rei.lan>
 <20160209174618.GB5441@rei.lan>
 <1670220208.19308377.1455100978449.JavaMail.zimbra@redhat.com>
Message-ID: <20160210114134.GA10106@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> 4. suggestion: improved safeguard for cleanup
> Record pid of main process at start and call cleanup only if current
> pid is recorded pid. This doesn't make it depend on using specific
> API call to run child process.

You are right, we should avoid calling cleanup() and internal do_exit()
in case that process was forked by plain tst_fork(), which is reasonable
action if process needs child and do not need to use tst_resm()
reporting inside. I would say that not doing exit(0) from the child is a
mistake in this case, but we should certainly at least issue an error
message. And also we must not call the callback if such child called
tst_brk(TBROK,..) (which is desirable so that we can use SAFE_MACROS()
in such cases).

-- 
Cyril Hrubis
chrubis@suse.cz
