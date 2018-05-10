From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 10 May 2018 18:27:14 +0200
Subject: [LTP] network stress route-change-if test
Message-ID: <20180510162714.c2hdgj3eamhcderg@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

while working on cleaning & rewriting route stress tests (testcases/network/stress/route/)
into new API I come up again to problem that route-change-if tests require 2 local
interfaces, which we don't support for netns. We've been discussing this some time ago
(haven't found the post), I remember you didn't want to add support for more interfaces
into tst_net.sh. Is that correct?

I don't think it's a good idea to have test which TCONF on netns, as it's the default
setup. So I propose either of these:
* add support for adding and removing second interfaces on netns
in tst_net.sh (i.e. change init_ltp_netspace() allowing to add second namespace)
* remove the test entirely.

What do you think?
Thanks for info.

Kind regards,
Petr
