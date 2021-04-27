From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 27 Apr 2021 16:35:37 +0200
Subject: [LTP] [PATCH 3/4] RFC: Add rtnetlink helper library
In-Reply-To: <ceb5f5b5-2efd-beaf-e617-7fa0b28c0ff2@suse.cz>
References: <20210426111918.4304-1-mdoucha@suse.cz>
 <20210426111918.4304-4-mdoucha@suse.cz> <YIgUcqIhXVgiqaMu@yuki>
 <ceb5f5b5-2efd-beaf-e617-7fa0b28c0ff2@suse.cz>
Message-ID: <YIghOWTqlx3W0ol/@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > You are calling safe_realloc() here yet you check the return value. And
> > it's the same for safe_malloc(), safe_bind(), safe_socket() and a few
> > more in the code.
> > 
> > So either we get rid of the error checks and of the error
> > propagation or we avoid using safe_ variants.
> 
> Both rtnetlink and netdevice management functions will be called in
> cleanup() so I have to assume that the safe functions will only print a
> warning instead of terminating the program. But I still want to use the
> error reporting code in the safe functions.

Right, I've realized that too, we have to return to the caller in that
case to carry on with the cleanup.

> > Other than that the code looks sane but it's hard to review the API
> > without an example that would excersize it. What about adding something
> > simple in newlib_tests?
> 
> There are short examples for both rtnetlink and netdevice management in
> the cover letter. The netdevice library itself is also a detailed
> example for the rtnetlink API. The final patchset will include the
> SADDNS CVE test which will use most of the netdevice management
> functions in setup().

Ah I've missed that. We should add it somewhere to the doc/ directory
since the cover letter would end up burried in the mailing list history.

-- 
Cyril Hrubis
chrubis@suse.cz
