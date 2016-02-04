From: Steven Rostedt <srostedt@redhat.com>
Date: Thu, 04 Feb 2016 11:23:08 -0500
Subject: [LTP] [PATCH] ftrace_stress_test: check if tracing_enabled is
 supported
In-Reply-To: <20160204151100.GA15075@rei.suse.cz>
References: <1450934523-69837-1-git-send-email-chuhu@redhat.com>
 <20160204142830.GA11527@rei.lan> <1454598367.1195.45.camel@fedora>
 <20160204151100.GA15075@rei.suse.cz>
Message-ID: <1454602988.1195.56.camel@fedora>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, 2016-02-04 at 16:11 +0100, Cyril Hrubis wrote:

> Also looking at the stress test all it does is writing to various files
> (in several background loops) that store tracing parameters. Is that
> even reasonable test? I guess that it can find out race conditions
> between functions that handle the write for the options...

I don't use the LTP tests for ftrace, so I wouldn't know.

> 
> And it uses the tracing_on file as well. So we can just skip starting
> the loop writes to the ftrace_enabled file if it's not present.
> 

ftrace_enabled is completely different. It disables function tracing
capabilities (and should be avoided
if /sys/kernel/debug/tracing/options/function-trace is present. As that
will only disable function hooks for tracing,
where /proc/sys/kernel/ftrace_enabled disables *all* hooks (including
those for live kernel patching). Which I need to make a patch to prevent
that :-/

-- Steve


