From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 17 Oct 2019 11:20:48 +0200
Subject: [LTP] [PATCH 1/1] fanotify: Fix missing __kernel_fsid_t
 definition
In-Reply-To: <1170755640.6589868.1571302607540.JavaMail.zimbra@redhat.com>
References: <20191016211501.3777-1-petr.vorel@gmail.com>
 <1170755640.6589868.1571302607540.JavaMail.zimbra@redhat.com>
Message-ID: <20191017092047.GB20152@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > +#if !defined(FAN_REPORT_FID) && defined(HAVE_NAME_TO_HANDLE_AT)
> > +#include <asm/posix_types.h> // __kernel_fsid_t
> > +#endif
> 
> Would an alternative that adds this type to lapi work?
> (just looking if we can avoid extra kernel include)
> 
> typedef struct {
>         int     val[2];
> } lapi_fsid_t;
> 
> #define __kernel_fsid_t lapi_fsid_t

This looks a bit safer to me as well.

-- 
Cyril Hrubis
chrubis@suse.cz
