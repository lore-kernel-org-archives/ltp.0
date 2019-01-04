From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 4 Jan 2019 12:36:17 +0100
Subject: [LTP] [PATCH v6] syscalls/statx: Add test for sync flags
In-Reply-To: <1545807270-3790-1-git-send-email-vaishnavi.d@zilogic.com>
References: <1545807270-3790-1-git-send-email-vaishnavi.d@zilogic.com>
Message-ID: <20190104113617.GA22914@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've been playing with this test and apart from minor things there is
one problem that has to be fixed. It looks like the nfs cache is not
fully deterministic.

For instance the test fails on freshly booted machine, then line about
initializing nfs fs cache appears in kernel log. From that point on the
probability of failure is small but still not neglectible.

So for now I would like to skip this test from being included in the
release, then once LTP is released I will return to it and try to figure
out how to fix it.

-- 
Cyril Hrubis
chrubis@suse.cz
