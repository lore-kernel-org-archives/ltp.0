From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 9 Feb 2016 17:43:52 +0100
Subject: [LTP] Test library API changes
In-Reply-To: <20160208180211.GE9844@rei>
References: <20160105111136.GA32659@rei.lan>
 <1146864418.5284131.1452171696007.JavaMail.zimbra@redhat.com>
 <20160204105638.GA4615@rei> <20160208180211.GE9844@rei>
Message-ID: <20160209164352.GC11823@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
This time I've added functionality to handle child processes:

https://github.com/metan-ucw/ltp/blob/master/include/tst_test.h#L48

This function forks a child, runs the function and propagates the
results to the parent process via pipe.

The function is implemented at:

https://github.com/metan-ucw/ltp/blob/master/lib/tst_test.c#L129

And used in newly converted test at:

https://github.com/metan-ucw/ltp/blob/master/testcases/kernel/syscalls/creat/creat04.c

Whith this the core test library API is more or less sketched.

PS: I would appreciate any comments.

-- 
Cyril Hrubis
chrubis@suse.cz
