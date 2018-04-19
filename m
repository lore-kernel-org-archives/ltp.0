From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 19 Apr 2018 16:17:49 +0200
Subject: [LTP] LTP Release preparations
In-Reply-To: <20180412113532.GA5963@rei>
References: <20180412113532.GA5963@rei>
Message-ID: <20180419141749.GA13045@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> It's about the time we should slowly prepare for the next release, as
> usuall let's start with a list of patches that should go in before we
> enter the stabilization phase.
> 
> As for me I would like to get the two speedup patchsets in, one of them
> only waits for ack from Jan, the second one would probably benefit from
> some more review. I will try to merge everything that is good to go and
> just waiting for a review ASAP.
> 
> Anything else that should really go in?

Ping.

I suppose that we should get in the fix for the read_all testcase along
with the exponential back off.

Also I would like to get in the needs_rofs patchset.

There is also patch for converting our python code to be python3
compatible that is worth looking into.

Anything else?

-- 
Cyril Hrubis
chrubis@suse.cz
