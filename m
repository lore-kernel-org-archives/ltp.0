From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 19 Feb 2020 11:35:05 +0100
Subject: [LTP] [PATCH v2] Wrapper for Syzkaller reproducers
In-Reply-To: <877e0jgewo.fsf@our.domain.is.not.set>
References: <20191204103120.29440-1-rpalethorpe@suse.com>
 <CACT4Y+aMum6OJS_t-_-sXOUftPegFGrAjCvYJ-0g+5z7=aX7GQ@mail.gmail.com>
 <877e0jgewo.fsf@our.domain.is.not.set>
Message-ID: <20200219103505.GB28580@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >> Allows one to run the Syzkaller reproducers as part of the LTP.
> >>
> >> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> >> ---
> >>
> >> V2:
> >>
> >> * Will now refuse to compile on anything other than x86_64, because I haven't
> >>   tested them on anything else.
> >>
> >> * Hopefully fixed problem with submodule not being found because I didn't
> >>   include a commit reference.
> >>
> >> * Added explicity 'no' value if --with-syzkaller-repros is not present
> >>
> >> * Reduced the default timeout in the test to 20 seconds. I found this allows
> >>   me to complete testing in reasonable time.
> >
> > What's the status of this? This wasn't merged yet, right?
> > I don't see this here:
> > https://github.com/linux-test-project/ltp/tree/master/testcases/kernel
> 
> Yeah, it fell to one side due to the LTP release, SUSE Hackweek and lack
> of feedback. Hopefully we can get it merged soon however.

You don't forget about FOSDEM. Unfortunatelly we have managed to
accumulate quite a backlog at the start of the year.

However I do plan to return to this once things settle down a bit.

-- 
Cyril Hrubis
chrubis@suse.cz
