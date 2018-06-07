From: Li Wang <liwang@redhat.com>
Date: Thu, 7 Jun 2018 17:01:08 +0800
Subject: [LTP] [PATCH] [RFC] syscalls/ipc: Rename some msgctl tests
In-Reply-To: <20180607084522.GA2699@rei.lan>
References: <20180606123735.15589-1-chrubis@suse.cz>
 <CAEemH2fxCoLB7S42xZKnT=4wFvTS-875AhvksFD3atYmjfPMWg@mail.gmail.com>
 <20180607084522.GA2699@rei.lan>
Message-ID: <CAEemH2ef7TCL89-8N+ciQ63tA59sN1Swi=82ED3tAviALNkQdQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Jun 7, 2018 at 4:45 PM, Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > Agreed. These tests fork too many times, and they often trigger OOM at
> > runtime. So I think this patch make sense.
> > ???
> > Another thought of mine is that to remove them from the ltplite and
> > syscalls runtest file. what about just putting them in stress.part3?
>
> These shouldn't be part of ltplite for sure, I will remove them in a
> follow up patch. I would like to keep them in the syscalls runtest file
> though and make sure that they scale better accordingly to system
> RAM/CPUs later on.
>

Great. It sounds good to adjust their fork numbers according to the system
config.


> --
> Cyril Hrubis
> chrubis@suse.cz
>



-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180607/faff90da/attachment.html>
