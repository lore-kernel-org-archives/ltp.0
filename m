From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Fri, 12 Feb 2021 14:09:06 +0000
Subject: [LTP] [PATCH v2 5/5] close_range: Add test
In-Reply-To: <YCaBOqMhTqNlRhH5@yuki.lan>
References: <20210211174543.25003-1-rpalethorpe@suse.com>
 <20210211174543.25003-6-rpalethorpe@suse.com> <YCaBOqMhTqNlRhH5@yuki.lan>
Message-ID: <871rdl5qf1.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
> Pushed with small changes, thanks.
>
> * Added a runtest file entry
>
> * Add .needs_root which is what we have for tests that utilize loop
> devices

Ah, of course. I guess in that case we may also want to drop
CAP_SYS_ADMIN in caps.

>
> * Reformatted the top level comment so it's picked by docparser
>
> * Shortened the git hash to 12 characters, since that's what we have in
>   the rest of the tests
>

Ah, OK.

>
> Also we are missing simple test for a negative cases, that is:
>
> * Check that EINVAL is returned if we pass ~0 to flags
>
> * And check that EINVAL is returned when fd < fd_max as well
>
>
> And one more a bit more complicated test:
>
> We should also get EMFILE if we do CLOSE_RANGE_UNSHARE and the parent
> rlimit is exhausted.

Indeed those may be missing in the self tests as well.

>
>
> Will you write these tests as well, or should I have a look?

If you want to do it today very quickly, then feel free. Otherwise I
will do it next week.

-- 
Thank you,
Richard.
