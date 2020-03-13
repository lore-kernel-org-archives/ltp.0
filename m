From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 13 Mar 2020 13:50:35 +0100
Subject: [LTP] [PATCH V7 10/10] syscalls/open_tree: New tests
In-Reply-To: <20200313124920.GC6597@rei.lan>
References: <6648a9106e367d370012c8ee1d0d81c369779ba8.1584014172.git.viresh.kumar@linaro.org>
 <928553e5fd3518fccb363fb8b6ad079ac3c75fd2.1584090119.git.viresh.kumar@linaro.org>
 <20200313124920.GC6597@rei.lan>
Message-ID: <20200313125035.GA9456@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> > +	TEST(move_mount(fsmfd, "", AT_FDCWD, MNTPOINT,
> > +			MOVE_MOUNT_F_EMPTY_PATH));
> > +	SAFE_CLOSE(fsmfd);

> Here as well, shouldn't we just set the .mount_device flag instead?
Sorry for overlooking these. I was too quick.
I guess metan will fix it himself.

Kind regards,
Petr
