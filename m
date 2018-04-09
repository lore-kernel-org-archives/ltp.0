From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 9 Apr 2018 15:00:12 +0200
Subject: [LTP] [RFC PATCH] read_all: give more time to wait children
 finish read action
In-Reply-To: <87o9iswp1m.fsf@rpws.prws.suse.cz>
References: <1523092180-5365-1-git-send-email-liwang@redhat.com>
 <87r2nox1s9.fsf@rpws.prws.suse.cz>
 <CAEemH2cSXtQfiM4snXAL-Eof7Xe3aY50z8ce=K4yo6=yBqtEbA@mail.gmail.com>
 <87po38wsx5.fsf@rpws.prws.suse.cz> <20180409111120.GB31983@rei>
 <87o9iswp1m.fsf@rpws.prws.suse.cz>
Message-ID: <20180409130012.GB26048@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Maybe we need TST_RETRY_ON_NONZERO() macro that would build the retry
> > loop around a function passed as a paramter or something like that.
> 
> Or TST_RETRY_LOOP, TST_RETRY_WHILE or
> TST_RETRY_WITH_EXPONENTIAL_BACKOFF. :-)
> 
> Maybe it should not be a magic macro though, but just an inline function
> which you call in the body of a loop which performs the sleep based on a
> couple of parameters. I suppose it depends on how nice one can make the
> macro.

Well, yes. But I would go for simple sleep for the sake of fixing this
test for now, then replace it with something better once we settle on on
the actual implementation.

-- 
Cyril Hrubis
chrubis@suse.cz
