From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 15 Nov 2019 10:52:34 +0100
Subject: [LTP] ??? FAIL: Test report for kernel 5.4.0-rc6-dd89262.cki
 (mainline.kernel.org)
In-Reply-To: <976393725.11648955.1573552572246.JavaMail.zimbra@redhat.com>
References: <cki.ECB352932E.9FL0Q68EC2@redhat.com>
 <232041279.11531466.1573491604178.JavaMail.zimbra@redhat.com>
 <976393725.11648955.1573552572246.JavaMail.zimbra@redhat.com>
Message-ID: <20191115095234.GA18488@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > perf_event_open02 again:
> 
> I have a system [1] where it's consistently reproducible.
> It looks like count_hardware_counters() reports incorrect number.
> time_enabled and time_running are different but only barely (~0.7%).
> 
> # ./perf_event_open02 -v
> at iteration:0 value:300357893 time_enabled:55368608 time_running:55368608
> at iteration:1 value:600712498 time_enabled:54808179 time_running:54403148
> perf_event_open02    0  TINFO  :  overall task clock: 54825931
> perf_event_open02    0  TINFO  :  hw sum: 1442538620, task clock sum: 260919342
> hw counters: 288507724 288507724 288507724 288507724 288507724
> task clock counters: 51773047 52526664 52531694 52540386 51547551
> perf_event_open02    0  TINFO  :  ratio: 4.759050
> perf_event_open02    1  TFAIL  :  perf_event_open02.c:394: test failed (ratio was greater than )
> 
> Also do_work() completes pretty fast compared to a different host:
> 
> real	0m0.176s
> user	0m0.163s
> sys	0m0.003s

I was thinking of setting up an CPU time alarm that would stop that loop
so that it will run for reasonably defined length regardless the CPU
speed...

-- 
Cyril Hrubis
chrubis@suse.cz
