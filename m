From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 9 Mar 2016 18:43:37 +0100
Subject: [LTP] [PATCH 1/2] lib/tst_mkfs: new tst_mkfs_sized function for
 create appointed size fs
In-Reply-To: <2053304118.27813474.1457541005041.JavaMail.zimbra@redhat.com>
References: <1457444133-5671-1-git-send-email-zlang@redhat.com>
 <20160309130709.GA28171@rei.lan>
 <1202691488.27788761.1457537492316.JavaMail.zimbra@redhat.com>
 <20160309155258.GA32248@rei.lan>
 <617741409.27804234.1457539512488.JavaMail.zimbra@redhat.com>
 <20160309160924.GA28234@rei.lan>
 <2053304118.27813474.1457541005041.JavaMail.zimbra@redhat.com>
Message-ID: <20160309174337.GA32758@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Sure, it's OK for me. And I think if we call it *fs_size, maybe make the user
> feel confused. The truth is it's the count of blocks, and only used for some
> fs. So maybe we can call it *extra_opts, means used after device name?

That is true, well the 'man mkfs' is confusing as well since it looks
like the size argument is supported generally by mkfs binaries...

And we should call it extra_opt, since it's just one option.

> So I will do this patch:
> 
> 1. change tst_mkfs to 
> void safe_mkfs(const int lineno, const char *fname, const char *dev,
>                const char *fs_type, const char *const fs_opts[],
>                const char *extra_opts)
> 
> 2. add tst_mkfs into test.h:
> static inline void tst_mkfs(const int lineno, const char *fname, const char *dev,
>                              const char *fs_type, const char *const fs_opts[])
> {
>     safe_mkfs(lineno, fname, dev, fs_type, fs_opts, NULL);
> }
> 
> Does this you want?

Having two nearly identical *_mkfs() functions would be confusing as
well. I would have just changed the function prototype and fixed all the
testcases that use it (36 testcases if I'm counting right).

-- 
Cyril Hrubis
chrubis@suse.cz
