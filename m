From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 16 Sep 2021 15:42:51 +0200
Subject: [LTP] [PATCH 4/4] syscalls/utime03: Convert to new API
In-Reply-To: <1973857f-53fd-6f16-1f7d-d65a371f9c60@suse.cz>
References: <20210915134505.22771-1-mdoucha@suse.cz>
 <20210915134505.22771-4-mdoucha@suse.cz> <YUM+76XsQB57U3rE@yuki>
 <1973857f-53fd-6f16-1f7d-d65a371f9c60@suse.cz>
Message-ID: <YUNJ2yuO7UAylQNk@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >> +	mintime = time(0);
> >> +	TST_EXP_PASS(utime(TEMP_FILE, NULL));
> >> +	maxtime = time(0);
> > 
> > I wonder if this suffers the problem as the ipc timestamps:
> > 
> > https://github.com/linux-test-project/ltp/commit/d37bde3defa12556ba7399f4131996f8e490490a
> 
> Possibly. Let's find out, we can always fix the test in the next release.

I guess that it would also depend on a underlying filesystem and how
timestamps are rounded in there, so I guess that we should turn on the
.all_filesystems flag for the test as well. What do you think?

-- 
Cyril Hrubis
chrubis@suse.cz
