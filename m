From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 26 Apr 2018 10:06:58 +0200
Subject: [LTP] [PATCH 1/2] *.py: Replace '#!/usr/bin/python3' with
 '#!/usr/bin/env python3'
In-Reply-To: <5AE179C6.3050300@cn.fujitsu.com>
References: <1524725137-32739-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <5AE179C6.3050300@cn.fujitsu.com>
Message-ID: <20180426080658.GA4482@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xiao,

> On 2018/04/26 14:45, Xiao Yang wrote:
> > If we install python3 in specific path(/usr/local/bin) rather than the
> > default(/usr/bin), the standard shebang(#!/usr/bin/python3) cannot
> > interpreter python code due to wrong path.  We should use env to
> > search the correct path of python3 dynamically.

> ----------------------------------------------------------------------------
> # which python3
> /usr/local/bin/python3
> # ./in.py
> -bash: ./in.py: /usr/bin/python3: bad interpreter: No such file or directory
> ----------------------------------------------------------------------------
Indeed RHEL6.9GA still doesn't have python3 as normal package [1].

Couldn't it be solved by simple creating manually symlink python3 to /usr/bin ?
I'm not against changing schebang to using env, if causing troubles.
Cyril, what do you think?

It's funny that some distros already started removing python2 while still supported
versions haven't properly added python3 yet :(.

> Thanks,
> Xiao Yang


Kind regards,
Petr

[1] https://distrowatch.com/table.php?distribution=redhat&pkglist=true&version=rhel-6.9#pkglist
