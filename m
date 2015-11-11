From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 11 Nov 2015 14:30:43 +0100
Subject: [LTP] [RFC] Getting rid of cleanup parameter
In-Reply-To: <138416734.6863400.1447237258306.JavaMail.zimbra@redhat.com>
References: <20151110141426.GG23947@rei>
 <138416734.6863400.1447237258306.JavaMail.zimbra@redhat.com>
Message-ID: <20151111133042.GA26695@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Just thinking loud, how this would work:
> 
> Is the scope of cleanup set with tst_set_cleanup() going to be per process?
> For example: If I call tst_set_cleanup() and then fork couple children,
> will they automatically ignore cleanup function set in parent?

It has to be per process, since othewise we would have the callback
called twice problem again. I.e. the callback set in test setup() would
be executed only if tst_* call that caused exit was called from the same
process it has been set up.

> Can I use tst_set_cleanup() in child process to setup child-specific
> cleanup function?

Currently I would do it so that only the main test process can setup the
callback in order to make it simpler. Since so far I haven't found a
situation where the parent process cannot easily cleanup after it's
children and doing cleanup once decreases the possibility of races in
concurently executed cleanups. Imaginge 100 children cleaning after
themselves, it's easy to mess up when 100 cleanup functions are running
at the same time.

But if you found good usecase we may also allow per-child cleanups.

> > When the cleanup
> > function was set with this interface the cleanup paramter for all
> > functions would be ignored (we may create static inline wrappers that
> > sets it to NULL to be used from new code).
> 
> And perhaps trigger a warning/TBROK if user tries to pass non-NULL
> value while he's using the new tst_set_cleanup() approach.

Yep.

-- 
Cyril Hrubis
chrubis@suse.cz
