From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 13 Apr 2021 13:51:29 +0200
Subject: [LTP] [PATCH v3 3/4] lib: Apply the skip_filesystems to rest of
 test as well
In-Reply-To: <b2d54281-2893-2dc1-e2a8-ff789dc1c1f2@suse.cz>
References: <20210317105318.32017-1-chrubis@suse.cz>
 <20210317105318.32017-4-chrubis@suse.cz>
 <b2d54281-2893-2dc1-e2a8-ff789dc1c1f2@suse.cz>
Message-ID: <YHWFwWeT7IsJKsFf@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > +		if (tst_fs_in_skiplist(fs_name, tst_test->skip_filesystems)) {
> > +			tst_brk(TCONF, "Skipping %s as requested by the test",
> > +				fs_name);
> 
> This message might be a little confusing when the test didn't ask for
> all filesystems. I'd recommend something like "Test does not support %s
> workdir, skipping". The else clause below is probably unnecessary.

I've adjusted the message to "%s is not supported by the test" and fixed
the enum name as reported by Li and pushed the patchset.

Thanks a lot for the reviews.

-- 
Cyril Hrubis
chrubis@suse.cz
