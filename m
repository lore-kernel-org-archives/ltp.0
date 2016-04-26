From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 26 Apr 2016 13:07:43 +0200
Subject: [LTP] duplicated runltp options
Message-ID: <20160426110743.GA6766@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Looks like we overided the -T option for runltp in:

commit 5f71cf97d5753c5506cdf8287812f28e2fffe4aa
Author: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date:   Tue Sep 23 15:59:43 2014 +0800

    runltp, pan/ltp-pan.c: record test cases(not fully tested) into file


And now the -T is listed twice in the options and in the case.

...
-T TCONFCMDFILE Command file with all test cases that are not fully tested.
...
-T REPETITION   Execute the testsuite for REPETITION no. of times
...

And since nobody reported the problem so far, I guess that -T for
repetition wasn't widely used. So I would like to fix that by renaming
the -T REPETIONT to  -I ITERATIONS. Does that sound reasonably?

-- 
Cyril Hrubis
chrubis@suse.cz
