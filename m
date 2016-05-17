From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 17 May 2016 10:34:43 -0400 (EDT)
Subject: [LTP] [PATCH] creat05: count opened fds
In-Reply-To: <20160517141906.GG12051@rei.lan>
References: <04943ef887b09df79204f36b924dcf753a7b3037.1463488840.git.jstancek@redhat.com>
 <20160517141906.GG12051@rei.lan>
Message-ID: <945685507.3524681.1463495683812.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Tuesday, 17 May, 2016 4:19:06 PM
> Subject: Re: [PATCH] creat05: count opened fds
> 
> Hi!
> > This testcase estimates number of opened fds by opening
> > a new one and assuming there are no gaps. This doesn't always
> > hold true. There can be gaps if test harness that runs it
> > opens couple fds with O_CLOEXEC prior to starting creat05.
> > As result, testcase unexpectedly fails in setup.
> 
> As far as I understand it the O_CLOEXEC is not the problem here. It may
> be reproduced even without it when the test harness leaves an open fd
> after some open one, right?

Agreed, that is also one way to get "gap".

> 
> Something as:
> 
> fd0 = open("foo", ...);
> fd1 = open("bar", ...);
> close(fd0);
> fork();
> if (!pid)
> 	exec("creat05");
> 
> 
> And in that case the testcase can do even without listing the
> /proc/self/fd. Since POSIX specifies that we get the smallest unused fd
> for each creat() we can just call it in a loop until the resulting
> fd == max_fd - 1.

We could do that. It's quite unlikely that fd would be already in use.
I'll send v2 with this change.

Regards,
Jan

> We would have to allocate the array to store the fds
> so that we can close them in cleanup though.
> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
