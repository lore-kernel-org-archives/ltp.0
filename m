From: Julio Cruz Barroso <julio.cruz@smartmatic.com>
Date: Wed, 23 Mar 2016 04:28:42 +0000
Subject: [LTP] [PATCH] Check available memory to support embedded devices
In-Reply-To: <1423281604.10539234.1458206400762.JavaMail.zimbra@redhat.com>
References: <1458097275-2769-1-git-send-email-jcsistemas2001@gmail.com>
 <1423281604.10539234.1458206400762.JavaMail.zimbra@redhat.com>
Message-ID: <AF04265A3FC2B144B9892F621A394E13EA3F8762@tethys>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jan,

> 
> What I was suggesting was:
>   return (ps / 1024) * pn / 1024;

Done.

> > +
> > +	tst_resm(TINFO, "Available memory: %ldMB\n", avail_memory_mb);
> > +	if (avail_memory_mb < DEFAULT_ALLOCATION_MB) {
> > +		tst_resm(TCONF, "Not enough memory to run this case\n");
> 
> We have tst_brkm(TCONF, cleanup, "...");, which will print message, run
> cleanup and exit testcase.
> 

Done. Applied also in other points.

> DEFAULT_ALLOCATION_MB);
> > +			consume(DEFAULT_ALLOCATION_MB);
> 
> This consume() is within loop, and it doesn't look like same loop frees any
> memory. I suggest you move it before loop.
> You can try running the testcase with "-i 20".

Done.

> > +	if (avail_memory_mb < DEFAULT_ALLOCATION_MB*2) {
> 
> Is this needed? Child is not allocating anything, and fork should use copy-on-
> write.
> 

If before the call to fork() the available memory is not the double as DEFAULT_ALLOCATION_MB, the test fail (ENOMEM: fork() failed to allocate the necessary kernel structures because memory is tight).

In summary (let me know if I'm wrong), the fork() 'means that all that the state is copied, including open files, register state and all memory allocations, which includes the memory used at consume() function' [ref]. However, with COW, 'rather than copy all the memory at once, it pretends it was copied and only actually copies when the parent and child need to hold different values at the same address' [ref]. According with those assumptions, the kernel need to reserve the allocated memory anyway, and that explain why I place the condition.

> >  	tst_resm(TINFO, "Testcase #02: fork inherit(cont.)");
> > +	if (avail_memory_mb < DEFAULT_ALLOCATION_MB*2) {
> 
> Same as above.
> 

Same condition.

> >  	tst_resm(TINFO, "Testcase #03: fork + malloc");
> > +	if (avail_memory_mb < (DEFAULT_ALLOCATION_MB*2+50)) {
> 
> Same as above, isn't "50" going to be enough?

Same assumption. If there is not memory available, the test will fail. The idea is to avoid it with the condition.
> 
> Regards,
> Jan

Regards

Julio

[ref] some references about CoW:
https://www.reddit.com/r/compsci/comments/31szui/trying_to_understand_fork_and_copyonwrite_cow/
https://en.wikipedia.org/wiki/Copy-on-write
