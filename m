From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 23 Jan 2017 13:19:48 +0100
Subject: [LTP] [PATCH] fanotify: Add test for permission event
	destruction
In-Reply-To: <20170120132951.10312-1-jack@suse.cz>
References: <20170120132951.10312-1-jack@suse.cz>
Message-ID: <20170123121947.GB22484@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Just FYI we have switched to a new test library for all new testcases
quite some time ago, you can have a look at the documentation on our
wiki[1], or look at a comparsion of the same test I've prepared for a
lwn.net article[2].

I can convert the test if you want, it's not complicated, but please
keep in mind to use the new library API next time you start writing a
testcase.

[1]: https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#22-writing-a-test-in-c
[2]: article: https://lwn.net/Articles/708182/ (see most notable changes)
     old test: https://lwn.net/Articles/708250/
     new test: https://lwn.net/Articles/708251/

-- 
Cyril Hrubis
chrubis@suse.cz
