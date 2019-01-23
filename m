From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 23 Jan 2019 15:08:22 +0100
Subject: [LTP] [PATCH v3 2/6] shell: Add tst_security.sh helper
In-Reply-To: <20190116152053.GA28027@x230>
References: <20181218010220.2446-1-pvorel@suse.cz>
 <20181218010220.2446-3-pvorel@suse.cz> <20190116131230.GC24833@rei>
 <20190116152053.GA28027@x230>
Message-ID: <20190123140822.GA27721@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > > It prints info about AppArmor and SELinux and allows to disable it.
> > > This is due some false positives because improper usage or bugs
> > > in AppArmor profiles (e.g. traceroute, dnsmasq).
> 
> > Looks good, the only piece I'm not 100% sure about is if this should be
> > sourced by default in tst_test.sh. Shouldn't we just include this in
> > network tests?
> Understand, most of user space related tests are network tests.
> 
> I decided to add it for all tests as AppArmor default [1] and non-default [2]
> contains various non-networking tools (syslog-ng, syslogd, klogd, cron, passwd,
> useradd, userdel); SELinux has some kernel [3] and system [4] related modules.

Okay then. I checked the messages generated in a case of a test failure
and hopefully these cannot be misinterpreted as they say "may affect".
Maybe it would be a bit better if the second sentence would be "You can
try to disable it with ..."

-- 
Cyril Hrubis
chrubis@suse.cz
