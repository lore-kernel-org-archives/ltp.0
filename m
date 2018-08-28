From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 28 Aug 2018 14:58:08 +0200
Subject: [LTP] [PATCH v2 1/2] lib: add tst_get_timeout()
In-Reply-To: <6680bda80c85d424a5219d9f55dc9c5355dc0da1.1535454204.git.jstancek@redhat.com>
References: <6680bda80c85d424a5219d9f55dc9c5355dc0da1.1535454204.git.jstancek@redhat.com>
Message-ID: <20180828125808.GB24095@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
It's just an idea, but we can make this even more elegant API.

We measure the time in the test library anyway, so what about we added
something as tst_timeout_reached() that would return number of seconds
remaining to 80% of the real timeout or 0 if in a case that the timeout
was reached. Then we can use this as a soft-timeout in all the testcases
without any additional steps.

-- 
Cyril Hrubis
chrubis@suse.cz
