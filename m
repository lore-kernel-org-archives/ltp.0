From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 21 May 2019 13:48:53 +0200
Subject: [LTP] [RFC PATCH 0/1] Fix return value checks for posix apis
In-Reply-To: <20190521044148.GC7753@google.com>
References: <20190520041730.28238-1-sspatil@android.com>
 <20190520094949.GA25405@rei.lan> <20190521044148.GC7753@google.com>
Message-ID: <20190521114853.GD13910@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > > PATCH 1/1 demonstrates the fixes needed for pthread_sigmask/6-1 for
> > > example. This pattern is fairly widespread in open_posix_testsuite.
> > > 
> > > After going through the documentation in the project, I wasn't sure if I
> > > tested this correctly. After building, I tried the following
> > > 
> > > $ cd testcases/open_posix_testsuite
> > > $ ./bin/run_tesit.sh conformance/interfaces/pthread_sigmask pthread_sigmask_6-1.run-test
> > > 
> > > ...and that keeps running into test being skipped due to missing file.
> > > (I do have pthread_sigmask_6-1.run-test in place).
> > 
> > Actually I always just run the binary, so in this case doing
> > ./pthread_sigmask_6-1.run-test should suffice.
> 
> Ok, I'll try that, but IIRC it did nothing on my laptop. I'll retry.

Looks like the test does not print anything unless there is a failure.

Well the convention in openposix testsuite I started to follow is to
print "Test PASSED" in such case, so this should be fixed (in a
separate patch) as well.

-- 
Cyril Hrubis
chrubis@suse.cz
