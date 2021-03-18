From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 18 Mar 2021 22:16:53 +0100
Subject: [LTP] [PATCH v2 1/7] fzsync: Add self tests
In-Reply-To: <20210318130935.28528-2-rpalethorpe@suse.com>
References: <20210318130935.28528-1-rpalethorpe@suse.com>
 <20210318130935.28528-2-rpalethorpe@suse.com>
Message-ID: <YFPDRciWeJrwDuVf@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richie,

FYI this commit fails due
/usr/bin/ld: /tmp/ccBD0Mxi.o: in function `tst_fzsync_pair_cleanup':
/home/pevik/install/src/ltp.git/lib/newlib_tests/../../include/tst_fuzzy_sync.h:226: undefined reference to `pthread_cancel'
/usr/bin/ld: /home/pevik/install/src/ltp.git/lib/newlib_tests/../../include/tst_fuzzy_sync.h:226: undefined reference to `pthread_cancel'
/usr/bin/ld: ../../lib/libltp.a(safe_pthread.o): in function `safe_pthread_create':
/home/pevik/install/src/ltp.git/lib/safe_pthread.c:18: undefined reference to `pthread_create'
/usr/bin/ld: ../../lib/libltp.a(safe_pthread.o): in function `safe_pthread_join':
/home/pevik/install/src/ltp.git/lib/safe_pthread.c:34: undefined reference to `pthread_join'
collect2: error: ld returned 1 exit status
make[1]: *** [../../include/mk/rules.mk:37: tst_fuzzy_sync01] Error 1
make: *** [../include/mk/generic_trunk_target.inc:105: all] Error 2

lib/newlib_tests/Makefile needs to add:
tst_fuzzy_sync01: CFLAGS+=-pthread
tst_fuzzy_sync02: CFLAGS+=-pthread

Kind regards,
Petr
