From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 23 May 2016 17:43:53 +0200
Subject: [LTP] Fwd: pwrite04 ltp bug?
In-Reply-To: <CAOg9mSQJF9gShs0m8osa7=idydmsacV1og78XCq=zitNH6aR9Q@mail.gmail.com>
References: <CAOg9mSSjfxiZ960tpADgVmndxXQpC7ag9QZSz68NbdeGn+yW9g@mail.gmail.com>
 <CADVQ27oBdCxfuVmknYa16RTXpnYgncn94VnutMgn2+9VD-9bcg@mail.gmail.com>
 <CADVQ27q119e2Oqg0tVGDjc_8yjoXvQHbg=Tqd9n4jxu8tedRVg@mail.gmail.com>
 <CAOg9mSScVopGsoQeoESWAnD2YFrsr2qzQksC8A8T8m8dncFdAg@mail.gmail.com>
 <20160523123928.GE22559@rei.lan>
 <CAOg9mSQJF9gShs0m8osa7=idydmsacV1og78XCq=zitNH6aR9Q@mail.gmail.com>
Message-ID: <20160523154353.GE25488@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  > This does not look right...
> 
> OK, I was just copying the file size test
> loop above the "Finally" comment, I assumed
> that cleanup exited. As it is, if you fail the
> file size loop I edited,  you'll get both a FAIL
> and a PASS...
> 
> Maybe in all the cases that resolve to FAIL
> we should goto some kind of out-fail: ?

The best solution would to move the actual test to a separate function
called from the for() loop in main(), then we can just do return in case
of failure.

-- 
Cyril Hrubis
chrubis@suse.cz
