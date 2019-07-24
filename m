From: piotr.krzysztof.gawel <piotr.krzysztof.gawel@gmail.com>
Date: Wed, 24 Jul 2019 12:43:42 +0200
Subject: [LTP] Patch for LTP
Message-ID: <5d383661.1c69fb81.3d170.b9f8@mx.google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Dear LTP community,
When I run LTP tests with musl libc, I discovered few issues in tst_timer_test.c:

The array with run times was not sorted. As Rich Felker pointed out, cmp() function breaks the contract for qsort() ? I fixed it.Because array was not sorted, some tests were dumping cores. Plotting function strongly relies on having array sorted. I fixed that in #1 but still prefer defensive
 programming here ? protect against buffer overflow i.e. when input data is incorrect.Calculation if average run time is greater than desired time + threshold was incorrect. Each expected run should be in range t < s[i] < t + threshold, so for max.
 edge: sum(s[i] + threshold) < sum(t + threshold). For i belonging to [d,n] => sum(s[i]) < (n-d)*(t + threshold) and not (n-d)*t + threshold.
Please add this patch to main line of LTP if you don?t see issues here. Feel free to modify the change if needed.Thanks in advance!
Kind regards,Piotr Gawel
null
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190724/88167bb0/attachment.htm>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: ltp-fix-tst_timer-framework.patch
Type: application/patch
Size: 2262 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190724/88167bb0/attachment.bin>
