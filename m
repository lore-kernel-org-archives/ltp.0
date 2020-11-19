From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 19 Nov 2020 14:02:21 +0100
Subject: [LTP] [PATCH] acct02: make explicit kernel config requirement
In-Reply-To: <CAMy_GT_vgtbEuT=zxs+0CxT0FGzQ-ZRkBEVVeZQmt87k=+s+EA@mail.gmail.com>
References: <20201119100617.70968-1-po-hsu.lin@canonical.com>
 <20201119103825.GG2785@yuki.lan>
 <CAMy_GT_vgtbEuT=zxs+0CxT0FGzQ-ZRkBEVVeZQmt87k=+s+EA@mail.gmail.com>
Message-ID: <20201119130221.GB12628@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> from the help text it says:
> "If you say Y here, the process accounting information is written in a
> new file format that also logs the process IDs of each process and its
> parent. Note that this file format is incompatible with previous
> v0/v1/v2 file formats, so you will need updated tools for processing
> it."
> 
> I am not sure if this test can work with a kernel that just has
> CONFIG_BSD_PROCESS_ACCT_V3 enabled.

Ah, that's right, the CONFIG_BSD_PROCESS_ACCT has to be on and the *_V3
is enabled if the format is V3.

So everything is fine and sorry for breaking the test with buggy
validation code.

-- 
Cyril Hrubis
chrubis@suse.cz
