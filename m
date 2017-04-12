From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 12 Apr 2017 15:15:31 +0200
Subject: [LTP] time taken by memcg_stress_test
In-Reply-To: <1491855678.3139.47.camel@cavium.com>
References: <201703222258.v2MMwYJR030273@sellcey-dt.caveonetworks.com>
 <20170324155857.GC9961@rei.lan>
 <1491855678.3139.47.camel@cavium.com>
Message-ID: <20170412131530.GC25790@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Two hours is excessive indeed however getting right balance between
> > runtime and stress test coverage is always tricky...
> > 
> > I guess that we can settle for 15 minutes, maybe shorten the interval
> > parameter that is currently set to 10 seconds to compensate for that.
> > 
> > Also running the two test separately (two records in the runtest file
> > that would call the script with a paramter selecting between the
> > tests)
> > would make it better as well.
> 
> So would a patch that changed RUN_TIME to 15 minutes (15 * 60) and
> changed the timout value sent to run_stress from 10 to 5 be considered
> OK?

Looks reasonable to me.

> ??I can submit one if we think this is a reasonable change. ??I am
> not sure why splitting the test in two would help, LTP doesn't run any
> tests in parallel does it? ??I'd rather skip that part of the change as
> I am worried I might mess something up. ??Change 60 to 15 and 10 to 5 on
> the other hand is completely straight forward.

We can always do the split in a separate patch.

There are several reason why test should be split into resasonably small
portions. The most important is that if big long running test fails you
have no idea which part has failed and rerunning it to figure it out
takes a lot of time...

-- 
Cyril Hrubis
chrubis@suse.cz
