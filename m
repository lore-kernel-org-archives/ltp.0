From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 9 Apr 2018 13:11:20 +0200
Subject: [LTP] [RFC PATCH] read_all: give more time to wait children
 finish read action
In-Reply-To: <87po38wsx5.fsf@rpws.prws.suse.cz>
References: <1523092180-5365-1-git-send-email-liwang@redhat.com>
 <87r2nox1s9.fsf@rpws.prws.suse.cz>
 <CAEemH2cSXtQfiM4snXAL-Eof7Xe3aY50z8ce=K4yo6=yBqtEbA@mail.gmail.com>
 <87po38wsx5.fsf@rpws.prws.suse.cz>
Message-ID: <20180409111120.GB31983@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> OK, I think this change is good except that using a constant time for
> the usleep is probably bad. Instead we could use an exponential
> function; so we can start with a sleep of 1 then double it up to a
> maximum of 20 times (approximately a second for the final wait).

Actually I was thinking of adding such functionality to the test library
exactly because I do not want to reimplement the exponentialy
incremented sleep for retry over and overe in each testcase...

Maybe we need TST_RETRY_ON_NONZERO() macro that would build the retry
loop around a function passed as a paramter or something like that.

-- 
Cyril Hrubis
chrubis@suse.cz
