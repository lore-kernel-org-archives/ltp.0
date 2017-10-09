From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 9 Oct 2017 16:23:04 +0200
Subject: [LTP] [PATCH 1/2] syscalls/setrlimit02.c: Add a test for EFAULT
In-Reply-To: <1507096320-9130-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1507096320-9130-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20171009142304.GB25633@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> + * DESCRIPTION
> + *  1) Test for EINVAL when resource is invalid.
> + *  2) Test for EFAULT when rlim points outside the accessible address space.
> + *  3) Test for EPERM when an unprivileged process tried to use setrlimit() to
> + *     increase a soft or hard limit.

We increase only the hard limit here hence this description is
misleading, we should say here that unprivileged process is trying to
increase the hard limit.

-- 
Cyril Hrubis
chrubis@suse.cz
