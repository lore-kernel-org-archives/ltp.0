From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 30 Jun 2017 16:45:37 +0200
Subject: [LTP] [PATCH] tutorial: Add a step-by-step C test tutorial
In-Reply-To: <87y3s9y2ke.fsf@our.domain.is.not.set>
References: <20170629142724.20004-1-rpalethorpe@suse.com>
 <20170630113858.GA18305@rei.lan>
 <87y3s9y2ke.fsf@our.domain.is.not.set>
Message-ID: <20170630144537.GD18305@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >> +If you have begun to explore the LTP library headers or older tests then you
> >> +may have come across functions from the old API such as 'tst_brkm'. The first
> >> +argument of 'tst_brkm' is a pointer to a cleanup function and it does not use
> >> +the 'tst_test' structure. The old API is being phased out, so you should not
> >> +use these functions.
> >
> > I would have removed the sentence that describes the old API. All that
> > reader needs to know at this point is that it lives simultaneously to
> > the new one and that it's being phased out.
> >
> > The first rule of the old API is that we do not talk about the old API.
> > Unless we do, of course, but we should at least pretend that we dont
> > :-).
> 
> I take this to mean that you want me to remove the middle sentence and
> not the whole paragraph.

Exactly.

> >> +So far the 'statx' test and its 'cleanup' function are very simple. Our
> >> +example doesn't answer the question "what happens if part of the cleanup
> >> +fails?". We can answer this by modifying the test to call 'statx' on a
> >> +symbolic link instead of the original file. This naturally expands our 'setup'
> >> +and 'cleanup' callbacks. I will just include the relevant parts below.
> >> +
> >> +[source,c]
> >> +--------------------------------------------------------------------------------
> >> +#define SNAME "This is an additional name for the file"
> >                     ^
> > 		    Here again just "test_file_symlink" or something.
> 
> :-(
> 
> OK.

Why the sad smile?

The problem I see with this is that running the code will create files
with spaces in it, which is kind of ugly and may lead to strange
behavior. So at least replace the spaces with an underscores.

> >> +However this code is not following best practices. Generally you should avoid
> >> +creating lots of unnecessary warning messages by checking if a resource exits
> >> +before attempting to clean it up. If 'SAFE_TOUCH' or 'SAFE_SYMLINK' failed, we
> >> +will already have an error message for that. It is not necessary to check if
> >> +the file actually exists before calling 'SAFE_UNLINK', instead we can use a
> >> +heuristic, such as checking if a variable has been set (see the mount example
> >> +in 2.2.1 of the test writing guide).
> >
> > Also the test library removes the temporary directory recursively,
> > hence we may as well note here that this kind of cleanup is not needed
> > at all.
> 
> It says in the Test Writing Guidelines that we should delete it manually
> due to funny behavior on NFS? If this is not the case then I should
> contrive another reason to have cleanup.

No, the funny behavior is more complicated than that. The problem
happens when you have a file on NFS, then you unlink it but happen to
keep file descriptor open that references it. In that case the file is
simply renamed to start with a dot (to be hidden from the user) and
prevents the temporary directory from being removed.

So we advise to close file descriptors in test cleanup to avoid that
situation.

> > I guess that we should probably cover forking in a sepratate document
> > like this one.
> 
> If people read this document :-p. I'm sure they will, but it might be
> useful to get some feedback first.

Sure.

-- 
Cyril Hrubis
chrubis@suse.cz
