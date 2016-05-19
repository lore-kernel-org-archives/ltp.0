From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 19 May 2016 14:56:43 +0200
Subject: [LTP] [RFC PATCH 4/4] memcg_stress_test.sh: allocate less than
 CommitLimit bytes
In-Reply-To: <20160519091721.GH26110@dhcp22.suse.cz>
References: <1461338590-1309-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1461338590-1309-2-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1461338590-1309-3-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1461338590-1309-4-git-send-email-stanislav.kholmanskikh@oracle.com>
 <20160512134217.GB32457@rei.lan> <573B140B.8080500@oracle.com>
 <20160518143918.GB17880@rei.lan>
 <20160519091721.GH26110@dhcp22.suse.cz>
Message-ID: <20160519125643.GB29601@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Michal is there a way to figure out how much memory should be allocated
> > and faulted on a system in order to cause some amount of pages to be
> > swapped back and forth?
> 
> that depends on how the memory is used. If it is largerly anonymous then
> you will get swap out when you hit watermarks.

The test processes do mmap() with MAP_PRIVATE|MAP_ANONYMOUS so 99% of
the consumed memory is anonymous.

If I understand this right watermarks are set to a few megabytes so
MemFree must get low enough. Isn't there a chance to hit OOM if we try
to allocate little less than MemFree anway (assuming that we dropped
caches before we measured MemFree)? There always may be some background
daemon forking on the system while the test runs which may get use close
enough to out of memory condition.

Or did I miss something?

> > What this testcase does it to create a process(es) that allocate memory
> > and read/write it concurently to stress the system a bit but the
> > estimate on how much memory it should use is wrong and it causes OOM
> > when the amount of swap is much less than amount of RAM.
> 
> Are we talking about memcg or the global here?

The test is trying to cause pressure at the global level while the test
process(es) allocate memory in separate cgroups. No idea how sensible
this approach is.

> > The original testcase[1] drops caches then runs child(s) to allocate
> > (in sum) MemFree + SwapFree/2 memory. Each child runs in its own memory
> > cgroup but the amount of memory was choosen so that the whole system
> > would be under memory pressure. Does such test even make sense to you?
> 
> Well, it depends. It makes sense to see how the global memory pressure
> gets distributed into two memcgs which are the source of that pressure
> but I am not really sure how you want to evaluate good vs. bad case as
> the load will be quite timing sensitive. So the main question would be,
> what do you expect the test will tell you?

This is a stress test not a benchmark, so the test genereates pressure
for an hour and then it reports success if the machine outlived it.

-- 
Cyril Hrubis
chrubis@suse.cz
