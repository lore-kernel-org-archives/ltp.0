From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 31 Oct 2016 11:39:06 +0100
Subject: [LTP] new shell library
In-Reply-To: <827120068.2432301.1477908222614.JavaMail.zimbra@redhat.com>
References: <20161003145835.GD7583@rei.suse.cz>
 <254451816.211402.1475574875165.JavaMail.zimbra@redhat.com>
 <20161012100806.GA24231@rei.lan>
 <1175646125.448517.1476268354007.JavaMail.zimbra@redhat.com>
 <20161012123602.GB24231@rei.lan> <20161012131726.GC24231@rei.lan>
 <1527497475.514457.1476284084454.JavaMail.zimbra@redhat.com>
 <20161027145806.GA25043@rei.lan>
 <827120068.2432301.1477908222614.JavaMail.zimbra@redhat.com>
Message-ID: <20161031103906.GE30590@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I don't recall original ROD email thread, but did we consider eval and
> passing entire command as single argument? For most commands it would
> seem to be as simple as adding quotes around, awk though needs some
> escaping:
> 
> #!/bin/sh
> 
> ROD_BASE()
> {
>         eval $@
> }
> 
> ROD()
> {
>         ROD_BASE "$@"
>         if [ $? -ne 0 ]; then
>                 tst_brk TBROK "$@ failed"
>         fi
> }
> 
> ROD_SILENT()
> {
>         ROD_BASE "$@" > /dev/null 2>&1
>         if [ $? -ne 0 ]; then
>                 tst_brk TBROK "$@ failed"
>         fi
> }
> 
> sleep 1 &
> ROD jobs
> ROD "ps | awk '{print \$1}' > tempfile"

I wanted to avoid putting the whole command line into "" as well as the
need to escape $ signs inside of '', etc.

For instance if I wanted to print literal '\n' I would have to do:

ROD echo "\\\\n"

whereas with the C helper we can do just:

ROD echo "\\n"


I'm not saying that the C binary is the best solution to the problem but
I do not thing that using eval does not seem to be much better, it's
certainly shorter to implement though.

-- 
Cyril Hrubis
chrubis@suse.cz
