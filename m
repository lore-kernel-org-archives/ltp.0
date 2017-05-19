From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 19 May 2017 14:23:26 +0200
Subject: [LTP] [PATCH v3 3/3] ltp/numa: use string to describe operation
In-Reply-To: <20170519082724.10232-1-liwang@redhat.com>
References: <20170519082724.10232-1-liwang@redhat.com>
Message-ID: <20170519122326.GA17258@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've tested and pushed the patchset, thanks.

And also found that memhog test fails on first iteration (when the
memhog binary is not in the page cache) because the test script runs too
fast and looks at the statistics even befor the memmhog binary has a
chance to run. The problem can be simulated for me by dropping caches by

echo 3 > /proc/sys/vm/drop_caches

then running the test.

I guess that the best solution would be to wait for the memhog to print
at least one dot before we start the actuall test. Unfortunatelly I
cannot think of any better solution than redirectiong the output to a
file and then checking the content in the script in a loop.

-- 
Cyril Hrubis
chrubis@suse.cz
