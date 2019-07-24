From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 24 Jul 2019 16:25:47 +0200
Subject: [LTP] Patch for LTP
In-Reply-To: <5d383661.1c69fb81.3d170.b9f8@mx.google.com>
References: <5d383661.1c69fb81.3d170.b9f8@mx.google.com>
Message-ID: <20190724142520.GA21787@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> When I run LTP tests with musl libc, I discovered few issues in tst_timer_test.c:
> 
> The array with run times was not sorted. As Rich Felker pointed out, cmp() function breaks the contract for qsort() ??? I fixed it.Because array was not sorted, some tests were dumping cores. Plotting function strongly relies on having array sorted. I fixed that in #1 but still prefer defensive
>  programming here ??? protect against buffer overflow i.e. when input data is incorrect.Calculation if average run time is greater than desired time + threshold was incorrect. Each expected run should be in range t < s[i] < t + threshold, so for max.
>  edge: sum(s[i] + threshold) < sum(t + threshold). For i belonging to [d,n] => sum(s[i]) < (n-d)*(t + threshold) and not (n-d)*t + threshold.
> Please add this patch to main line of LTP if you don???t see issues here. Feel free to modify the change if needed.Thanks in advance!

Good catch, also thanks for the patch.

Can you please split the patch into separate patches?

You are doing unrelated changes each should be in a separate patch.

Also the comment in the compare function should rather be in the patch
description than in the code itself.

Lastly but not least if you could send the patches with git-send-email
or at least inline so that I can comment on the changes in the reply.

-- 
Cyril Hrubis
chrubis@suse.cz
