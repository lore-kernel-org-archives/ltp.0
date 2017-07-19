From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 19 Jul 2017 11:39:45 +0200
Subject: [LTP] [PATCH v3 2/9] Test for vulnerability CVE-2016-7117 in
 recvmmsg error return path
In-Reply-To: <20170623122211.29575-3-rpalethorpe@suse.com>
References: <20170623122211.29575-1-rpalethorpe@suse.com>
 <20170623122211.29575-3-rpalethorpe@suse.com>
Message-ID: <20170719093945.GB1015@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've added a #include "config.h" to the test to include the config
created by configure explicitly. At the moment it's included via one
of the headers included from the tst_test.h but that may change in the
future.

Also when I tried to run the test my too early percentage seems to start
at a pretty low number then climbs to nearly 100% steadily, which seems
to be strange since the delay is more or less the same all the time. I
will look into this later if time permits.

-- 
Cyril Hrubis
chrubis@suse.cz
