From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 17 Sep 2021 10:50:52 +0200
Subject: [LTP] [PATCH v2] tst_test: using SIGTERM to terminate process
In-Reply-To: <YUJ7SC/FoA8wTaf2@pevik>
References: <20210519085812.27263-1-liwang@redhat.com> <YUJ2XA7W3JPODyNC@pevik>
 <YUJ7SC/FoA8wTaf2@pevik>
Message-ID: <YURW7NKNSSr0J6pL@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> setup()
> {
> 	tst_brk TCONF "quit now!"
> }
> 
> do_test()
> {
> 	tst_res TPASS "pass :)"
> }
> 
> tst_run
> EOF
> 
> # while true; do ./debug.sh; done

I managed to reproduce this in dash. I bet that this is a bug where
signal handler inside dash is temporarily disabled when we install the
trap and if we manage to hit that window the signal is discarded. At
least that is my working theory. After I've installed debug prints, in
the cases where it hangs the signal was sent just before have installed
the trap. And in some cases when the signal arrives the timer process is
killed but the trap is not invoked. So it really looks like signal
handling in dash is simply broken. Not sure what we can do about bugs
like this apart from switching to a real programming language.

-- 
Cyril Hrubis
chrubis@suse.cz
