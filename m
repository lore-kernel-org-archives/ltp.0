From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 28 Nov 2016 23:05:03 +0100
Subject: [LTP] [PATCH v2 4/4] shell: fix echo -e bashisms, simplify code
In-Reply-To: <20161128150510.GC4935@rei.lan>
References: <20161125210125.7299-1-petr.vorel@gmail.com>
 <20161125210125.7299-4-petr.vorel@gmail.com>
 <20161128150510.GC4935@rei.lan>
Message-ID: <20161128220503.wbb6wtvonnxi63xf@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

thanks for your review!

> > --- a/testcases/kernel/fs/acl/tacl_xattr.sh
> > +++ b/testcases/kernel/fs/acl/tacl_xattr.sh
> > @@ -85,7 +85,7 @@ if [ $? != 0 ]
> >  then
> >  	echo ""
> >  	echo "FAILED:  [ losetup ] Must have loop device support by kernel"
> > -	echo -e "\t to execute this script"
> > +	printf "\t to execute this script\n"

> I guess that it's a bit cleaner to use printf for the whole block just
> to be consistent.
Eh, missed it while checking result. I might use cat << EOF

> > diff --git a/tools/strace_test/slay b/tools/strace_test/slay
> > index a68e8c9..7c0fe07 100755
> > --- a/tools/strace_test/slay
> > +++ b/tools/strace_test/slay
> > @@ -119,7 +119,7 @@ do
> >      echo -e "\\n\\n\\nI'm kicking your butt.\\n\\n\\n" | write $1 2>/dev/null
>          ^
> 	 Missed one?
Imperfect regex, I'll fix it.

> >    else
> >      echo "${ME}: Sending $SIGSHOW signal to $1's process(es)..."
> > -    echo -e "\\n\\n\\nYour current session has been terminated.\\n\\n\\n" | \
> > +    printf "\\n\\n\\nYour current session has been terminated.\\n\\n\\n\n" | \
> >      	write $1 2>/dev/null
> >    fi
> >    if [ "$SIGNAL" = "-clean" ]

> Apart from that the patchset is obviously correct.


Kind regards,
Petr
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20161128/796bf125/attachment.sig>
