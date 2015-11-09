From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 9 Nov 2015 20:05:04 +0100
Subject: [LTP] [PATCH] controllers/cpuacct: rewrote testcases
In-Reply-To: <20151109175127.GC23947@rei>
References: <1447061722-12065-1-git-send-email-chnyda@suse.com>
 <20151109175127.GC23947@rei>
Message-ID: <20151109190504.GA26979@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > +	fi
> > +}
> > +
> > +mount_cpuacct()
> > +{
> > +	mount -t cgroup -o cpuacct none $mount_point
> > +	verify_result $? 0 "Error occured while mounting cgroup"
> 
> Interesting idea. Maybe we should add such function to the test.sh
> library. Something that would call tst_brkm on non zero $?. Something
> as:
> 
> mount -t cgroup -o cpuacct none $mount_point
> tst_brkm_err TCONF "Failed to mount cgroup $mount_point"
> 
> and the test.sh would have:
> 
> tst_brkm_err()
> {
> 	if [ $? -ne 0 ]; then
> 		tst_brkm $@
> 	fi
> }

And I nearly forgotten that we added even something better. We have ROD
function that works as:

ROD mount -t cgroup -o cpuacct none $mount_point

(ROD is acronym for run or die and it does exactly the thing you need)

FYI: Have a look at:

https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#23-writing-a-testcase-in-shell

-- 
Cyril Hrubis
chrubis@suse.cz
