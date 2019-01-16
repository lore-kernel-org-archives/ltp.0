From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 16 Jan 2019 16:20:53 +0100
Subject: [LTP] [PATCH v3 2/6] shell: Add tst_security.sh helper
In-Reply-To: <20190116131230.GC24833@rei>
References: <20181218010220.2446-1-pvorel@suse.cz>
 <20181218010220.2446-3-pvorel@suse.cz> <20190116131230.GC24833@rei>
Message-ID: <20190116152053.GA28027@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> > It prints info about AppArmor and SELinux and allows to disable it.
> > This is due some false positives because improper usage or bugs
> > in AppArmor profiles (e.g. traceroute, dnsmasq).

> Looks good, the only piece I'm not 100% sure about is if this should be
> sourced by default in tst_test.sh. Shouldn't we just include this in
> network tests?
Understand, most of user space related tests are network tests.

I decided to add it for all tests as AppArmor default [1] and non-default [2]
contains various non-networking tools (syslog-ng, syslogd, klogd, cron, passwd,
useradd, userdel); SELinux has some kernel [3] and system [4] related modules.

Kind regards,
Petr

[1] https://gitlab.com/apparmor/apparmor/tree/master/profiles/apparmor.d
[2] https://gitlab.com/apparmor/apparmor/tree/master/profiles/apparmor/profiles/extras
[3] https://github.com/SELinuxProject/refpolicy/tree/master/policy/modules/kernel
[4] https://github.com/SELinuxProject/refpolicy/tree/master/policy/modules/system
