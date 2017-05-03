From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 3 May 2017 04:14:30 -0400 (EDT)
Subject: [LTP] [RFC] [PATCH] syscalls/madvise09: Fix for disabled
	swap	accounting
In-Reply-To: <20170502133329.9913-1-chrubis@suse.cz>
References: <20170502133329.9913-1-chrubis@suse.cz>
Message-ID: <696452069.6330211.1493799270469.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> The test had to be fixed for systems with swap accounting disabled.
> 
> First there are no "memsw" prefixed tuning knobs in memcg directories if
> swap accounting is disabled.
> 
> Then we had to limit the hungry child since otherwise it will be killed
> only after all system swap was filled. Hence we exit the memory hungry
> child once the process fills 100MB of swap. That seems to be enough to
> put the cgroup into memory pressure while it limits the test runtime to
> a few seconds.

Looks reasonable to me, only 2 alternatives I can think of is turning
off swap for duration of test, or exit with TCONF if swap accounting
is disabled.

Regards,
Jan
