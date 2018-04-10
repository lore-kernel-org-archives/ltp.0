From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 10 Apr 2018 08:19:29 +0200
Subject: [LTP] [PATCH 1/1] utils/compat_16.mk: Further cleanup of unused
 sections and variables
In-Reply-To: <5ACC4D12.9040000@cn.fujitsu.com>
References: <20180409120028.30692-1-pvorel@suse.cz>
 <5ACC4D12.9040000@cn.fujitsu.com>
Message-ID: <20180410061929.mnazpimind22bjrn@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Yang,

> Hi Petr

> -%_16.o: %.c $(COMPAT_16_H)

> This make dependency for recompiling _16.o when header changes.

> $(MAKE_TARGETS_OBJS_WO_COMPAT_16): $(COMPAT_16_H)
> .INTERMEDIATE: $(MAKE_TARGETS_OBJS_WO_COMPAT_16)

> This make dependency for recompiling .o when header changes.

> I think you may miss something.

> This patch will reappear the problem that has been fixed since commit
> 631d16671d(syscalls/utils/compat_16.mk: fix build dependencies).
> If we touch/modify the compat_tst_16.h/compat_16.h file and excute "make"
> in any of syscalls directories which includes compat_16.mk, nothing will
> happen.

Thank you for explaining and sorry for wrong patch.
Before I touch wrong file, that's why it didn't work the obvious way you described.

I still thing that HAS_COMPAT_16 variable is unused and not needed.


Kind regards,
Petr

> Best Regards
> Yang Xu
