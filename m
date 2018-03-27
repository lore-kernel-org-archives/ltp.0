From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 27 Mar 2018 16:08:35 +0200
Subject: [LTP] [PATCH] Make floating point tests Android-compatible
In-Reply-To: <CAFt2AZUhp9tuWOVd-t-ij-eG-21+DEqeXE5XCwK=tQ8DmOnAgg@mail.gmail.com>
References: <CAFt2AZUhp9tuWOVd-t-ij-eG-21+DEqeXE5XCwK=tQ8DmOnAgg@mail.gmail.com>
Message-ID: <20180327140835.GB28115@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Android does not implement pthread_cancel. The function is replaced
> by a no-op in a compatibility header. In most cases, the only side
> effect is that threads cannot be interrupted and have to exit normally.
> However, floating point tests are calling pthread_cancel and waiting for
> a thread doing pthread_sigwait to be finished (Which will never happen).
> 
> This patch implements the same logic using pthread_kill with SIGUSR2
> instead, allowing the tests to run under Android.

First of all the patch is mangled, probaly by your email client, check
its settings for attachements.

Secondly, looking at the patch, do we really have to join the signal
handler thread at the end? Cannot we just delete the the
pthreat_cancel() and pthread_join() for the sig_hand and be done with
it?

-- 
Cyril Hrubis
chrubis@suse.cz
