From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 28 Aug 2020 08:05:54 +0200
Subject: [LTP] [LTP v4 4/5] IMA: Add a test to verify measurement of
 certificate imported into a keyring
In-Reply-To: <d6087ee43d18605ee6cdc6b80450b0024af14fb6.camel@linux.ibm.com>
References: <20200820090824.3033-1-pvorel@suse.cz>
 <20200820090824.3033-5-pvorel@suse.cz>
 <b58057275ecdc06bb512d39ea46118197f33c33f.camel@linux.ibm.com>
 <20200827132354.GA20439@dell5510> <20200827135503.GA11990@dell5510>
 <b72657042d13f9b8f30d5bdea7e2d06835e4a1d1.camel@linux.ibm.com>
 <20200827225417.GA29921@dell5510>
 <d6087ee43d18605ee6cdc6b80450b0024af14fb6.camel@linux.ibm.com>
Message-ID: <20200828060554.GB15251@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Mimi,

> Thanks, Petr.  This works properly.  To remove the "hack", would
> require running the test from "ima", not "ima/tests", but that would
> require fixing how ima_setup.sh is called.   It also would still
> require setting TST_DATAROOT to TST_DATAROOT/$TST_ID.
Let's keep it and suppose people run tests from ima/tests.
This needs to be fixed on LTP side, I have it on my TODO list.

Anything else?
After that I'll work on ima_tpm.sh and after on policy automatic loading.
BTW there are also plans for reboot support [1] [2], that could be used as
workaround for configuration without CONFIG_IMA_READ_POLICY=y and
CONFIG_IMA_WRITE_POLICY=y.

[1] http://lists.linux.it/pipermail/ltp/2020-August/018636.html
[2] http://lists.linux.it/pipermail/ltp/2020-August/018658.html

> Mimi

Kind regards,
Petr
