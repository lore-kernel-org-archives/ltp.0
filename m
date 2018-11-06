From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 6 Nov 2018 17:05:07 +0100
Subject: [LTP] [PATCH] kernel/syscall/setrlimit05.c: use a legal bad
 address for mips
In-Reply-To: <5665e310-b1f1-60e5-6aa7-289eba6cf6a9@windriver.com>
References: <1541403031-141386-1-git-send-email-hongzhi.song@windriver.com>
 <20181105152237.GA3478@rei>
 <5665e310-b1f1-60e5-6aa7-289eba6cf6a9@windriver.com>
Message-ID: <20181106160507.GG3014@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > It would be better if we called this only once in the test setup()
> > function as the function actually maps a page of memory, the test may
> > fail if we pass large enough -i parameter.
> 
> This case just runs one time. But I still send V2 with using setup() to 
> apply memory.

All tests have command line parameters and one of them is -i which can
be used to execute the test in a loop.

-- 
Cyril Hrubis
chrubis@suse.cz
