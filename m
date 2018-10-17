From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 17 Oct 2018 12:51:31 +0200
Subject: [LTP] [PATCH] open_posix_testsuite/mmap24-2: Relax condition a
 bit
In-Reply-To: <6a9f7bb4-413f-60d2-297f-898ffa341458@windriver.com>
References: <1539226733-18212-1-git-send-email-hongzhi.song@windriver.com>
 <20181016130209.GB6980@rei>
 <21d93aaa-3047-42b4-cb8e-747ef1036a53@windriver.com>
 <20181017083945.GA4192@rei.lan>
 <6a9f7bb4-413f-60d2-297f-898ffa341458@windriver.com>
Message-ID: <20181017105131.GB4192@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> How about to skip mips arch by using "ifdef __mips__" ?
> Otherwise the test will failed on mips.

There are other POSIX-like systems that runs on mips that may need to
run the test, the best course of action would be skipping the test in
the testrunner that you use to run the tests.

That gives a question, how do you run these testcases? Do you run these
by typing in the 'make test'?

-- 
Cyril Hrubis
chrubis@suse.cz
