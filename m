From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 16 Jan 2017 15:10:59 +0100
Subject: [LTP] perf_event_open02 failed with ratio just a bit higher
 than N+0.0001
In-Reply-To: <1057411432.1533977.1484145177397@mail.yahoo.com>
References: <1057411432.1533977.1484145177397.ref@mail.yahoo.com>
 <1057411432.1533977.1484145177397@mail.yahoo.com>
Message-ID: <20170116140938.GE26610@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I've known that you're still busy with this time release, so I posted
> again to the mailing list so that anyone can help me to understand
> more clearly about perf test.  I've post my first question in below
> link, so when you have time, please help me some hints. :-)

Sorry for the late reply, this email ended up in spam folder, which is
likely because the attached screenshot. Why haven't you send a link to
the page instead?

> https://github.com/linux-test-project/ltp/commit/56152419dc836d8c00142a0387a2c9bf73a38ef8
> (Summary: PERF_COUNT_HW_INSTRUCTIONS is EOPNOTSUPP, when
> exclude_kernel is set. I assumed that exclude_kernel is for SW event,
> so how can it affect to a HW perf ?) And my second issue, my
> perf_event_open02 is still failing on my board (embedded linux), when
> the testcase creates N+4 groups to force them to be multiplexed, the
> ratio is sometimes a bit higher than more than??0.0001 (but it's not
> close to N+4), exactly as the issue you've met before. Do you have any
> idea from your last time?

No idea what is wrong with the test yet. Quite possibly it fails if the
test process gets preempted but that is just a wild guess. You can
safely ignore the failures for now.

-- 
Cyril Hrubis
chrubis@suse.cz
