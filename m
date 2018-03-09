From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 9 Mar 2018 07:14:53 -0500 (EST)
Subject: [LTP] [PATCH] mallocstress: extend test time on arm
In-Reply-To: <20180309120414.GD24656@rei>
References: <981e2a8523db8616a4ed442635a493928376489d.1520589632.git.jstancek@redhat.com>
 <20180309104146.GA28698@rei>
 <2012939043.6317537.1520592935484.JavaMail.zimbra@redhat.com>
 <20180309120414.GD24656@rei>
Message-ID: <2036057253.6329684.1520597693294.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi!
> > Just wanted to go with minimal impact on other arches (since they worked
> > OK so far as I'm aware). I don't have strong opinion either way,
> > I can make the timeout unconditional.
> 
> Given that the test seems to take 4m on successful run 5m timeout seems
> to be a bit too strict to me. We are not primarily benchmarking the
> kernel, so these timeouts are better to be set to be double of the
> expecte runtime.
> 
> Also I like to avoid #ifdefs whenever possible.

Pushed with your ACK as unconditional test time change to 10m.

Regards,
Jan
