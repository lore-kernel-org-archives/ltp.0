From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 13 Aug 2018 17:48:47 +0200
Subject: [LTP] [PATCH] tracing: ftrace_lib: check if tracing_max_latency
 exists.
In-Reply-To: <20180813154618.GC140438@sspatil-desktop.mtv.corp.google.com>
References: <20180808234019.241238-1-sspatil@google.com>
 <20180810125741.GC32275@rei.lan>
 <20180813154618.GC140438@sspatil-desktop.mtv.corp.google.com>
Message-ID: <20180813154847.GA8576@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > I guess that we can remove the 2> /dev/null that I suppose was supposed
> > to silence the error. Does it work okay for you without the redirection?
> 
> Yes, just tested it. Works for me. Want me to send the patch removing it?

No need, I will edit the patch you send before applying.

-- 
Cyril Hrubis
chrubis@suse.cz
