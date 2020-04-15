From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 15 Apr 2020 11:49:32 +0200
Subject: [LTP] [RFC PATCH 1/8] lib: Fix linking error multiple TCID
 definitions with -fno-common
In-Reply-To: <20200415093038.GA12705@rei.lan>
References: <20200415092809.20240-1-pvorel@suse.cz>
 <20200415092809.20240-2-pvorel@suse.cz>
 <20200415093038.GA12705@rei.lan>
Message-ID: <20200415094932.GA29975@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> > +extern const char *TCID;

> Do we really need this extern or can we remove it?
Some code is using TCID, not sure if it could be replaced by something else or
whether is worth to add API function which returns TCID.

In file included from memfd_create01.c:17:
memfd_create01.c: In function ?verify_memfd_create?:
memfd_create01.c:244:21: error: ?TCID? undeclared (first use in this function)
  244 |  fd = CHECK_MFD_NEW(TCID, MFD_DEF_SIZE, tc->flags);
      |                     ^~~~
---

In file included from testcases/kernel/mem/include/mem.h:4,
                 from overcommit_memory.c:72:
overcommit_memory.c: In function ?setup?:
overcommit_memory.c:105:33: error: ?TCID? undeclared (first use in this function)
  105 |     "can't support to test %s", TCID);
      |                                 ^~~~
---

In file included from ima_mmap.c:9:
ima_mmap.c: In function ?run?:
ima_mmap.c:36:43: error: ?TCID? undeclared (first use in this function)
   36 |   tst_brk(TBROK, "Usage: %s -f filename", TCID);
      |                                           ^~~~

Kind regards,
Petr
