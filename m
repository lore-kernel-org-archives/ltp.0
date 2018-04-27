From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 27 Apr 2018 16:08:13 +0200
Subject: [LTP] [PATCH 1/2] *.py: Replace '#!/usr/bin/python3' with
 '#!/usr/bin/env python3'
In-Reply-To: <20180426080658.GA4482@x230>
References: <1524725137-32739-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <5AE179C6.3050300@cn.fujitsu.com> <20180426080658.GA4482@x230>
Message-ID: <20180427140813.GA22462@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Couldn't it be solved by simple creating manually symlink python3 to /usr/bin ?
> I'm not against changing schebang to using env, if causing troubles.
> Cyril, what do you think?

Well if it's causing problems for our users we should go ahead and
change the shebangs to /usr/bin/env python3.

> It's funny that some distros already started removing python2 while still supported
> versions haven't properly added python3 yet :(.

That is why I think that we should avoid using python in LTP...

-- 
Cyril Hrubis
chrubis@suse.cz
