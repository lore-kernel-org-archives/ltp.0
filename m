From: Li Wang <liwang@redhat.com>
Date: Tue, 21 Jun 2016 15:56:13 +0800
Subject: [LTP] [PATCH] mem/lib: Keep KSM off when child_alloc() allocate
 memory in single thread
In-Reply-To: <1793371138.555301.1466492429338.JavaMail.zimbra@redhat.com>
References: <1466480392-25837-1-git-send-email-liwang@redhat.com>
 <1793371138.555301.1466492429338.JavaMail.zimbra@redhat.com>
Message-ID: <20160621075613.GB24636@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Jun 21, 2016 at 03:00:29AM -0400, Jan Stancek wrote:
> 
> The single thread is not important here, it's how much that allocation
> contributes to limit_in_bytes. oom01 on 2 CPU system will do all
> allocations in single thread and KSM won't be turned off.

Ah, I forgot that situation. yes, it's not about the single thread,
it depends on the parameter 'lite' equal 1 or 0. I'd like to rewrite
these description.

> >  		SAFE_FILE_SCANF(cleanup, PATH_KSM "run", "%d", &ksm_run_orig);
> > -		SAFE_FILE_PRINTF(cleanup, PATH_KSM "run", "1");
> > +		/* Let KSM off if lite == 1, since limit_in_bytes may vary from
> > +		 * run to run, which isn't reliable for oom03 cgroup test.*/
> > +		if (!lite) SAFE_FILE_PRINTF(cleanup, PATH_KSM "run", "1");
> >  		oom(KSM, lite, retcode, allow_sigkill);
> >  		SAFE_FILE_PRINTF(cleanup,PATH_KSM "run", "%d", ksm_run_orig);
> >  	}
> 
> What if KSM was enabled before test started?

From what I know about KSM, if a memory area affected by function
madvise(..., MADV_MERGEABLE), the samepages located in that merory will be
easily merged by ksmd as long as we turn it on (echo 1 >/sys/kernel/mm/ksm/run).

And the ".../ksm/run" default value is 0, it means if we just affect
the memory area by madvise() function but with ksmd off, there won't
have any samepages be merged.

So, I add a conditional jugement as 'if (!lite)' before starting the ksmd.
There will be only enable the ksmd while lite == 0, the memory allocated
function go into infinite loop with so many parallel threads. And ksmd
doing samepages merge work but cann't stop OOM occur at the moment.

Am I right in thinking above?

> 
> I'd skip this entire else block if lite == 1. With KSM off, it's nearly
> identical to oom(NORMAL).

Hmm, actually there still have a little bit difference from oom(NORMALNORMAL).

In alloc_mem() function, if testcase == KSM, the memory area will do
madvise operation like:
	madvise(s, length, MADV_MERGEABLE)

That's the reason why I did not skip KSM but just keep it off.


Regards,
Li WANG
