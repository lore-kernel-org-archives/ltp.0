From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 15 Jan 2021 10:38:34 +0100
Subject: [LTP] [PATCH 1/1] device-drivers/zram: Fix false-judgement on
 zram's presence
In-Reply-To: <20210115085406.GA23267@andestech.com>
References: <20210114074603.GB32318@andestech.com> <YABgDXi2WHSWmwHF@pevik>
 <20210115085406.GA23267@andestech.com>
Message-ID: <YAFimsGMMIkf+xU3@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Leo,

...
> > IMHO we have only 2 options:
> > * write something on our own which would look into /lib/modules and
> > /system/lib/modules (Android). That's what BusyBox implementation does
> > (also kmod implementation looks into /lib/modules). BusyBox has this path in
> > defined in build time configuration (CONFIG_DEFAULT_MODULES_DIR), but I'd be
> > surprised if any system had both directories.
> > pros: no external dependency
> > cons: more code

> > * use modinfo, but grep for output: for 'filename:' (turn Leo's suggestion into
> > C code in the API):
> > cons: module not checked, when modprobe missing (we check for 255 exit code).


> Thanks for breaking things down in such detail!

> I personally prefer the first option that looking into those directories ourselves.
> So let's drop this patch and stay as is for now!

FYI: I'm going to implement 1) (own search, written in C API).
Hope to have it on Monday (before the release). If not, we should revert
305a78e4c ("tst_net.sh: Require veth for netns") which breaks *all* network
tests for BusyBox.

> > BTW not sure whether bother about android support anyway. On Android phone I
> > have available (Android 8), there is empty /system/lib/modules directory and no
> > /proc/modules:, thus nor BusyBox neither even toybox modprobe/modinfo
> > implementations work.

> BTW, I found that there's a ver_linux script that detects the version of util-linux.
Yes, but ver_linux it's just legacy info script (we don't have anything better
than this).

> But as I searched through commit log of LTP, there are a lot of workarounds
> regarding the compatibility issue with Busybox (around 10 commits or so).
Yes, these fixes are specific to particular tests. But detecting module in LTP
API affect many tests.

> Is there a certain version of util-linux is expected to conduct a full run of LTP ?
No. We just fix problems when reported (usually reported send a patch).

FYI: We haven't even set minimal supported kernel and (g)libc version.
https://github.com/linux-test-project/ltp/issues/657

> Thanks again,
> Leo


Kind regards,
Petr
