From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Fri, 25 Sep 2020 07:15:18 +0200
Subject: [LTP] [stable 4.19] [PANIC]: tracing: Centralize preemptirq
 tracepoints and unify their usage
In-Reply-To: <CA+G9fYtV_sjTKLMXWMP0w0A-H+p+CN-uVJ6dvHovDy9epJZ2GQ@mail.gmail.com>
References: <20180823023839.GA13343@shao2-debian>
 <20180828195347.GA228832@joelaf.mtv.corp.google.com>
 <CA+G9fYtV_sjTKLMXWMP0w0A-H+p+CN-uVJ6dvHovDy9epJZ2GQ@mail.gmail.com>
Message-ID: <20200925051518.GA605188@kroah.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Sep 25, 2020 at 10:13:05AM +0530, Naresh Kamboju wrote:
> >From stable rc 4.18.1 onwards to today's stable rc 4.19.147
> 
> There are two problems  while running LTP tracing tests
> 1) kernel panic  on i386, qemu_i386, x86_64 and qemu_x86_64 [1]
> 2) " segfault at 0 ip " and "Code: Bad RIP value" on x86_64 and qemu_x86_64 [2]
> Please refer to the full test logs from below links.
> 
> The first bad commit found by git bisect.
>    commit: c3bc8fd637a9623f5c507bd18f9677effbddf584
>    tracing: Centralize preemptirq tracepoints and unify their usage
> 
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>

So this also is reproducable in 5.4 and Linus's tree right now?

Or are newer kernels working fine?

thanks,

greg k-h
