From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 9 Mar 2018 05:55:35 -0500 (EST)
Subject: [LTP] [PATCH] mallocstress: extend test time on arm
In-Reply-To: <20180309104146.GA28698@rei>
References: <981e2a8523db8616a4ed442635a493928376489d.1520589632.git.jstancek@redhat.com>
 <20180309104146.GA28698@rei>
Message-ID: <2012939043.6317537.1520592935484.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> Hi!
> > Arm systems with lot of memory and THP enabled are
> > hitting a timeout at ~5 minute mark as reported here:
> >   mallocstress poor performance with THP on arm64 system
> >   https://marc.info/?l=linux-mm&m=151864950330870&w=2
> > 
> > Extend the timeout to 10m (only for arm).
> 
> What about extending it unconditionally? It's not like it will hurt in
> generall case and there are possible other slow systems that would
> benefit from that as well.
> 
> Or do you have a strong reason to extend the timeout only on arm?

Just wanted to go with minimal impact on other arches (since they worked
OK so far as I'm aware). I don't have strong opinion either way,
I can make the timeout unconditional.

Regards,
Jan
