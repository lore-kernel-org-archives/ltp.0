From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 18 Mar 2019 18:55:49 +0100
Subject: [LTP] Travis failures
Message-ID: <20190318175549.GB3892@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

quite often I see in my travis builds liblitpnuma.a related failures [1] (one
random out-of-tree build), which gets fixed by restarting it. Any idea why?

Kind regards,
Petr

make[4]: Leaving directory '/usr/src/ltp-build/testcases/kernel/syscalls/splice'
make[4]: Entering directory '/usr/src/ltp-build/testcases/kernel/syscalls/set_mempolicy'
make -C "/usr/src/ltp-build/libs/libltpnuma" -f "/usr/src/ltp-build/libs/libltpnuma/Makefile" all
make[5]: Entering directory '/usr/src/ltp-build/libs/libltpnuma'
make[5]: /usr/src/ltp-build/libs/libltpnuma/Makefile: No such file or directory
make[5]: *** No rule to make target '/usr/src/ltp-build/libs/libltpnuma/Makefile'.  Stop.
make[5]: Leaving directory '/usr/src/ltp-build/libs/libltpnuma'
/usr/src/ltp/include/mk/testcases.mk:52: recipe for target '/usr/src/ltp-build/libs/libltpnuma/libltpnuma.a' failed
make[4]: *** [/usr/src/ltp-build/libs/libltpnuma/libltpnuma.a] Error 2
make[4]: Leaving directory '/usr/src/ltp-build/testcases/kernel/syscalls/set_mempolicy'
/usr/src/ltp/include/mk/generic_trunk_target.inc:93: recipe for target 'all' failed
make[3]: *** [all] Error 2
make[3]: Leaving directory '/usr/src/ltp-build/testcases/kernel/syscalls'
/usr/src/ltp/include/mk/generic_trunk_target.inc:93: recipe for target 'all' failed
make[2]: *** [all] Error 2
make[2]: Leaving directory '/usr/src/ltp-build/testcases/kernel'
/usr/src/ltp/include/mk/generic_trunk_target.inc:93: recipe for target 'all' failed
make[1]: *** [all] Error 2
make[1]: Leaving directory '/usr/src/ltp-build/testcases'
/usr/src/ltp/Makefile:119: recipe for target 'testcases-all' failed
make: *** [testcases-all] Error 2
make: Leaving directory '/usr/src/ltp-build'

[1] https://api.travis-ci.org/v3/job/507981762/log.txt
