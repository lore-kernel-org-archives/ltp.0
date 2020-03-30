From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 30 Mar 2020 11:20:46 +0200
Subject: [LTP] [PATCH v3 1/3] security/dirtyc0w: Fix bug caused by
 default umask
In-Reply-To: <20200330091835.GA9845@yuki.lan>
References: <1585553269-119544-1-git-send-email-zou_wei@huawei.com>
 <1585553269-119544-2-git-send-email-zou_wei@huawei.com>
 <20200330091835.GA9845@yuki.lan>
Message-ID: <20200330092046.GB9845@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > The case is only successful when system default umask is 0022.
> > When default umask is 0077 or other values, should clear current umask by umask(0) in setup().
> 
> What exactly fails in the dirtyc0w because of non-standard umask?
> 
> I can easily understand why fstat and statx fail, since we check the
> file permissions there. Ideally the failure should have been part of the
> patch description.

Looking at the code I guess that the child fails to open the file
created in parent before the setgid/setuid, something like this should
really have been part of the patch description.

-- 
Cyril Hrubis
chrubis@suse.cz
