From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 7 Mar 2016 11:13:19 +0100
Subject: [LTP] [PATCH] rt_sigaction.h: adjust for ARC
In-Reply-To: <1457090537-23825-1-git-send-email-vgupta@synopsys.com>
References: <1457090537-23825-1-git-send-email-vgupta@synopsys.com>
Message-ID: <20160307101319.GB3559@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> To me all the song-and-dance in ltp_rt_sigaction() doesn't make sense.

These are required if you call the raw rt_sigaction syscall. Since
before signal handler is called the process context is saved on the
user-space stack and once signal is done it has to be restored. In order
to do that signal trampoline is called which calls sigreturn to restore
the context. And the way trapoline is executed is platform specific and
sometimes in the sa_restorer.

> The intent it to test whatever platform libc + kernel combination
> provides and to that end any fixups in LTP seem odd to me.
> So for ARC just call what libc provides and don't claim to support
> more/less.

These testcases are testing kernel syscall and some of the testcases
will not work with the libc wrapper. So NACK on the patch.

-- 
Cyril Hrubis
chrubis@suse.cz
