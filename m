From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 5 Aug 2021 11:34:11 +0200
Subject: [LTP] [PATCH v3 1/3] API: TST_EXP_FAIL: Allow passing when
 errno is not checked
In-Reply-To: <87a6lwmm6c.fsf@suse.de>
References: <87czquna4l.fsf@suse.de>
 <20210803125252.16214-1-rpalethorpe@suse.com>
 <YQlhQa/q55F98Gui@yuki> <87a6lwmm6c.fsf@suse.de>
Message-ID: <YQuwk0xbFV1VZU/l@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >> This is also less surprising than giving errno == 0 a dual
> >> meaning.
> >
> > But I do agree that the current if (ERRNO) branch is confusing. I would
> > be for dropping the if (ERRNO) and checking the TST_ERR against ERRNO
> > unconditionally.
> >
> > Also note that the TEST() macro clears errno, so if a syscall fails but
> > does not report any error TST_ERR will end up 0 either way so there is
> > no need for having special handling for 0.
> 
> There is if the errno is set, but is undefined. Like if the resulting
> errno is platform or config dependent.
> 
> In the present case though we can just check for EINVAL. That is what
> the setsockopt man page indicates. Initially I wasn't sure if EFAULT
> were equally valid, but it seems not.

There was also an idea to add another version that would take an array
of possible errnos if that happens, but I fear that the complexity would
be getting out of hand if we keep adding features like that.

> I suppose we can fall back to using TEST() if the other case arises.

Yes.

-- 
Cyril Hrubis
chrubis@suse.cz
