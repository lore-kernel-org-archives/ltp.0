From: vaishnavi.d <vaishnavi.d@zilogic.com>
Date: Thu, 09 Aug 2018 13:30:37 -0000
Subject: [LTP] [RFC] statx Timestamp Test case
Message-ID: <d1c5e0ca49ef02e6ca2f87a8ac524428.squirrel@pike.zilogic.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


Hi,
  We are trying to write a testcase for statx timestamp fields(btime,
atime, mtime and ctime).

In our approach, we are getting the system time before and after calling
the corresponding system call that affects the timestamp using
clock_gettime.

The problem we are facing is there is no sufficient time difference
between successive times.

To introduce a delay, we are writing a function that will read time until
there is a time change as below:

>void my_clock_gettime(struct timespec *time)
> {
>    int ret;
>    struct timespec prev_time;


>    ret = clock_gettime(CLOCK_REALTIME_COARSE, &prev_time);
>    if (ret == -1)
>	tst_brk(TINFO | TERRNO, "clock_gettime failed");

>    do {
>	ret = clock_gettime(CLOCK_REALTIME_COARSE, time);
>	if (ret == -1)
>	    tst_brk(TINFO | TERRNO, "clock_gettime failed");
>    } while (time == prev_time);
>}

Is this approach fine or is there any other better way of doing it?

Thanks & Regards,
Vaishnavi.D
Subash.G




