From: Li Wang <liwang@redhat.com>
Date: Thu, 16 Jul 2020 19:40:43 +0800
Subject: [LTP] [v2,2/2] ioperm: Convert to new API
In-Reply-To: <20200716091528.GA6383@dell5510>
References: <20200716061059.30525-2-liwang@redhat.com>
 <20200716091528.GA6383@dell5510>
Message-ID: <CAEemH2fjYqGtOn9roAoUa_9CEdAMeSEt+WYG+vipdWaWqx6Pcg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

On Thu, Jul 16, 2020 at 5:15 PM Petr Vorel <pvorel@suse.com> wrote:

> Hi Li,
>
> Actually it fails to build on non-intel.
> https://travis-ci.org/github/pevik/ltp/jobs/708655670
> /usr/src/ltp/testcases/kernel/syscalls/iopl/iopl02.c:21:10: fatal error:
> sys/io.h: No such file or directory
> 9793 #include <sys/io.h>
>
> https://travis-ci.org/github/pevik/ltp/builds/708655668
>
> <sys/io.h> needs to be included behind #if defined __i386__ ||
> defined(__x86_64__) guarder.
>

Thanks for catching this, I have fixed it and pushed.


-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200716/a795b7e5/attachment.htm>
