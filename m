From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 15 Jan 2019 14:03:27 +0100
Subject: [LTP] LTP: '/proc/self/io' for reading at readahead02.c:113:
 ENOENT No such file or directory
In-Reply-To: <CA+G9fYvA4XWajkvS9pP8vpFjPx=j+3F9TiueUrGjQ2RQ8vJiAQ@mail.gmail.com>
References: <CA+G9fYvA4XWajkvS9pP8vpFjPx=j+3F9TiueUrGjQ2RQ8vJiAQ@mail.gmail.com>
Message-ID: <20190115130327.GA4677@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Agree with Rafael here, the test was passing by accident.

Fixed in:

https://github.com/linux-test-project/ltp/commit/a78e15494bfdc6be68026031ee6d7abd1e7ae9f2

Now the test should report skipped status.

-- 
Cyril Hrubis
chrubis@suse.cz
