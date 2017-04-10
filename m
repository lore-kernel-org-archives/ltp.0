From: Steve Ellcey <sellcey@cavium.com>
Date: Mon, 10 Apr 2017 13:21:18 -0700
Subject: [LTP] time taken by memcg_stress_test
In-Reply-To: <20170324155857.GC9961@rei.lan>
References: <201703222258.v2MMwYJR030273@sellcey-dt.caveonetworks.com>
 <20170324155857.GC9961@rei.lan>
Message-ID: <1491855678.3139.47.camel@cavium.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

On Fri, 2017-03-24 at 16:58 +0100, Cyril Hrubis wrote:
> Hi!
> > 
> > I have a question about memcg_stress_test.  Looking at
> > memcg_stress_test.sh
> > I see that RUN_TIME is set to 3600 (60*60) which means that
> > run_stress runs
> > for an hour.  And this is run twice, once in testcase_1 and once in
> > testcase_2.  That is a long time for one test, do we really think
> > it needs
> > to run that long for 'proper' testing?  I would love to see this
> > cut in
> > half or even down to 15 minutes.  I know I can just change the
> > script locally,
> > but I was wondering if makes sense to change the default value.
> Two hours is excessive indeed however getting right balance between
> runtime and stress test coverage is always tricky...
> 
> I guess that we can settle for 15 minutes, maybe shorten the interval
> parameter that is currently set to 10 seconds to compensate for that.
> 
> Also running the two test separately (two records in the runtest file
> that would call the script with a paramter selecting between the
> tests)
> would make it better as well.

So would a patch that changed RUN_TIME to 15 minutes (15 * 60) and
changed the timout value sent to run_stress from 10 to 5 be considered
OK?  I can submit one if we think this is a reasonable change.  I am
not sure why splitting the test in two would help, LTP doesn't run any
tests in parallel does it?  I'd rather skip that part of the change as
I am worried I might mess something up.  Change 60 to 15 and 10 to 5 on
the other hand is completely straight forward.

Steve Ellcey
