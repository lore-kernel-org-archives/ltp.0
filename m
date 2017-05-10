From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 10 May 2017 11:04:28 +0200
Subject: [LTP] TWARN and "ltp-pan reported PASS"
In-Reply-To: <20170509120935.q2v6dqhwmecy265w@dell5510>
References: <20170509120935.q2v6dqhwmecy265w@dell5510>
Message-ID: <20170510090428.GC29838@rei.suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> our shell scripts wrapping ltp-pan binary report failure when there is any TWARN.
> 
> Similar code in these scripts:
> runltp
> runltplite.sh
> testscripts/diskio.sh
> testscripts/network.sh
> testscripts/runEALtests.sh
> 
> if [ $? -eq "0" ]; then
>   echo ltp-pan reported PASS
> else
>   echo ltp-pan reported FAIL
> fi
>
> Does using TWARN always always mean failure? I mean, it's good that ltp-pan returns 4
> instead of 0, but wrapper script should return something like:
>
> if [ $? -eq 0 ]; then
>   echo ltp-pan reported PASS
> elif [ $? -eq 4 ]; then
>   echo ltp-pan reported PASS with warnings
> else
>   echo ltp-pan reported FAIL
> fi

Are you sure that ltp-pan actually passes the test return value? As far
as I can tell it actually increments the exit_stat variable on error
then does exit(exit_stat).

So I would say that the only guarantee that you have is that non-zero
return value from ltp-pan means "everything went ok" and non-zero
"something went wrong".

Frankly at this point I would rather kept the old test execution scripts
as they are and put more effort into the new execution framework.
Hopefully I will have a bit time to invest into it once we are done with
the release.

-- 
Cyril Hrubis
chrubis@suse.cz
