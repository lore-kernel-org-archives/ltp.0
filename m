From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 19 May 2016 15:38:54 +0200
Subject: [LTP] [RFC PATCH 4/4] memcg_stress_test.sh: allocate less than
 CommitLimit bytes
In-Reply-To: <573CA66F.9000900@oracle.com>
References: <1461338590-1309-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1461338590-1309-2-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1461338590-1309-3-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1461338590-1309-4-git-send-email-stanislav.kholmanskikh@oracle.com>
 <20160512134217.GB32457@rei.lan> <573B140B.8080500@oracle.com>
 <20160518143918.GB17880@rei.lan> <573CA66F.9000900@oracle.com>
Message-ID: <20160519133854.GC29601@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > I guess that when we decide to create the pressure inside of the memory
> > cgroup, instead of stressing the whole system, we may as well choose
> > small enough amount of memory, something as (RAM - 250Mb)/10 and be done
> > with it.
> 
> Yes, this should work as well.
> 
> I don't know how we could stress the whole system without the risk of 
> hitting an OOM. One idea which comes to my mind is about using a 
> top-level control group with a significant amount of memory assigned to 
> it (like mem_free / 2).
> 
> Could you, please, have a look at the attachment? I was playing with 
> this patch today and was able to stress my system without OOM.
> 
> However, this scheme may result in a very intensive swapping if mem_free 
> is large (given that there is enough swap).

Then we should place upper limit on the amount of used swap as well.

Something as MIN(MemFree/2, SwapFree, 1GB) to be used for the limit and
abort the test if this number is to small?

Apart from that the root memory cgroup should be better named something
as ltp_stres_root so that it's clear where it came from...

-- 
Cyril Hrubis
chrubis@suse.cz
