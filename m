From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 10 Jul 2017 03:38:10 -0400 (EDT)
Subject: [LTP] [PATCH V2 03/14] mem/oom: fix the timeout issue
In-Reply-To: <20170707151137.GF28534@rei.lan>
References: <20170410100556.4465-1-liwang@redhat.com>
 <20170410100556.4465-4-liwang@redhat.com> <20170707151137.GF28534@rei.lan>
Message-ID: <1535335729.48523755.1499672290436.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> Hi!
> > OOM spend time is depend on amount of RAM+Swap, it's hard to get a standard
> > to measure how long it takes, so that we cann't set tst_test->timeout
> > easily.
> > 
> > In this patch, we divide the tests into two part:
> > 
> > 1. OOM takes original way on small(mem_total <= 100G) RAM, and with setting
> >    the .timeout according to the worst spending on 100G system. Here gives
> >    double(.timeout = 1200) cost in order to make sure time is long enough.
> > 
> > 2. If system RAM is larger than 100G, OOM goes to the cgroup limited way.
> 
> I wonder if it's really OK to limit these tests to 100G of RAM. Since as
> it is these tests can really stress the system on low memory conditions,
> if we limit them to run inside of a cgroup we are testing cgroup
> implementation instead, which is we should probably do as well.
> 
> I'm starting to think that OOM tests are special enough so that we can
> add functionality to disable timeouts for these, i.e. set the .timeout
> to -1 and change the test library so that the alarm() is not set in such
> case.
> 
> Jan do you have anything to add?

I'm OK with timeout -1. 

I'm thinking if we should introduce a parameter to TCONF on large RAM systems
anyway and split mm runtest file into "fast" and "stress". The "fast" one
would contain tests that can complete in ~minutes (including oom tests with
parameter) and then "stress" one would be for all those slow that can take
several hours (oom tests with no parameter) to complete.

Regards,
Jan
