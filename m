From: xuyang.jy <xuyang.jy@cn.fujitsu.com>
Date: Tue, 10 Apr 2018 14:46:50 +0800
Subject: [LTP] [PATCH 1/1] utils/compat_16.mk: Further cleanup of unused
 sections and variables
In-Reply-To: <20180410061929.mnazpimind22bjrn@dell5510>
References: <20180409120028.30692-1-pvorel@suse.cz>
 <5ACC4D12.9040000@cn.fujitsu.com> <20180410061929.mnazpimind22bjrn@dell5510>
Message-ID: <5ACC5DDA.3010300@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

on 2018/4/10 14:19, Petr Vorel write:
> Hi Yang,
>
>> Hi Petr
>> -%_16.o: %.c $(COMPAT_16_H)
>> This make dependency for recompiling _16.o when header changes.
>> $(MAKE_TARGETS_OBJS_WO_COMPAT_16): $(COMPAT_16_H)
>> .INTERMEDIATE: $(MAKE_TARGETS_OBJS_WO_COMPAT_16)
>> This make dependency for recompiling .o when header changes.
>> I think you may miss something.
>> This patch will reappear the problem that has been fixed since commit
>> 631d16671d(syscalls/utils/compat_16.mk: fix build dependencies).
>> If we touch/modify the compat_tst_16.h/compat_16.h file and excute "make"
>> in any of syscalls directories which includes compat_16.mk, nothing will
>> happen.
> Thank you for explaining and sorry for wrong patch.
> Before I touch wrong file, that's why it didn't work the obvious way you described.
>
> I still thing that HAS_COMPAT_16 variable is unused and not needed.
     Hi petr

       Agreed.   The  HAS_COMPAT_16 variable is unused .
>
> Kind regards,
> Petr
>
>> Best Regards
>> Yang Xu
>
> .
>



