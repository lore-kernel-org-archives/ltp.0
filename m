From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 5 Apr 2019 08:48:30 +0200
Subject: [LTP] [PATCH 1/1] Remove break after return
In-Reply-To: <20190403120655.GA20621@dell5510>
References: <20190328105006.17337-1-pvorel@suse.cz>
 <5C9D8B2E.1090608@cn.fujitsu.com> <20190403120220.GB13658@rei>
 <20190403120655.GA20621@dell5510>
Message-ID: <20190405064830.GA21316@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi,

> > > Can we also remove break after calling tst_brk()?

> > AFAIK that would generate warnings, since compiler cannot deduce on it's
> > own that the call will not return.
> Agree.

patchset merged (short variant).

NOTE: Warning is produced only on gcc (to my surprise only new versions: up to
gcc 6 it's ok, 7 and 8 warns):
In file included from variant.c:6:
variant.c: In function ‘do_test’:
../../include/tst_test.h:76:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
   tst_brk_(__FILE__, __LINE__, (ttype), (arg_fmt), ##__VA_ARGS__);\
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
variant.c:13:3: note: in expansion of macro ‘tst_brk’
   tst_brk(TCONF, "Test skipped");

Kind regards,
Petr
