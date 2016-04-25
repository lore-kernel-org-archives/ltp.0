From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 25 Apr 2016 15:31:15 +0200
Subject: [LTP] Issue with the reporting of failed tests
In-Reply-To: <571E118C.1080707@free.fr>
References: <5718D4CA.5010607@free.fr> <5718E81B.6060101@free.fr>
 <20160421153041.GA25307@rei> <5718F4EE.2060009@free.fr>
 <571907A2.10208@free.fr> <571A274A.60707@free.fr>
 <571DCF8D.30306@free.fr> <571E0226.3020104@free.fr>
 <571E118C.1080707@free.fr>
Message-ID: <20160425133115.GB20158@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> These two tests are not being built.
> FILTER_OUT_DIRS		:= $(if $(AIO_LIBS),,aio ltp-aiodio)
> 
> so pan fails to launch them, obviously.
> pan(1130): execvp of 'aio01' (tag aio01) failed.  errno:2  No such file or directory
> pan(1130): execvp of 'aio_tio' (tag aio02) failed.  errno:2  No such file or directory
> 
> I don't think these should be considered failures?

I guess that we should report TCONF if test binary was missing instead.
I can try to prototype a patch for this, but I would preffer doing that
after release.

-- 
Cyril Hrubis
chrubis@suse.cz
