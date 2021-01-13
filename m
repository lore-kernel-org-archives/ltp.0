From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 13 Jan 2021 10:54:59 +0100
Subject: [LTP] [PATCH v2 3/3] syscalls: Remove unused include <fcntl.h>
In-Reply-To: <5FFEBA89.5040001@cn.fujitsu.com>
References: <20210113075110.31628-1-pvorel@suse.cz>
 <20210113075110.31628-4-pvorel@suse.cz>
 <5FFEBA89.5040001@cn.fujitsu.com>
Message-ID: <X/7Dc2cb730/RtJy@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> On 2021/1/13 15:51, Petr Vorel wrote:
> > Tests should always use lapi/fcntl.h instead of <fcntl.h> to fix
> > possible missing definitions.

> > But in this case removing include, because fanotify tests include
> > <fcntl.h> in lapi/fcntl.h (via fanotify.h) and
> > {name_to,open_by}_handle_at tests include lapi/fcntl.h in
> > lapi/name_to_handle_at.h.
> Hi Petr,

> This patchset looks good to me.
> Reviewed-by: Xiao Yang <yangx.jy@cn.fujitsu.com>

> Only one monir question:
> Why do we remove <fcntl.h> header for all fanotify tests?
> Of course, just four fanotify tests take use of struct file_handle.
I thought I was clear in the commit description, but obviously I wasn't.
Previous commit adds lapi/fcntl.h to fanotify.h. And lapi/fcntl.h loads
<fcntl.h>, thus it's not needed here.

There has been a discussion in the past whether include "original" headers (e.g.
<fcntl.h>) in lapi headers (e.g. lapi/fcntl.h). I suggested to always include
this header, because we often don't test in Travis these corner cases when
things get broken due some definition missing. It's just safer to always use
lapi header. Previously lapi header was loaded only "when needed", but it gets
broken on less common libc (all but glibc) or on less common archs.
And it does not make sense to load "original" header and then lapi header.

If I remember correctly we agreed on this, but older lapi headers use the old
approach. I might send a patch to cleanup this and document it so we use the
same approach.

Kind regards,
Petr

> Best Regards,
> Xiao Yang
