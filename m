From: Hoang Nguyen <the_hoang0709@yahoo.com>
Date: Wed, 11 Jan 2017 14:32:57 +0000 (UTC)
Subject: [LTP] perf_event_open02 failed with ratio just a bit higher than
 N+0.0001
References: <1057411432.1533977.1484145177397.ref@mail.yahoo.com>
Message-ID: <1057411432.1533977.1484145177397@mail.yahoo.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi Cyril,
I've known that you're still busy with this time release, so I posted again to the mailing list so that anyone can help me to understand more clearly about perf test.
I've post my first question in below link, so when you have time, please help me some hints. :-)
https://github.com/linux-test-project/ltp/commit/56152419dc836d8c00142a0387a2c9bf73a38ef8
(Summary: PERF_COUNT_HW_INSTRUCTIONS is EOPNOTSUPP, when exclude_kernel is set. I assumed that exclude_kernel is for SW event, so how can it affect to a HW perf ?)
And my second issue, my perf_event_open02 is still failing on my board (embedded linux), when the testcase creates N+4 groups to force them to be multiplexed, the ratio is sometimes a bit higher than more than 0.0001 (but it's not close to N+4), exactly as the issue you've met before. Do you have any idea from your last time?


Thanks a lot in advance,
Hoang



-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20170111/e2583bb7/attachment-0001.html>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: blob.jpg
Type: image/png
Size: 109233 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20170111/e2583bb7/attachment-0001.png>
