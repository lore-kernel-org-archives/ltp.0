From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 13 Jan 2021 11:02:05 +0100
Subject: [LTP] [PATCH v2 3/3] syscalls: Remove unused include <fcntl.h>
In-Reply-To: <5FFEBB79.4010807@cn.fujitsu.com>
References: <20210113075110.31628-1-pvorel@suse.cz>
 <20210113075110.31628-4-pvorel@suse.cz>
 <5FFEBA89.5040001@cn.fujitsu.com> <5FFEBB79.4010807@cn.fujitsu.com>
Message-ID: <X/7FHSMKBL7L0zBs@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xu,

> ? 2021/1/13 17:16, Xiao Yang ??:
> > On 2021/1/13 15:51, Petr Vorel wrote:
> > > Tests should always use lapi/fcntl.h instead of<fcntl.h>  to fix
> > > possible missing definitions.

> > > But in this case removing include, because fanotify tests include
> > > <fcntl.h>  in lapi/fcntl.h (via fanotify.h) and
> > > {name_to,open_by}_handle_at tests include lapi/fcntl.h in
> > > lapi/name_to_handle_at.h.
> > Hi Petr,

> > This patchset looks good to me.
> > Reviewed-by: Xiao Yang<yangx.jy@cn.fujitsu.com>

> > Only one monir question:
> > Why do we remove<fcntl.h>  header for all fanotify tests?

> Sorry, correct one word(do =>don't)
Right :). That actually makes sense, thanks!
I'll merge it with this change.

Kind regards,
Petr
