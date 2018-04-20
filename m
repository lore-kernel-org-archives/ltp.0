From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 20 Apr 2018 10:15:02 +0200
Subject: [LTP] [PATCH 2/2] network/in6_02: Don't use default value for
 LHOST_IFACES
In-Reply-To: <34e6a4c1-4a2f-dda1-3b83-03d4930a08ec@oracle.com>
References: <20180417124207.4561-1-pvorel@suse.cz>
 <20180417124207.4561-2-pvorel@suse.cz>
 <f28265d1-10a0-f7d0-248d-e0b8b709eea8@oracle.com>
 <20180418141356.fuqueijmwjf2mvew@dell5510>
 <34e6a4c1-4a2f-dda1-3b83-03d4930a08ec@oracle.com>
Message-ID: <20180420081502.vdhd7rf2dlzc4cjv@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> >> What about using TCONF if it skips the test-case because
> >> LHOST_IFACE is not defined?
> > I wanted to keep at least testing of if_nametoindex("lo").
> > Would be overkill in case of TCONF to create in6_02.sh which would just load tst_net.sh?
> > I don't like the fact, that network C tests depend on being run via network.sh (unlike
> > shell network tests).

> Why it depends on network.sh? LHOST_IFACE is just an environment variable.
> It can be defined on the test machine already before the test is started,
> or with tst_net.sh.
Yes, but that's what I doesn't like: you need to source tst_net.sh (either with network.sh
or manually). Not a big issue, it's just you shouldn't run C tests like in6_02 without
variables. This is different from other non-networking tests, which you can run as they
are (without any preparation, setup).
This is the reason I was thinking about wrapping any C test which need variables with
shell script which source tst_net.sh for it.

Kind regards,
Petr
