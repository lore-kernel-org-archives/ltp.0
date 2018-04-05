From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu,  5 Apr 2018 16:50:09 +0200
Subject: [LTP] Get rid of few more useless sleep() calls
Message-ID: <20180405145015.7633-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This patchset gets rid of a few useless sleeps speeding up the syscalls
run by another ~17s. It may not seem a lot, but if we combine all the
possible speedups we may save up to five minutes which is ~30% of
the syscall testsuite runtime for me.

