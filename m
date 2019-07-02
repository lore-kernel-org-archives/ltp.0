From: Po-Hsu Lin <po-hsu.lin@canonical.com>
Date: Wed, 3 Jul 2019 00:40:15 +0800
Subject: [LTP] [PATCH] scenario_groups/default: run the kernel_misc test
 after the cve test
In-Reply-To: <20190702130513.GB11122@rei>
References: <20190628103900.10113-1-po-hsu.lin@canonical.com>
 <5D19A7E1.10607@cn.fujitsu.com> <20190702130513.GB11122@rei>
Message-ID: <CAMy_GT-Snxu5axLR6j=1yeDRNWJavofVAjdJH2FyBfCsnj=Hdw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,
thanks for the review,
do you think if we should put a comment (if possible) inside that file
to avoid getting re-ordered for some reason in the future?

On Tue, Jul 2, 2019 at 9:05 PM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> > Your patch just workarounds the issue for now, because it still happens
> > if a new test designed to taint
> > kernel is added to the group before cve group in future.
>
> Unfortunately there is no better solution for this, so I pushed the
> patch.
>
> --
> Cyril Hrubis
> chrubis@suse.cz
