From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 25 Nov 2016 10:05:22 +0100
Subject: [LTP] [PATCH v3 2/2] testcases/clock_nanosleep01: convert to
 use new test library API
In-Reply-To: <20161124164832.GH14986@rei.lan>
References: <26cbebb57e3e9df7ed9f76b7ccc67d5f104ad376.1480002155.git-series.pvorel@suse.cz>
 <184a4d332234197dc9c1f61ca24f6f15aea4ee0b.1480002155.git-series.pvorel@suse.cz>
 <20161124164832.GH14986@rei.lan>
Message-ID: <20161125090522.njhmnswdk4sm676b@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

again, thanks for your review!

<snip>
> Sorry that I missed that in the earlier patches. The actuall tst_res()
> message should explain the reason for the failure here. So something as:

> tst_res(TFAIL, "The clock_nanosleep() haven't slept correctly, "
>         "measured %ldms, expected %ldms +- %d", elapsed_ms, expect_ms,
> 	MAX_MSEC_DIFF);
This looks better :-). I consider too verbose output (return code, expected return code,
expected errno etc). useless, but didn't dare to remove it.

<snip>

> Otherwise this version looks very good. Just keep in mind to keep the
> lines under 80 characters.
Right! I'm sorry about being relaxed on this so far.
Just a question about strings: kernel formatting style [1] says about it:
> However, never break user-visible strings such as
> printk messages, because that breaks the ability to grep for them.
And indeed my using plugin forcing kernel coding style [2] doesn't complain on strings
So I hope string long up to 90 characters are still ok.

Kind regards,
Petr

[1] https://www.kernel.org/doc/Documentation/CodingStyle
[2] https://github.com/vivien/vim-linux-coding-style
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20161125/818ea698/attachment.sig>
