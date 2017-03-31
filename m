From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 31 Mar 2017 03:09:54 -0400 (EDT)
Subject: [LTP] [RFC PATCH 00/13] Convert LTP kernel/mem/testcase to New
 API
In-Reply-To: <20170330154358.GC886@rei.lan>
References: <20170328032239.11917-1-liwang@redhat.com>
 <20170330154358.GC886@rei.lan>
Message-ID: <1856913062.17824117.1490944194254.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Li Wang" <liwang@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Thursday, 30 March, 2017 5:43:58 PM
> Subject: Re: [LTP] [RFC PATCH 00/13] Convert LTP kernel/mem/testcase to New API
> 
> Hi!
> > Seems the failed reason in oom02/5 is not testcase issue, it just because
> > New API sets
> > test time in 5mins.
> 
> The test_test structure has .timeout variable that, if set, overrides
> the default timeout. All you need to do is to to measure how long the
> test takes, then multiply it by something as 2 to be on a safe side
> and set the .timeout correspondingly.

OOM tests depend on amount of RAM+swap, so it's going to vary a lot.
I'd say safe side is in order of hours.

Other options that come to mind:
- formula based on amount of RAM and swap
- we measure how long it takes to fill 1GB of RAM/swap, and scale that up
- we run all OOM tests in mem cgroup with fixed mem/swap limit,
  and set timeout according to worse case / slowest system

> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
> 
