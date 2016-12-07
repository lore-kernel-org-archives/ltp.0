From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 7 Dec 2016 15:18:55 +0100
Subject: [LTP] Invoking networking tests
Message-ID: <20161207141855.lvyrqs4cxhy4wr2c@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

we're going to run LTP networking tests to against openSUSE and SUSE. Is there anything
you'd like to change on invoking these tests? Anything deprecated?

I see that scripts are run by ltp-pan (via. testscripts/network.sh wrapper), which is I
suppose standard way how to run any test in LTP (as it is in runltp and half of
testscripts/*.sh scripts).

How about testcases/lib/test_net.sh and testcases/lib/test.sh scripts? Not deprecated?

BTW: what is the purpose of testscripts/*.sh scripts, why it isn't everything integrated
into runltp?

Kind regards,
Petr

PS: sorry for duplicate mail, now sent with correct LTP mailing list address.
