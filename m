From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Mon, 03 Dec 2018 12:40:22 +0100
Subject: [LTP] [PATCH v4 0/4] New Fuzzy Sync library API
In-Reply-To: <20181120130911.GA9682@rei.lan>
References: <20181105154217.18879-1-rpalethorpe@suse.com>
 <CAEemH2dF4Mg6C_uu6GUxixev_pZqbmL-h0sE73X2_6CyN1x7nA@mail.gmail.com>
 <87bm6kasnl.fsf@rpws.prws.suse.cz> <20181120130911.GA9682@rei.lan>
Message-ID: <87y396n8ih.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> Interesting that it is so slow on an x86 system, but it also makes sense
>> with a single core because these are all multi-threaded tests. If the
>> kernel is completely preemptive then it may be theoretically possible to
>> trigger one of these bugs on a single core, but most people seem to
>> think the probability of it happening is lower than on a multi-core
>> machine.
>>
>> I am tempted to simply exit the test with TCONF if it is a single core
>> system. If we do allow them to run on a single core then we have to test
>> that they work reasonably well on single cores (given enough
>> time). Which I just don't think is worth doing based on the times you
>> have given.
>
> Well some of these test still trigger kernel crashes on single CPU
> 300Mhz arm quite reliably. If anything we may want to disable some
> subset on slow single CPUs, but then someone would have to do the
> selection which is probably not worth of the trouble.

OK, I think Jan's patch to limit the sampling time is a reasonably good
solution for now. Also I think based on new evidence we can say the
tests work on single CPUs in practice, it just takes longer.

--
Thank you,
Richard.
