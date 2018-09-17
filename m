From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 17 Sep 2018 10:36:27 +0200
Subject: [LTP] statx04.c:53: FAIL: STATX_ATTR_COMPRESSED flag is not set
 - Testing on ext2
In-Reply-To: <CABdQkv-VBcEUx=mat_F-eUg9a-3Z95Z44zcWGmdGkP0kBeGB0w@mail.gmail.com>
References: <CA+G9fYsr=iYgaaepEnJOOu_-bR0p=3gCxAhcw6adQWPUnPfiYA@mail.gmail.com>
 <CABdQkv-VBcEUx=mat_F-eUg9a-3Z95Z44zcWGmdGkP0kBeGB0w@mail.gmail.com>
Message-ID: <20180917083627.GA8085@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I suppose this error is because Hikey builds are actually using EXT2
> code and not EXT4 as EXT2 compatible code.

I wouldn't say this to be error, different configuration maybe.

> Now, the REAL QUESTION, should EXT2 old code support attributes for
> directories ?
> Is this a regression or a feature that never existed for EXT2 old code ?

I've talked about that to Jan Kara and he told me that he will get this
fixed so I left the test as it is and noted that it fails on ext2 when
using ext2 driver in the commit message.

-- 
Cyril Hrubis
chrubis@suse.cz
