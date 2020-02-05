From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 5 Feb 2020 20:10:32 +0100
Subject: [LTP] [PATCH 2/2] Fix BPF test program loading issues
In-Reply-To: <2c7e9545-93e3-3460-6006-5e57b982ecc7@suse.cz>
References: <20200203113956.13176-1-mdoucha@suse.cz>
 <20200203113956.13176-2-mdoucha@suse.cz>
 <20200205143107.GC30186@rei>
 <fda46288-1850-8ac9-1c56-7641aaeb8759@suse.cz>
 <20200205155012.GA4920@rei>
 <2c7e9545-93e3-3460-6006-5e57b982ecc7@suse.cz>
Message-ID: <20200205191006.GA18877@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > That's only true if we are building and external interface for a
> > library, here we are just avoiding copy&paste by the simpliest means
> > available.
> 
> I am building external interface for a library. The library is called
> bpf_common. But if you still disagree with splitting the executable code
> into a separate file to make the header more readable for developers of
> future BPF tests, I'll gladly unassign myself from this task and go work
> on something else.

Can we please discuss things calmly and rationally? If you want to give
up on your patch that's fine, however if you want to continue to discuss
technical details, let's do it without emotions, okay?

Getting back to the technical point of the discussion, I still do not
consider that these three functions are complex enough to be split into
header and C source, but I do not have such strong opinion about that.

So if you really think that it should be separated like that at least
put the change that moves the code into a separate patch, since that is
unrelated change to introduction of the new function.

-- 
Cyril Hrubis
chrubis@suse.cz
