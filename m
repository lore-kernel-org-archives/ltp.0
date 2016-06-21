From: Li Wang <liwang@redhat.com>
Date: Tue, 21 Jun 2016 11:26:17 +0800
Subject: [LTP] [PATCH] mem/lib: keep allocating memory until get an
 error in single process
In-Reply-To: <214135224.352328.1466427831586.JavaMail.zimbra@redhat.com>
References: <1466416385-20603-1-git-send-email-liwang@redhat.com>
 <1007336481.302642.1466419398150.JavaMail.zimbra@redhat.com>
 <20160620113454.GA21624@gmail.com>
 <214135224.352328.1466427831586.JavaMail.zimbra@redhat.com>
Message-ID: <20160621031245.GA24636@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Jun 20, 2016 at 09:03:51AM -0400, Jan Stancek wrote:
> > 
> > 2. The child_alloc() probably should also do memory allocation with an
> > infinite loop
> 
> At the time 'lite' was introduced, everything was single threaded,
> the only difference was that lite == 0 would keep allocating in
> infinite loop.
> 
> Your patch is effectively eliminating lite == 1, which means that
> oom03 will pass even if cgroup limits are broken.

You're right! My previous meothod didn't solve the essential problem.

> 
> > in single process mode. Because if someone has a caller testoom(0, 1, ENOMEM,
> > 1) at other
> > place in future, that'll be easily get fauilures.
> 
> Likely because author is expecting behaviour other than what
> we have now:
> 
>  * @lite: if non-zero, child makes only single TESTMEM+MB allocation
>  *        if zero, child keeps allocating memory until it gets killed
>  *        or some operation fails

Okay, now just keep it this way.

> 
> > Or, can we solve them in one method?
> 
> We could skip oom(KSM) if lite == 1 in testoom(), since limit_in_bytes
> may vary from run to run, which isn't reliable for oom03 cgroup test.
> 
> Or we could change alloc_mem for lite == 1 && testcase == KSM,
> such that each page would have unique content (to prevent merging).

Yes, and we clould also keep the KSM scan off while lite == 1.
	if (lite != 1) SAFE_FILE_PRINTF(cleanup, PATH_KSM "run", "1");

Let me format a new patch for this.

Regards,
Li WANG
