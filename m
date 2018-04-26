From: Sebastian Chlad <schlad@suse.de>
Date: Thu, 26 Apr 2018 16:48:24 +0200
Subject: [LTP] [PATCH] commands: Remove all test cases
In-Reply-To: <20180426134726.GA14157@x230>
References: <20180426132418.19495-1-schlad@suse.de>
 <20180426132418.19495-2-schlad@suse.de>
 <20180426134726.GA14157@x230>
Message-ID: <20180426164824.2eed2345@linux-p5n0>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, 26 Apr 2018 15:47:26 +0200
Petr Vorel <pvorel@suse.cz> wrote:

> Hi,
> 
> > Test cases testing commands are often outdated or not maintained.
> > Those test cases also do not fit in with current LTP project
> > status.  
> 
> > Signed-off-by: Sebastian Chlad <schlad@suse.de>
> > ---  
> this is controversial, as some people might be using some of them.

Sure. I'm really looking forward to hearing some feedback on this.

> But I'd be for removing most of these - these are mostly smoke tests
> which should be in upstream repositories (I guess live projects has
> better tests than these), where they have better change to stay up to
> date. Upstream tests are then can be run by packagers (and IMHO
> they're run, if they're available).

Actually valid point. Perhaps make sense to look closely at those
commands and see if some of those should be removed.

> 
> IMHO LTP should aim to test kernel, not userspace tools for Linux
> distros.
> 
> 
> Kind regards,
> Petr

