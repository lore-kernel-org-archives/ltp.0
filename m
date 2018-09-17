From: Rafael David Tinoco <rafael.tinoco@linaro.org>
Date: Mon, 17 Sep 2018 12:37:57 -0300
Subject: [LTP] LTP master: arm64 : fsetxattr02.c:214:
 open(mntpoint/fsetxattr02blk, 0, 00) failed: ENXIO
In-Reply-To: <20180917084453.GB7857@rei>
References: <CA+G9fYtAuGixa5x6kgmBOa7bDkhkz6rQMY5AdBgXLjp8uZKHzg@mail.gmail.com>
 <CADtBP2DrGG8743zKzi0_SJQLSJrG27NgiOeHHvWga=RzcYPjTQ@mail.gmail.com>
 <20180917084453.GB7857@rei>
Message-ID: <CABdQkv-px744Mc-RVH=Tpa+TPqhs3tYn-D8=JgzBdjmwMtpDVA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Sep 17, 2018 at 5:45 AM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> > Not sure if there is a way, using LTP API, to enforce a module
> > existing/being loaded, but BROK is definitely the correct error in this
> > condition.
>
> There is an in-flight patch set from Alexey see:
>
> [PATCH v3 1/2] lib/tst_test.c: add 'needs_drivers' option with tst_check_drivers cmd

Great! I'll fix this error by using it then.
Thank you!
