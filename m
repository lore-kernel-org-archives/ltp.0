From: Sandeep Patil <sspatil@google.com>
Date: Mon, 13 Aug 2018 08:46:18 -0700
Subject: [LTP] [PATCH] tracing: ftrace_lib: check if tracing_max_latency
 exists.
In-Reply-To: <20180810125741.GC32275@rei.lan>
References: <20180808234019.241238-1-sspatil@google.com>
 <20180810125741.GC32275@rei.lan>
Message-ID: <20180813154618.GC140438@sspatil-desktop.mtv.corp.google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Aug 10, 2018 at 02:57:41PM +0200, Cyril Hrubis wrote:
> Hi!
> > This avoids unnecessary error in ftrace stress test when the
> > kernel being tested does not have CONFIG_TRACER_MAX_TRACE defined.
> > 
> > Signed-off-by: Sandeep Patil <sspatil@google.com>
> > ---
> >  testcases/kernel/tracing/ftrace_test/ftrace_lib.sh | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_lib.sh b/testcases/kernel/tracing/ftrace_test/ftrace_lib.sh
> > index 20cf5e760..ec4f7a557 100755
> > --- a/testcases/kernel/tracing/ftrace_test/ftrace_lib.sh
> > +++ b/testcases/kernel/tracing/ftrace_test/ftrace_lib.sh
> > @@ -100,7 +100,9 @@ restore_old_setting()
> >  
> >  	echo nop > current_tracer
> >  	echo 0 > events/enable
> > -	echo 0 > tracing_max_latency 2> /dev/null
> > +	if [ -e tracing_max_latency ]; then
> > +		echo 0 > tracing_max_latency 2> /dev/null
> > +	fi
> 
> I guess that we can remove the 2> /dev/null that I suppose was supposed
> to silence the error. Does it work okay for you without the redirection?

Yes, just tested it. Works for me. Want me to send the patch removing it?

- ssp
> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz
