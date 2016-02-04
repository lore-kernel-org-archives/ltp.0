From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 4 Feb 2016 16:11:00 +0100
Subject: [LTP] [PATCH] ftrace_stress_test: check if tracing_enabled is
 supported
In-Reply-To: <1454598367.1195.45.camel@fedora>
References: <1450934523-69837-1-git-send-email-chuhu@redhat.com>
 <20160204142830.GA11527@rei.lan> <1454598367.1195.45.camel@fedora>
Message-ID: <20160204151100.GA15075@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Looking at the commits shouldn't we use tracing_on instead of
> > tracing_enabled on newer kernels?
> > 
> 
> Yes, and you should be using tracing_on even in older kernels.
> tracing_enabled has been deprecated for a long time now.

Also looking at the stress test all it does is writing to various files
(in several background loops) that store tracing parameters. Is that
even reasonable test? I guess that it can find out race conditions
between functions that handle the write for the options...

And it uses the tracing_on file as well. So we can just skip starting
the loop writes to the ftrace_enabled file if it's not present.

-- 
Cyril Hrubis
chrubis@suse.cz
