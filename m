From: Zhang, Yixin <yixin.zhang@intel.com>
Date: Wed, 15 Aug 2018 17:34:42 +0800
Subject: [LTP] [PATCH ltp] ver_linux: check /usr/lib/os-release in case
 /etc/os-release not exists
In-Reply-To: <20180815091749.GB3457@dell5510>
References: <20180815073540.20883-1-yixin.zhang@intel.com>
 <20180815091749.GB3457@dell5510>
Message-ID: <20180815093442.GA17378@yixin-desktop>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

On 2018-08-15 at 11:17:49 +0200, Petr Vorel wrote:
> Hi Yixin,
> 
> > https://www.linux.org/docs/man5/os-release.html:
> >   "The file /etc/os-release takes precedence over /usr/lib/os-release.
> >   Applications should check for the former, and exclusively use its data
> >   if it exists, and only fall back to /usr/lib/os-release if it is missing.
> >   Applications should not read data from both files at the same time.
> >   /usr/lib/os-release is the recommended place to store OS release
> >   information as part of vendor trees.  /etc/os-release should be a
> >   relative symlink to /usr/lib/os-release, to provide compatibility with
> >   applications only looking at /etc. A relative symlink instead of an
> >   absolute symlink is necessary to avoid breaking the link in a chroot or
> >   initrd environment such as dracut."
> 
> > To be compatible with some distro which don't have the soft link
> > "/etc/os-release", check "/usr/lib/os-release" first before checking
> > "/etc/issue".
> 
> > Signed-off-by: Yixin Zhang <yixin.zhang@intel.com>
> > ---
> >  ver_linux | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> > diff --git a/ver_linux b/ver_linux
> > index dda337926..f4c4e07f4 100755
> > --- a/ver_linux
> > +++ b/ver_linux
> > @@ -9,8 +9,12 @@ echo 'If some fields are empty or look unusual you may have an old version.'
> >  echo 'Compare to the current minimal requirements in Documentation/Changes.'
> 
> >  echo
> > -echo "`ls /etc/*release`"
> > +echo "`ls /etc/*release 2> /dev/null`"
> >  cat /etc/*release 2> /dev/null
> > +if [ $? = 1 ]; then
> > +   echo "`ls /usr/lib/*release 2> /dev/null`"
> > +   cat /usr/lib/*release 2> /dev/null
> > +fi
> >  if [ $? = 1 ]; then
> >     echo '/etc/issue:'
> >     cat /etc/issue 2> /dev/null
> 
> How about, instead of repeating files with cat, find the file and then work with it?
> Something like this:
> 
> f="$(ls /etc/*release 2>/dev/null)"
> [ -f "$f" ] || f="$(ls /usr/lib/*release 2>/dev/null)"
> [ -f "$f" ] || f="$(ls /etc/issue 2>/dev/null)"
> if [ -f "$f" ]; then
> 	echo "$f:"
> 	cat $f
> fi
> 
> We could also run `lsb_release -a' (if available).

In most case, /etc/*release includes both os-release and lsb-release and
sometimes other -release file, so the $f will be an array for most of the
time. We cannot just test it with -f (maybe a extra for loop is needed).
My inital plan is fall back to /usr/lib/ if none of the /etc/*-release exists.
This is the case on Clear Linux, and it's tested on both Ubuntu and Clear
Linux.

Yixin

> 
> 
> Kind regards,
> Petr
