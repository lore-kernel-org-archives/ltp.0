From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 8 Mar 2019 08:28:48 -0500 (EST)
Subject: [LTP] [PATCH 2/2 v2] libs: Hook up libs into the build system
In-Reply-To: <20190308132634.GA23955@dell5510>
References: <20190308124257.25282-1-chrubis@suse.cz>
 <20190308124257.25282-2-chrubis@suse.cz>
 <1327941462.6119620.1552050333572.JavaMail.zimbra@redhat.com>
 <20190308132634.GA23955@dell5510>
Message-ID: <1500961305.6122451.1552051728943.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> Hi Jan, Cyril,
> 
> > I tested v2 as far back as RHEL6.2, ACK.
> Jan, have you tested out of tree build?

I didn't. Only in-tree builds.

> 
> Still failing [1], mostly for out-of-tree builds [2]:
> make: Entering directory '/usr/src/ltp-build'
> make -C "lib" \
> 	-f "/usr/src/ltp/lib/Makefile" all
> make -C "libs" \
> 	-f "/usr/src/ltp/libs/Makefile" all
> make[1]: Entering directory '/usr/src/ltp-build/lib'
> mkdir -m 00755 -p "newlib_tests"
> make[1]: Entering directory '/usr/src/ltp-build'
> make[1]: *** libs: No such file or directory.  Stop.
> make[1]: Leaving directory '/usr/src/ltp-build'
> /usr/src/ltp/Makefile:114: recipe for target 'libs-all' failed
> make: *** [libs-all] Error 2
> make: *** Waiting for unfinished jobs....
> 
> And i386 for Debian has still the same error [3]:
> /usr/src/ltp/libs/libltpnuma/tst_numa.c:200: undefined /tmp/ccO9srN7.o: In
> function `verify_set_mempolicy':
> /usr/src/ltp/testcases/kernel/syscalls/set_mempolicy/set_mempolicy04.c:105:
> undefined reference to `numa_allocate_nodemask'
> /usr/src/ltp/testcases/kernel/syscalls/set_mempolicy/set_mempolicy04.c:110:
> undefined reference to `numa_bitmask_setbit'
> /usr/src/ltp/testcases/kernel/syscalls/set_mempolicy/set_mempolicy04.c:112:
> undefined reference to `set_mempolicy'

can you try to reverse linking order of libnuma and libltpnuma?

> 
> [1] https://travis-ci.org/pevik/ltp/builds/503593388
> [2] https://api.travis-ci.org/v3/job/503593397/log.txt
> [3] https://api.travis-ci.org/v3/job/503593389/log.txt
> 
> Kind regards,
> Petr
> 
