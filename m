From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 24 May 2016 18:21:30 +0200
Subject: [LTP] [RFC PATCH 4/4] memcg_stress_test.sh: allocate less than
 CommitLimit bytes
In-Reply-To: <20160519192151.GB5290@dhcp22.suse.cz>
References: <1461338590-1309-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1461338590-1309-2-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1461338590-1309-3-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1461338590-1309-4-git-send-email-stanislav.kholmanskikh@oracle.com>
 <20160512134217.GB32457@rei.lan> <573B140B.8080500@oracle.com>
 <20160518143918.GB17880@rei.lan>
 <20160519091721.GH26110@dhcp22.suse.cz>
 <20160519125643.GB29601@rei.lan>
 <20160519192151.GB5290@dhcp22.suse.cz>
Message-ID: <20160524162130.GA13095@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > The test is trying to cause pressure at the global level while the test
> > process(es) allocate memory in separate cgroups. No idea how sensible
> > this approach is.
> 
> Dunno. I fail to see what would be the role of the memcg then.

So do I.

> > > > The original testcase[1] drops caches then runs child(s) to allocate
> > > > (in sum) MemFree + SwapFree/2 memory. Each child runs in its own memory
> > > > cgroup but the amount of memory was choosen so that the whole system
> > > > would be under memory pressure. Does such test even make sense to you?
> > > 
> > > Well, it depends. It makes sense to see how the global memory pressure
> > > gets distributed into two memcgs which are the source of that pressure
> > > but I am not really sure how you want to evaluate good vs. bad case as
> > > the load will be quite timing sensitive. So the main question would be,
> > > what do you expect the test will tell you?
> > 
> > This is a stress test not a benchmark, so the test genereates pressure
> > for an hour and then it reports success if the machine outlived it.
> 
> But then why to bother with memcg configuration? I could understand if
> you compared the same load with and without memcg in the game but other
> than that it sounds like a random bashing of the system.

Well that is the reason I've CCed you as well, since the test was not
making much sense to me but I can always miss something.

-- 
Cyril Hrubis
chrubis@suse.cz
