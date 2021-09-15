From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 15 Sep 2021 11:35:26 +0200
Subject: [LTP] [PATCH 1/2] lib/tst_net.sh: ignore errors on rhost with
 -i option in tst_net_run()
In-Reply-To: <82b63456-0ba6-dedc-9688-cc74c40e4982@bell-sw.com>
References: <20210913123935.10761-1-aleksei.kodanev@bell-sw.com>
 <YUA3UIvykJPNyyi4@pevik>
 <82b63456-0ba6-dedc-9688-cc74c40e4982@bell-sw.com>
Message-ID: <YUG+XlCf83X4TP26@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> Hi Petr,
> On 14.09.2021 08:46, Petr Vorel wrote:
> > Hi Alexey,

> > good catch!
> > Reviewed-by: Petr Vorel <pvorel@suse.cz>

> > BTW are you going to send patch / report it to busybox? (I haven't find anything on ML)

> Looking at busybox history, seems expected from the beginning there:

> commit 64309f8669f08f2c3c16a3b5bf82d9cae84ec388
> Author: Denis Vlasenko <vda.linux@googlemail.com>
> Date:   Thu Nov 29 06:40:28 2007 +0000

>     sysctl: add -e: supress warnings about invalid key (Jeremy Kerr <jk@ozlabs.org>)

> -e option unsets FLAG_SHOW_KEY_ERRORS.

> busybox/sysctl: "-e	Don't warn about unknown keys"
> (Though, -q option can be used for that, which was added later, in 2012)
> vs
> procps/sysctl:  "-e, --ignore         ignore unknown variables errors"

Hm, IMHO it'd be good change to -e have 0 exit status. Because that's the
behavior in procps-ng (tested on 3.3.17).

If you do it, please let me know and/or Cc me in your patch. Otherwise I'll do it.

Kind regards,
Petr
