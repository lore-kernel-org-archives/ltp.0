From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 11 Sep 2020 10:37:03 +0200
Subject: [LTP] [PATCH] ns-tools/set_ipv4addr: Use ip command as default
In-Reply-To: <1599746191-2012-1-git-send-email-chen_han_xiao@126.com>
References: <1599746191-2012-1-git-send-email-chen_han_xiao@126.com>
Message-ID: <20200911083703.GA697@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Chen,

> Set iproute as the default as ifconfig
> has been deprecated on some of the distributions.

>  testcases/network/stress/ns-tools/set_ipv4addr | 40 +++++++++++++++++++++-----

Thanks for your patch. While I appreciate you work on LTP networking tests, I'm
against this change for a simple reason: everything which uses ns-tools needs to
be rewritten to use new LTP network shell API (tst_net.sh). Only very simple
fixes for really broken things like 4cf2f2bfd should be accepted.

Thus, please put your effort into rewriting these tests.
FYI Although it's a low priority for me I plan to work on these (I have wip at
least for rmmod). Feel free to join this effort.
See https://github.com/linux-test-project/ltp/issues/310

Kind regards,
Petr
