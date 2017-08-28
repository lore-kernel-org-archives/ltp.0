From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 28 Aug 2017 10:39:05 +0200
Subject: [LTP] RFC: Drop support for libnuma API version < 2
Message-ID: <20170828083904.4kc7ndp2jdwugs7f@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

I'm just about to rewrite mbind/mbind01 test to new API. This test (and some other tests)
still support libnuma API version < 2. Libnuma version 2 was released in 2008. Do we still want
to support older versions?


Kind regards,
Petr
