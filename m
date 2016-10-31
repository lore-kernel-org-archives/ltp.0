From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 31 Oct 2016 06:03:42 -0400 (EDT)
Subject: [LTP] new shell library
In-Reply-To: <20161027145806.GA25043@rei.lan>
References: <20161003145835.GD7583@rei.suse.cz>
 <254451816.211402.1475574875165.JavaMail.zimbra@redhat.com>
 <20161012100806.GA24231@rei.lan>
 <1175646125.448517.1476268354007.JavaMail.zimbra@redhat.com>
 <20161012123602.GB24231@rei.lan> <20161012131726.GC24231@rei.lan>
 <1527497475.514457.1476284084454.JavaMail.zimbra@redhat.com>
 <20161027145806.GA25043@rei.lan>
Message-ID: <827120068.2432301.1477908222614.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Thursday, 27 October, 2016 4:58:06 PM
> Subject: Re: [LTP] new shell library
> 
> Hi!
> Up to date version is at usuall place[1]. I've managed to clean up most
> of the tests in commands (four more to go) and I think that I ate enough
> of my own dog food and, at this point, the tst_test.sh library should be
> reasonably stable.
> 
> There is one change I'm not 100% sure of [2]. This is about ROD,
> EXPECT_PASS and EXPECT_FAIL. These are all implemented using one common
> funcntion and the $@ gets passed to it then gets parser in a loop in
> order to implement redirection and that is where the paramteres are
> expanded several times which breaks things horribly. As far as I can
> tell this is impossible to implement correctly in shell. For instance
> things like: ROD awk '{print $1}' wouldn't work with ROD_BASE as a shell
> fuction. As a result I've reimplemented the ROD_BASE as tst_rod in C,
> which works mostly fine. It's just stdin/stdout/stderr redirection +
> execvp() (and fallback to "/bin/sh -s" for shell buildins). The only
> thing that does not work are shell buildins that require to be executed
> in the context of current shell, such as 'wait' or 'jobs'. I'm pondering
> if it is worth of catching these two special cases in the tst_test.sh
> shell library to fix that issue. Any kind of feedback to this is warmly
> welcomed.

I don't recall original ROD email thread, but did we consider eval and
passing entire command as single argument? For most commands it would
seem to be as simple as adding quotes around, awk though needs some
escaping:

#!/bin/sh

ROD_BASE()
{
        eval $@
}

ROD()
{
        ROD_BASE "$@"
        if [ $? -ne 0 ]; then
                tst_brk TBROK "$@ failed"
        fi
}

ROD_SILENT()
{
        ROD_BASE "$@" > /dev/null 2>&1
        if [ $? -ne 0 ]; then
                tst_brk TBROK "$@ failed"
        fi
}

sleep 1 &
ROD jobs
ROD "ps | awk '{print \$1}' > tempfile"
ROD_SILENT "whoami >> tempfile"
ROD_SILENT ls
ROD ls -la

> 
> The rest of the changes should be more or less fine. The shell testcases
> now support looping parameter and have well defined way of adding test
> specific ones. What is not yet implemented is support for timeouts, that
> could be easily done later since that is more or less orthogonal to the
> current work.
> 
> All in all I would love to have a second pair of eyes (or even more!) to
> check the code now.
> 
> [1] https://github.com/metan-ucw/ltp/commits/master
> [2]
> https://github.com/metan-ucw/ltp/commit/61bebd11c6f956a7b9fcdf319ea6f4a47f5de35a
> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
