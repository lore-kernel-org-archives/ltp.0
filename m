From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 29 May 2019 13:34:42 +0530
Subject: [LTP] [LKP] [ext4] 079f9927c7: ltp.mmap16.fail
In-Reply-To: <20190529035613.GA6210@mit.edu>
References: <20190529025256.GB22325@shao2-debian>
 <20190529035613.GA6210@mit.edu>
Message-ID: <CA+G9fYtVH0UF55Xins22sXCvcOLN+JGv-p2brj58BjzNGqdE2A@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Ted,

On Wed, 29 May 2019 at 09:26, Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Wed, May 29, 2019 at 10:52:56AM +0800, kernel test robot wrote:
> > FYI, we noticed the following commit (built with gcc-7):
> >
> > commit: 079f9927c7bfa026d963db1455197159ebe5b534 ("ext4: gracefully handle ext4_break_layouts() failure during truncate")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

I do have found this problem on linux next 20190528 on x86_64, i386,
arm64 and arm architectures.
But, this failure is not easy to reproduce.
so thought of sharing report with steps to reproduce and got delayed.

>
> Jan --- this is the old version of your patch, which I had dropped
> before sending a push request to Linus.  However, I forgot to reset
> the dev branch so it still had the old patch on it, and so it got
> picked up in linux-next.  Apologies for the confusion.
>
> I've reset the dev branch on ext4.git, and the new version of your
> patch will show up there shortly, as I start reviewing patches for the
> next merge window.

However, Thanks for looking into this problem.
I will keep monitoring this mmap16 failure and let you know when it
will get fixed.

- Naresh
