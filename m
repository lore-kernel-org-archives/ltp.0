From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 21 May 2019 13:46:29 +0200
Subject: [LTP] [RFC PATCH 1/1] open_posix_testsuite/pthread_sigmask: fix
 return value checks
In-Reply-To: <20190521044001.GB7753@google.com>
References: <20190520041730.28238-1-sspatil@android.com>
 <20190520041730.28238-2-sspatil@android.com>
 <20190520095356.GB25405@rei.lan> <20190521044001.GB7753@google.com>
Message-ID: <20190521114629.GC13910@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > The error(3) is GNU extension we cannot use it in a POSIX testsuite as
> > such, I guess that we will have to add custom error reporting functions
> > (in a separate patch) to the open_posix_testsuite/include/posixtest.h
> > header...
> > 
> > Other than that the patch is obviously correct.
> 
> Thanks you want me to add an error(3)-like function there?
> I guess I can do that and then start changing all tests.

If you think that error(3) like API is best fit then we can go ahead and
use it for posix testsuite. You can also think about it a bit and maybe
create something that will fit the purpose slightly better.

Only thing I would have avoided is to give the function names that are
likely to collide with test code. I would expect that there are several
tests that use error as a variable, so if we decide to name the function
that way we should prefix it with pts_ e.g. pts_error().

-- 
Cyril Hrubis
chrubis@suse.cz
