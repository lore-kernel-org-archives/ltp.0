From: Li Wang <liwang@redhat.com>
Date: Wed, 19 Sep 2018 17:44:09 +0800
Subject: [LTP] [PATCH] statx: fix compile errors with glibc<2.28
In-Reply-To: <20180919074821.GB28540@rei>
References: <20180919044813.22875-1-liwang@redhat.com>
 <20180919074821.GB28540@rei>
Message-ID: <CAEemH2e6M=ev+EMerOS4iVY_DNAWGvtkJTF76uh_LK7QDn+0Nw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Sep 19, 2018 at 3:48 PM, Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > glibc 2.28 has shipped with a wrapper for the statx() system call.
> > Currently the build is broken against it, because sys/stat.h suddenly
> > declares all the same types that lapi/stat.h does.  Fix it by taking
> > the sys/stat.h ones if glibc>=2.28.
> >
> >   include/lapi/stat.h:26:8: error: redefinition of ???struct
> statx_timestamp???
> >   include/lapi/stat.h:73:8: error: redefinition of ???struct statx???
>
> What's wrong with the configure checks we do have?
>
> See m4/ltp-statx.m4:
>
> AC_CHECK_TYPES([struct statx],,,[[#include <sys/stat.h>]])
> AC_CHECK_TYPES([struct statx_timestamp],,,[[#include <sys/stat.h>]])
>
> That should check exactly if these structures are defined and export the
> HAVE_STRUCT_* macros?
>

Confusing...

It does not works for me. I checked the LTP "include/config.h" file after
performing ./configure,
the HAVE_STRUCT_* macros undefined.

# cat include/config.h |grep -i statx
/* Define to 1 if you have the `statx' function. */
#define HAVE_STATX 1
/* Define to 1 if the system has the type `struct statx'. */
/* #undef HAVE_STRUCT_STATX */
/* Define to 1 if the system has the type `struct statx_timestamp'. */
/* #undef HAVE_STRUCT_STATX_TIMESTAMP */
And I also confirmed the struct statx has been defined in "bits/statx.h"
which was included by "sys/stat.h" on my platform(glibc>=2.28).

# grep "struct statx" /usr/include/bits/statx.h
struct statx_timestamp
struct statx
  struct statx_timestamp stx_atime;
  struct statx_timestamp stx_btime;
  struct statx_timestamp stx_ctime;
  struct statx_timestamp stx_mtime;
           unsigned int __mask, struct statx *__restrict __buf)

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180919/37a50c7f/attachment.html>
