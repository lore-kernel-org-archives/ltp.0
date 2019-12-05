From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 5 Dec 2019 13:36:34 +0100
Subject: [LTP] [f*xattr]  ab91fe640f: ltp.open13.fail
In-Reply-To: <20191205112439.GE32275@shao2-debian>
References: <20191205112439.GE32275@shao2-debian>
Message-ID: <20191205123633.GC5693@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> commit: ab91fe640fca6de988a888b2de89d58014d120d4 ("f*xattr: allow O_PATH descriptors")
> https://git.kernel.org/cgit/linux/kernel/git/mszeredi/vfs.git for-viro

Looks like fgetxattr() on fd that has been opened with O_PATH returns
wrong errno after this patch, which I guess is OK because that seems to
be the point of this patch.

We will fix the test if/once this patch gets upstreamed.

Also btw man 2 open needs changes in the O_PATH paragraph after this as
well.

-- 
Cyril Hrubis
chrubis@suse.cz
