From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 16 Oct 2017 12:22:59 +0200
Subject: [LTP] [PATCH v2 3/4] syscalls/keyctl07: new test for oops when
 reading negative key
In-Reply-To: <20171012204227.116510-4-ebiggers3@gmail.com>
References: <20171012204227.116510-1-ebiggers3@gmail.com>
 <20171012204227.116510-4-ebiggers3@gmail.com>
Message-ID: <20171016102259.GB29957@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've pushed all patches but this one, since it actually looks like a
test bug when we oops the kernel since the test gets SIGKILL, which is
the same signal the library uses for a timeout:

 $ ./keyctl07
 tst_test.c:958: INFO: Timeout per run is 0h 05m 00s
 keyctl07.c:72: INFO: trying to read from the negative key...
 tst_test.c:1008: INFO: If you are running on slow machine, try
 exporting LTP_TIMEOUT_MUL > 1
 tst_test.c:1009: BROK: Test killed! (timeout?)

Can we, pretty please, run the test in a child process and wait it in
the test function and report a failure instead? I fear that kind of test
output will confuse people into thinking that this is a test problem
rather than a kernel bug.

-- 
Cyril Hrubis
chrubis@suse.cz
