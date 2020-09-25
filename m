From: Steven Rostedt <rostedt@goodmis.org>
Date: Fri, 25 Sep 2020 10:59:14 -0400
Subject: [LTP] [stable 4.19] [PANIC]: tracing: Centralize preemptirq
 tracepoints and unify their usage
In-Reply-To: <20200925105458.567d0bf4@oasis.local.home>
References: <20180823023839.GA13343@shao2-debian>
 <20180828195347.GA228832@joelaf.mtv.corp.google.com>
 <CA+G9fYtV_sjTKLMXWMP0w0A-H+p+CN-uVJ6dvHovDy9epJZ2GQ@mail.gmail.com>
 <20200925051518.GA605188@kroah.com>
 <CA+G9fYuokHUBwNkTs=gWqCHxj80gg+RetU4pRd+uLP7gNas4KQ@mail.gmail.com>
 <20200925105458.567d0bf4@oasis.local.home>
Message-ID: <20200925105914.7de88d27@oasis.local.home>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, 25 Sep 2020 10:54:58 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:


> The crash looks like its cr3 related, which I believe Peter Zijlstra

s/cr3/cr2/

-- Steve


> did a restructuring of that code to not let it be an issue anymore.
> I'll have to look deeper. The rework may be too intrusive to backport,
> but we do have other work arounds for this issue if that would be
> acceptable for backporting.
> 
