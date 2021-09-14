From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 14 Sep 2021 17:52:46 +0200
Subject: [LTP] [PATCH 1/2] runtest/smoketest: Remove intermittent failed
 test case route4-change-dst
In-Reply-To: <e1873210-6d75-703d-f468-c4b826e20d54@bell-sw.com>
References: <20210914122425.85129-1-naresh.kamboju@linaro.org>
 <YUCah4R0SBDKZvPQ@pevik>
 <e1873210-6d75-703d-f468-c4b826e20d54@bell-sw.com>
Message-ID: <YUDFTmk/0OaSLXq1@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

...
> > Did 75184c30a ("lib/tst_net.sh: disable ipv6_dad work on test interfaces")
> > fixed your problem? I'd actually like to route4-change-dst in smoketest to
> > have it as a detection DAD issue is working.

> 75184c30a is fixing ipv6. From the log, it seems the error happens
> in ping, when it once again tried to bind to 10.0.0.2 as a source
> address (with -I option)...

Ah, right, I'm sorry for overlooking this.
I squashed commits (reason to add ping tests is because we removed route test),
updated commit message and merged.

Thank you both!

Kind regards,
Petr
