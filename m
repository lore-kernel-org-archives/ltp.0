From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Mon, 5 Oct 2020 15:18:33 +0200
Subject: [LTP] [stable 4.19] [PANIC]: tracing: Centralize preemptirq
 tracepoints and unify their usage
In-Reply-To: <20200925113049.4c10c864@oasis.local.home>
References: <20180823023839.GA13343@shao2-debian>
 <20180828195347.GA228832@joelaf.mtv.corp.google.com>
 <CA+G9fYtV_sjTKLMXWMP0w0A-H+p+CN-uVJ6dvHovDy9epJZ2GQ@mail.gmail.com>
 <20200925051518.GA605188@kroah.com>
 <CA+G9fYuokHUBwNkTs=gWqCHxj80gg+RetU4pRd+uLP7gNas4KQ@mail.gmail.com>
 <20200925105458.567d0bf4@oasis.local.home>
 <20200925105914.7de88d27@oasis.local.home>
 <20200925110706.6654954b@oasis.local.home>
 <20200925151245.GA3180934@kroah.com>
 <20200925113049.4c10c864@oasis.local.home>
Message-ID: <20201005131833.GA1506031@kroah.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Sep 25, 2020 at 11:30:49AM -0400, Steven Rostedt wrote:
> On Fri, 25 Sep 2020 17:12:45 +0200
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> > > Specifically, commits:
> > > 
> > > a0d14b8909de55139b8702fe0c7e80b69763dcfb ("x86/mm, tracing: Fix CR2 corruption")
> > > 6879298bd0673840cadd1fb36d7225485504ceb4 ("x86/entry/64: Prevent clobbering of saved CR2 value")
> > > b8f70953c1251d8b16276995816a95639f598e70 ("x86/entry/32: Pass cr2 to do_async_page_fault()")
> > > 
> > > (which are in 5.4 but not 4.19)
> > > 
> > > But again, is this too intrusive. There was a workaround that was
> > > original proposed, but Peter didn't want any more band-aids, and did
> > > the restructuring, but as you can see from the two other patches, it
> > > makes it a bit more high risk.  
> > 
> > If those are known to work, why can't I take them as-is?
> 
> If they apply without tweaks, I say "Go for it" ;-)
> 
> My worry is that they may have other unknown dependencies. And I only
> looked at what was applied between 4.19 and 5.4 mainline. I haven't
> looked at what else may have been backported to fix the above three
> commits.

I tried to backport the above series, and quickly gave up, as yes, you
are right, the dependencies are deep and messy from what I can tell.

WHat's wrong with just moving to 5.4? :)

thanks,

greg k-h
