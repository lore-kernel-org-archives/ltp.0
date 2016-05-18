From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 18 May 2016 16:53:26 +0200
Subject: [LTP] ltp-full-20160510 compile failed
In-Reply-To: <1923642895.3898894.1463574897794.JavaMail.zimbra@redhat.com>
References: <20160518082726.GA3920@localhost.localdomain>
 <1923642895.3898894.1463574897794.JavaMail.zimbra@redhat.com>
Message-ID: <20160518145325.GC17880@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> This looks like an issue that was brought up a while back:
>   [LTP] [PATCH] Makefile: Disable parallel build for $(CRITICAL_MAKEFILES)
>   https://www.mail-archive.com/ltp-list@lists.sourceforge.net/msg15795.html
> 
> So I think you need to stick with non-parallel builds open_posix_testsuite
> for now.

Just non-parallel build for the Makefiles as far as I remember.

Sorry that this issue was left unsolved, I will try to look into it
again. Until then you can workaround it by forcing the nonparallel build
for CRITICAL_MAKEFILES as does the patch in the email thread.

-- 
Cyril Hrubis
chrubis@suse.cz
