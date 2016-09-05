From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 5 Sep 2016 14:50:20 +0200
Subject: [LTP] [PATCH 3/4] memcg_lib.sh: Get rid of sleep 1 in
 signal_memcg_process
In-Reply-To: <57C94968.5070609@oracle.com>
References: <1472750315-30848-1-git-send-email-chrubis@suse.cz>
 <1472750315-30848-3-git-send-email-chrubis@suse.cz>
 <57C94968.5070609@oracle.com>
Message-ID: <20160905125020.GC14029@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > This further brings down the test runtime down by another minute, now
> > the tests finish in about 30 second while we also assert that the
> > usage_in_bytes gets incremented as process consumes memory.
> 
> 50s vs 2m30s in my environment. Cool :)

:)

> >  signal_memcg_process()
> >  {
> > -	pid=$1
> > +	local pid=$1
> > +	local size=$2
> > +	local path=$3
> > +	local usage_start=$(cat ${path}memory.usage_in_bytes)
> 
> A side note.
> 
> In fact, in LTP we use 'local' in test cases written for '/bin/sh',
> whereas 'local' is not in POSIX. Maybe document this fact in the test
> writing guidelines?

Sure. FYI Debian has similar policy see 10.4 in
https://www.debian.org/doc/debian-policy/ch-files.html

> > +
> >  	kill -s USR1 $pid 2> /dev/null
> > -	sleep 1
> > +
> > +	if [ -z "$size" ]; then
> > +		return
> > +	fi
> > +
> > +	while kill -0 $pid 2> /dev/null; do
> > +		local usage=$(cat ${path}memory.usage_in_bytes)
> > +		local diff_a=$((usage_start - usage))
> > +		local diff_b=$((usage - usage_start))
> > +
> > +		if [ "$diff_a" -ge "$size" -o "$diff_b" -ge "$size" ]; then
> > +			return
> > +		fi
> > +
> > +		tst_sleep 100ms
> > +	done
> 
> Maybe add some limit on the number of checks? In case the process
> consumes less memory than in $size.

Will do.

> >  # Test hierarchical_memory_limit with enabling hierarchical accounting
> > diff --git a/testcases/kernel/controllers/memcg/functional/memcg_usage_in_bytes_test.sh b/testcases/kernel/controllers/memcg/functional/memcg_usage_in_bytes_test.sh
> > index ab86318..69dc874 100755
> > --- a/testcases/kernel/controllers/memcg/functional/memcg_usage_in_bytes_test.sh
> > +++ b/testcases/kernel/controllers/memcg/functional/memcg_usage_in_bytes_test.sh
> > @@ -34,7 +34,7 @@ TST_TOTAL=2
> >  # Test memory.usage_in_bytes
> >  testcase_1()
> >  {
> > -	test_mem_stat "--mmap-anon" $((PAGESIZE*1024)) \
> > +	test_mem_stat "--mmap-anon" $((PAGESIZE*1024)) $((PAGESIZE*1024)) \
> >  		"memory.usage_in_bytes" $((PAGESIZE*1024)) 0
> >  }
> >  
> > @@ -48,7 +48,7 @@ testcase_2()
> >  
> >  	echo $((PAGESIZE*2048)) > memory.limit_in_bytes
> >  	echo $((PAGESIZE*2048)) > memory.memsw.limit_in_bytes
> > -	test_mem_stat "--mmap-anon" $((PAGESIZE*1024)) \
> > +	test_mem_stat "--mmap-anon" $((PAGESIZE*1024)) $((PAGESIZE*1024)) \
> >  		"memory.memsw.usage_in_bytes" $((PAGESIZE*1024)) 0
> >  }
> 
> The above two calls need '0' substituted with 'false'.

My bad, I've missed that one.

-- 
Cyril Hrubis
chrubis@suse.cz
