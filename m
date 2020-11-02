From: Po-Hsu Lin <po-hsu.lin@canonical.com>
Date: Mon, 2 Nov 2020 10:43:01 +0800
Subject: [LTP] [PATCH] syscalls/statx05: add mkfs.ext4 package version
 check
In-Reply-To: <20201030131214.GA32451@yuki.lan>
References: <20201029140031.40968-1-po-hsu.lin@canonical.com>
 <20201030131214.GA32451@yuki.lan>
Message-ID: <CAMy_GT_zEnmgD4Sr1PC8PgyhDXhLoor=9yT2JpmS5EeGOjjo8Q@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Oct 30, 2020 at 9:11 PM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> > +     int ret, rc, major, minor, patch;
> > +
> > +     f = SAFE_POPEN("mkfs.ext4 -V 2>&1 | awk '/mke2fs/ {print $2}'", "r");
> > +     rc = fscanf(f, "%d.%d.%d", &major, &minor, &patch);
>
> I wonder if the awk is necessary, it may produce TWARN on minimal
> embedded systems where awk is not present. Why can't we use scanf() instead?
>
> As far as I can tell fscanf(f, "mke2fs %d.%d.%d", &major, &minor,
> &patch); should work fine without the awk.
Yes this works,
I will send V2 for this, thanks!

>
> --
> Cyril Hrubis
> chrubis@suse.cz
