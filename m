From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Wed, 30 Aug 2017 10:13:35 +0200
Subject: [LTP] thp01 is broken on kernel 4.12+
Message-ID: <87ziahbhhs.fsf@our.domain.is.not.set>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

The test thp01 is broken due to a measure to prevent "stack clash". See
da029c11e6b1 ("exec: Limit arg stack to at most 75% of _STK_LIM") for
details.

Incase anyone is thinking about working on a fix, I have already
started, so there should be no need.

--
Thank you,
Richard.
