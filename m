From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 26 Nov 2015 15:26:12 +0100
Subject: [LTP] [PATCH] mem/oom: don't fail if pthread_create hits EAGAIN
In-Reply-To: <3c782728d90f07391df826231c7327a2ddf38540.1448451542.git.jstancek@redhat.com>
References: <3c782728d90f07391df826231c7327a2ddf38540.1448451542.git.jstancek@redhat.com>
Message-ID: <20151126142612.GD9276@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> In a rare situation on system with many CPUs, small RAM
> and overcommit_memory == 2, threads that are already started
> can create memory pressure, that causes pthread_create
> to hit EAGAIN. Don't fail the test, keep going with threads
> that are already spawned.

It took me a while to figure out what are trying to fix, but I think I
understand now.

The thing is that if we have many processors the threads running on
background allocating and faulting memory would counsume available
memory before the for() loop has chance to finish and the
ptread_create() starts to fail with EAGAIN, right?

In that case the fix looks good, acked.

-- 
Cyril Hrubis
chrubis@suse.cz
