From: =?unknown-8bit?q?K=C3=B6ry?= Maincent <kory.maincent@bootlin.com>
Date: Fri, 18 Dec 2020 11:58:18 +0100
Subject: [LTP] sctp/func_tests need driver sctp.
Message-ID: <20201218115818.43f63eff@kmaincent-XPS-13-7390>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

I have noticed all the tests of sctp/func_tests need the driver sctp.
Do I add this to all these tests to have the right TCONF message:

if (tst_check_driver("sctp"))
	tst_brkm(TCONF, tst_exit, "sctp driver not available");

Or do you have a better idea?
I suppose the best should be to update them to the new API.

Regards,

K?ry
