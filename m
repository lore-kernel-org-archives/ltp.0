From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 5 May 2020 17:01:55 +0200
Subject: [LTP] [PATCH v4 1/2] pty04: Use guarded buffers for transmission
In-Reply-To: <87d07isaka.fsf@our.domain.is.not.set>
References: <20200505101625.25020-1-rpalethorpe@suse.com>
 <20200505133746.GB21884@dell5510>
 <87d07isaka.fsf@our.domain.is.not.set>
Message-ID: <20200505150155.GA3620@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richard,

> This looks similar to the issue reported by Jan:

> https://github.com/linux-test-project/ltp/issues/674

> Is this the full output?
Yes, it's exactly the same issue. Thanks for info, I overlooked this bug.

> Thinking aloud: the following (probably) happens when writing to the PTY

> write() -> PTY -> SLIP/SLCAN -> netdev -> read()

> Writing to the PTY causes the PTY to write to the line discipline. What
> I found was that when the line discipline receive buffer got full and the PTY
> send buffer got full. The write would go to sleep and never wake up
> because the line discipline drained the receive buffer, but doesn't
> signal it is ready for more data (with tty_unthrottle). So I used
> nonblocking writes which just retry writing.

> From Jan's errors it looks like it might just be reading that is failing
> in one case and that writing is also failing in the other until we
> cancel the read. I doubt this is anything to do with the netdev code
> because it is generic networking code AFAICT and should work correctly
> with blocking reads...
Hm, I'm not familiar with the code, but also thing it's not netdev related.

Kind regards,
Petr
