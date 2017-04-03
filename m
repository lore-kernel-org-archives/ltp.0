From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Mon, 3 Apr 2017 13:01:19 +0200
Subject: [LTP] [PATCH v2 0/1] syscalls/madvise: Handle zero page poisoning
Message-ID: <20170403130119.3448ca53@linux-v3j5>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Metan,

>This is getting a bit out of hand, can we change this into a function
>instead?
>
>static const char *maptype(int mtype)
>{
>	switch (mtype) {
>	case MAP_SHARED:
>		return "MAP_SHARED";
>	...
>	default:
>		return "???";
>	}
>}

I have done that in this second version, I suppose the conditional expression
was a bit weird and probably not as compiler friendly. I also joined a few
lines together and added some braces because check-patch.pl now asks me to.

Richard Palethorpe (1):
  syscalls/madvise: Handle zero page poisoning

 testcases/kernel/syscalls/madvise/madvise07.c | 53 ++++++++++++++++++++++-----
 1 file changed, 43 insertions(+), 10 deletions(-)

-- 
2.12.0
