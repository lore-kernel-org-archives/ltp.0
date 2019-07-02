From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 2 Jul 2019 19:19:10 +0200
Subject: [LTP] [PATCH] scenario_groups/default: run the kernel_misc test
 after the cve test
In-Reply-To: <CAMy_GT-Snxu5axLR6j=1yeDRNWJavofVAjdJH2FyBfCsnj=Hdw@mail.gmail.com>
References: <20190628103900.10113-1-po-hsu.lin@canonical.com>
 <5D19A7E1.10607@cn.fujitsu.com> <20190702130513.GB11122@rei>
 <CAMy_GT-Snxu5axLR6j=1yeDRNWJavofVAjdJH2FyBfCsnj=Hdw@mail.gmail.com>
Message-ID: <20190702171910.GC20468@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> thanks for the review,
> do you think if we should put a comment (if possible) inside that file
> to avoid getting re-ordered for some reason in the future?

We cannot, the scenari files are simply read line by line, the format
does not support comments.

-- 
Cyril Hrubis
chrubis@suse.cz
