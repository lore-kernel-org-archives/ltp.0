From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 10 Dec 2019 15:01:46 +0100
Subject: [LTP] [PATCH] syscalls/ioctl01: Cleanup & convert to new library
In-Reply-To: <20191206145517.3415-1-chrubis@suse.cz>
References: <20191206145517.3415-1-chrubis@suse.cz>
Message-ID: <20191210140146.GA1124@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Tested-by: Petr Vorel <pvorel@suse.cz>

LGTM.

BTW (not related to ioctl01.c), is it possible to get rid of (false positive) this warning?

ioctl01.c:115:1: warning: missing initializer for field ?test_all? of ?struct tst_test? [-Wmissing-field-initializers]
 };
 ^
In file included from ioctl01.c:25:0:
../../../../include/tst_test.h:185:9: note: ?test_all? declared here
  void (*test_all)(void);
         ^~~~~~~~

Kind regards,
Petr
