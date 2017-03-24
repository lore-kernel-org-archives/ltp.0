From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 24 Mar 2017 16:58:57 +0100
Subject: [LTP] time taken by memcg_stress_test
In-Reply-To: <201703222258.v2MMwYJR030273@sellcey-dt.caveonetworks.com>
References: <201703222258.v2MMwYJR030273@sellcey-dt.caveonetworks.com>
Message-ID: <20170324155857.GC9961@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I have a question about memcg_stress_test.  Looking at memcg_stress_test.sh
> I see that RUN_TIME is set to 3600 (60*60) which means that run_stress runs
> for an hour.  And this is run twice, once in testcase_1 and once in
> testcase_2.  That is a long time for one test, do we really think it needs
> to run that long for 'proper' testing?  I would love to see this cut in
> half or even down to 15 minutes.  I know I can just change the script locally,
> but I was wondering if makes sense to change the default value.

Two hours is excessive indeed however getting right balance between
runtime and stress test coverage is always tricky...

I guess that we can settle for 15 minutes, maybe shorten the interval
parameter that is currently set to 10 seconds to compensate for that.

Also running the two test separately (two records in the runtest file
that would call the script with a paramter selecting between the tests)
would make it better as well.

-- 
Cyril Hrubis
chrubis@suse.cz
