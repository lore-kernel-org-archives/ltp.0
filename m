From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 30 Apr 2018 08:38:06 +0200
Subject: [LTP] [PATCH 1/2] *.py: Replace '#!/usr/bin/python3' with
 '#!/usr/bin/env python3'
In-Reply-To: <20180427140813.GA22462@rei>
References: <1524725137-32739-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <5AE179C6.3050300@cn.fujitsu.com> <20180426080658.GA4482@x230>
 <20180427140813.GA22462@rei>
Message-ID: <20180430063806.425k25ch7dr5btka@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> Hi!
> > Couldn't it be solved by simple creating manually symlink python3 to /usr/bin ?
> > I'm not against changing schebang to using env, if causing troubles.
> > Cyril, what do you think?

> Well if it's causing problems for our users we should go ahead and
> change the shebangs to /usr/bin/env python3.
Simple linking solves that:
# ln -s /usr/local/bin/python3 /usr/bin
And this problem occurs only if you compile python3 from sources (and there are packages for
all major distros, including RHEL 6.9, which Xiao used - in his case it's EPEL repository).

Still want to me to change shebang to '/usr/bin/env python3' ?


Kind regards,
Petr
