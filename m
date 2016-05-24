From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 24 May 2016 18:46:54 +0200
Subject: [LTP] [RFC PATCH 4/4] memcg_stress_test.sh: allocate less than
 CommitLimit bytes
In-Reply-To: <5742E5B2.1030607@oracle.com>
References: <1461338590-1309-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1461338590-1309-2-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1461338590-1309-3-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1461338590-1309-4-git-send-email-stanislav.kholmanskikh@oracle.com>
 <20160512134217.GB32457@rei.lan> <573B140B.8080500@oracle.com>
 <20160518143918.GB17880@rei.lan> <573CA66F.9000900@oracle.com>
 <20160519133854.GC29601@rei.lan> <5742E5B2.1030607@oracle.com>
Message-ID: <20160524164654.GB13095@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Now, after weekends are gone, I believe that there is no need in an 
> extra control group, if we let the tests allocate MemTotal bytes of 
> memory. There will always be swapping, and its intensity will not depend 
> on the amount of swap space configured, and it will not be "too much" 
> unless there are some mm-using processes running on the system.
> 
> I believe the attached patch introduces the minimal set of changes to 
> the original test case idea (as we understand it), but lets the test 
> case runs in different environments.
> 
> What do you think about it? Did I miss something?

This sounds reasonable enough to me.

I wonder if the test has anything to do with memory cgroups though,
maybe we should rename it to memory_stress and get rid of the cgroup
bits in it.

-- 
Cyril Hrubis
chrubis@suse.cz
