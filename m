From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 14 Mar 2016 19:18:03 +0100
Subject: [LTP] Question about perf_event_open/Cap_bounds/su01 test cases
In-Reply-To: <AF04265A3FC2B144B9892F621A394E13EA3E2813@tethys>
References: <AF04265A3FC2B144B9892F621A394E13EA3DB009@tethys>
 <20160309140859.GD28171@rei.lan>
 <AF04265A3FC2B144B9892F621A394E13EA3E2813@tethys>
Message-ID: <20160314181803.GE3364@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Specifically, to Cyril comments:
> 
> > The fanotify06 failure is likely kernel bug fixed in:
> 
> After to use the latest LTP, this error disappear. The test is marked as PASS with TCONF. But the others test cases: fanotify01, fanotify02 and fanotify04 are marked as FAIL with the message "Fanotify is not configured in this kernel.". I don't understand why with this message, is still marked as fail? [please, refer details to https://justpaste.it/s5c3]. Thanks for looking at this issue and give the details of bug solution. Appreciated.

Ah that is because the test cleanup closes the fd_notify file descriptor
unconditionally while it should be only closed if it's greater than
zero.

This should fix the WARNING that causes the test to fail if fanotify is not
compiled in kernel:

 static void cleanup(void)
 {
-       if (close(fd_notify) == -1)
+       if (fd_notify > 0 && close(fd_notify) == -1)
                tst_resm(TWARN, "close(%d) failed", fd_notify);
 
        tst_rmdir();

I will push a patch with fixes for the testcasee tomorrow. Thanks for reporting
it.

-- 
Cyril Hrubis
chrubis@suse.cz
