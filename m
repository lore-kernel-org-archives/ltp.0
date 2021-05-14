From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 14 May 2021 12:45:08 +0200
Subject: [LTP] [PATCH 2/2] travis: Enhance docparse testing
In-Reply-To: <YJ5AzHNUAiSGwfS+@pevik>
References: <20210512165702.22883-1-pvorel@suse.cz>
 <20210512165702.22883-2-pvorel@suse.cz> <YJ4qakUgJSkeA/kV@yuki>
 <YJ5AzHNUAiSGwfS+@pevik>
Message-ID: <YJ5UtOYnapjKtwJU@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

actually the longest one was caused by openSUSE Tumbleweed,
probably some temporary container update issue.

Thus merging both with your ack.

Kind regards,
Petr

> > Hi!
> > Looks good.

> > Is this making the build significantly slower? If not let's get this in
> > now so that we have metadata covered by travis as well.

> 53 min with [1] vs. 36 min [2] without. That's quite a big difference.
> But other build got only 39 min [3], thus running yet another build [4]
> to see what's going on. I'd like to have this docparse testing in travis.

> Kind regards,
> Petr

> [1] https://travis-ci.org/github/pevik/ltp/builds/770930869
> [2] https://travis-ci.org/github/pevik/ltp/builds/770895636
> [3] https://travis-ci.org/github/pevik/ltp/builds/771055881
> [4] https://travis-ci.org/github/pevik/ltp/builds/771117708
