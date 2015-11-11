From: Jiri Jaburek <jjaburek@redhat.com>
Date: Wed, 11 Nov 2015 17:53:11 +0100
Subject: [LTP] [RFC] Getting rid of cleanup parameter
In-Reply-To: <20151111133042.GA26695@rei.lan>
References: <20151110141426.GG23947@rei>
 <138416734.6863400.1447237258306.JavaMail.zimbra@redhat.com>
 <20151111133042.GA26695@rei.lan>
Message-ID: <56437277.8020901@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 11/11/2015 02:30 PM, Cyril Hrubis wrote:
> Hi!
>> Just thinking loud, how this would work:
>>
>> Is the scope of cleanup set with tst_set_cleanup() going to be per process?
>> For example: If I call tst_set_cleanup() and then fork couple children,
>> will they automatically ignore cleanup function set in parent?
> 
> It has to be per process, since othewise we would have the callback
> called twice problem again. I.e. the callback set in test setup() would
> be executed only if tst_* call that caused exit was called from the same
> process it has been set up.
> 
>> Can I use tst_set_cleanup() in child process to setup child-specific
>> cleanup function?
> 
> Currently I would do it so that only the main test process can setup the
> callback in order to make it simpler. Since so far I haven't found a
> situation where the parent process cannot easily cleanup after it's
> children and doing cleanup once decreases the possibility of races in
> concurently executed cleanups. Imaginge 100 children cleaning after
> themselves, it's easy to mess up when 100 cleanup functions are running
> at the same time.
> 
> But if you found good usecase we may also allow per-child cleanups.

This may be the case when a test spawns multiple children to do the
testing in parallel, with the children creating shared resources of
unpredictable names/references (so the cleanup cannot be done from
the parent).

I currently cannot think of any such resource,

 * files can use tmpdir, removed recursively from parent
 * spawned processes can be walked from the parent
 * losetup-created devices can have a common prefix
 * IPC shared resources can be pre-created by the parent
   (or be found via a unique key or a dedicated unix user)
 * linux namespaces die automatically with the children
 * ...

The general pattern is that the parent is always able to somehow use
an identifier common for all children or pre-create the resources for
them, collecting a list to be used for cleanup.

However it would be good to keep the use case in mind for the future.

Regarding tst_set_cleanup() - if it hooks the cleanup function into
signal handlers as well, it will need to be called before sigaction
setup in signal-testing tests. Nothing extraordinary, I guess, but
still something to note.

About shell tests - maybe something similar would be useful, for
consistency (same function name) as well as signal handling (trap)
in shells that support it. Again - same signal handling limitations
apply (if test re-defines trap, it may be an issue).

> 
>>> When the cleanup
>>> function was set with this interface the cleanup paramter for all
>>> functions would be ignored (we may create static inline wrappers that
>>> sets it to NULL to be used from new code).
>>
>> And perhaps trigger a warning/TBROK if user tries to pass non-NULL
>> value while he's using the new tst_set_cleanup() approach.
> 
> Yep.
> 

