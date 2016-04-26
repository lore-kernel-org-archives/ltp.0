From: Sebastian Frias <sf84@laposte.net>
Date: Tue, 26 Apr 2016 11:51:31 +0200
Subject: [LTP] getrusage04 on ARM fails sometimes
In-Reply-To: <20160425144643.GC20158@rei.lan>
References: <5718E81B.6060101@free.fr> <20160421153041.GA25307@rei>
 <5718F4EE.2060009@free.fr> <571907A2.10208@free.fr> <571A274A.60707@free.fr>
 <571DCF8D.30306@free.fr> <571E0226.3020104@free.fr>
 <571E118C.1080707@free.fr> <20160425133115.GB20158@rei.lan>
 <571E28BA.8030409@free.fr> <20160425144643.GC20158@rei.lan>
Message-ID: <571F3A23.6070202@laposte.net>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

We are wondering if other people have issues with getrusage04 LTP test.
We see it failing sometimes on our ARM platform.
It seems to happen most often when CONFIG_HZ=300 than when CONFIG_HZ=100.

When the test was introduced (https://sourceforge.net/p/ltp/mailman/message/27853271/) it did not support the "-m" parameter, which is meant to broaden the "acceptance" interval.
The "-m" parameter was added by people from ST (fd875256d6f99102e3940c4dfc6b0a8a27f4d62c), so presumably working on embedded (probably ARM) systems.
Some people are increasing that interval (https://ez.analog.com/docs/DOC-9111).

Also, according to the commit history, the test is disabled on QEMU, Xen and other environments.

Questions:
1) Does anybody else using ARM has issues with this test? Or is it just us?
2) Do you suggest that we increase the "-m" parameter?
3) Do you know of another test that could be used to double check that getrusage04 failure is a false positive?

Thanks, regards,

Sebastian


