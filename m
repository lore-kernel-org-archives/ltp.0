From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 16 Sep 2021 15:54:58 +0200
Subject: [LTP] [PATCH 4/4] syscalls/utime03: Convert to new API
In-Reply-To: <dc4129ec-afe5-3d97-ff1d-326a217a63ad@suse.cz>
References: <20210915134505.22771-1-mdoucha@suse.cz>
 <20210915134505.22771-4-mdoucha@suse.cz> <YUM+76XsQB57U3rE@yuki>
 <1973857f-53fd-6f16-1f7d-d65a371f9c60@suse.cz>
 <YUNJ2yuO7UAylQNk@yuki>
 <dc4129ec-afe5-3d97-ff1d-326a217a63ad@suse.cz>
Message-ID: <YUNMslRngkq7ym20@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > I guess that it would also depend on a underlying filesystem and how
> > timestamps are rounded in there, so I guess that we should turn on the
> > .all_filesystems flag for the test as well. What do you think?
> 
> That sounds like a good idea.

I've added the support for all_filesystems and pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
