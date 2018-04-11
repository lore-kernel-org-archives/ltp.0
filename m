From: Li Wang <liwang@redhat.com>
Date: Wed, 11 Apr 2018 17:26:27 +0800
Subject: [LTP] [RFC PATCH] read_all: give more time to wait children
 finish read action
In-Reply-To: <87o9iswp1m.fsf@rpws.prws.suse.cz>
References: <1523092180-5365-1-git-send-email-liwang@redhat.com>
 <87r2nox1s9.fsf@rpws.prws.suse.cz>
 <CAEemH2cSXtQfiM4snXAL-Eof7Xe3aY50z8ce=K4yo6=yBqtEbA@mail.gmail.com>
 <87po38wsx5.fsf@rpws.prws.suse.cz> <20180409111120.GB31983@rei>
 <87o9iswp1m.fsf@rpws.prws.suse.cz>
Message-ID: <CAEemH2fbu34MhHxnHrjTLMf9D7sNwCCcQVm23aO0hH00yq5=dQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

On Mon, Apr 9, 2018 at 8:19 PM, Richard Palethorpe <rpalethorpe@suse.de>
wrote:

> Hello,
>
> Cyril Hrubis writes:
>
> > Hi!
> >> OK, I think this change is good except that using a constant time for
> >> the usleep is probably bad. Instead we could use an exponential
> >> function; so we can start with a sleep of 1 then double it up to a
> >> maximum of 20 times (approximately a second for the final wait).
> >
> > Actually I was thinking of adding such functionality to the test library
> > exactly because I do not want to reimplement the exponentialy
> > incremented sleep for retry over and overe in each testcase...
>
> Sounds like a good idea.
>
> >
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
>
>
​I have written two new MACROS from this suggestion, and​ will send out the
PATCH to
request you comments after finishing my roughly test. Thanks!


-- 
Li Wang
liwang@redhat.com
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180411/3b465e3e/attachment.html>
