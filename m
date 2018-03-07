From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 7 Mar 2018 11:52:15 +0100
Subject: [LTP] LTP API documentation
In-Reply-To: <CA+bK7J7jetfNOpXmxstQtC-_-gbzb0ko8OV8rjRnYp7BbR7JAw@mail.gmail.com>
References: <CA+bK7J7jetfNOpXmxstQtC-_-gbzb0ko8OV8rjRnYp7BbR7JAw@mail.gmail.com>
Message-ID: <20180307105215.GC9871@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Where is the API documentation, for stuff like tst_* and SAFE_*
> and 'struct tst_test'
> 
> I looked in ltp/docs and on the wiki, but couldn't seem to find it.

It's named test-writing-guidelines, which arguably is a bit confusing
but its there:

ltp/doc/test-writing-guidelines.txt or
https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines

And we also have nice C testcase tutorial:

doc/c-test-tutorial-simple.txt or
https://github.com/linux-test-project/ltp/wiki/C-Test-Case-Tutorial

-- 
Cyril Hrubis
chrubis@suse.cz
