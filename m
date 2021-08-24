From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 24 Aug 2021 08:29:00 +0200
Subject: [LTP] [PATCH v2 2/2] pec: Improve reliability
In-Reply-To: <d6443e3f-9859-82ff-7ba0-f8842cd2f437@jv-coder.de>
References: <20210812043807.3497492-1-lkml@jv-coder.de>
 <20210812043807.3497492-2-lkml@jv-coder.de>
 <YR+Lc8aBnK6KBOnW@pevik>
 <d6443e3f-9859-82ff-7ba0-f8842cd2f437@jv-coder.de>
Message-ID: <YSSRrEzZ2uSacXEM@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Joerg,

FYI, this patch breaks build:

make[1]: Leaving directory 'ltp.git/lib'
/usr/lib64/gcc/x86_64-suse-linux/11/../../../../x86_64-suse-linux/bin/ld: ../../../../lib/libltp.a(tst_checkpoint.o):ltp.git/lib/tst_checkpoint.c:36: multiple definition of `tst_futexes'; /tmp/ccITQEiq.o:ltp.git/testcases/kernel/connectors/pec/event_generator.c:168: first defined here
collect2: error: ld returned 1 exit status
make: *** [../../../../include/mk/rules.mk:37: event_generator] Error 1

https://github.com/pevik/ltp/actions/runs/1161400737

Kind regards,
Petr
