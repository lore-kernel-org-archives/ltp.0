From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 11 Nov 2015 05:20:58 -0500 (EST)
Subject: [LTP] [RFC] Getting rid of cleanup parameter
In-Reply-To: <20151110141426.GG23947@rei>
References: <20151110141426.GG23947@rei>
Message-ID: <138416734.6863400.1447237258306.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: ltp@lists.linux.it
> Sent: Tuesday, 10 November, 2015 3:14:26 PM
> Subject: [LTP] [RFC] Getting rid of cleanup parameter
> 
> Hi!
> I was looking into the LTP API expecially the tst_res* part to make it
> cleaner and easier to use and one of the things I would like to change
> is how we execute the cleanup function.
> 
> Currenlty we pass the cleanup as function parameter. The 99% of the time
> we just pass the very same function to every call with the exception of
> the calls in the cleanup function itself. And the callback function is
> made in a way that it could be called at any point in the setup() as
> well.
> 
> The common mistakes with that API is that people pass cleanup() paramter
> to functions in cleanup() and to tst api in child processes. But as we
> use it now the cleanup can be set exactly once and called from the test
> library which could make sure that it's called exactly once, etc.
> 
> So my proposal is to add a call to set cleanup function,
> tst_set_cleanup(void (*cleanup)(void)) that would be called once in the
> setup and would store the function pointer, which would later be called
> either when test exits prematurely or on tst_exit().

Just thinking loud, how this would work:

Is the scope of cleanup set with tst_set_cleanup() going to be per process?
For example: If I call tst_set_cleanup() and then fork couple children,
will they automatically ignore cleanup function set in parent?
Can I use tst_set_cleanup() in child process to setup child-specific
cleanup function?

> When the cleanup
> function was set with this interface the cleanup paramter for all
> functions would be ignored (we may create static inline wrappers that
> sets it to NULL to be used from new code).

And perhaps trigger a warning/TBROK if user tries to pass non-NULL
value while he's using the new tst_set_cleanup() approach.

Regards,
Jan

> 
> Does everybody agree with this change?
> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
> --
> Mailing list info: http://lists.linux.it/listinfo/ltp
> 
