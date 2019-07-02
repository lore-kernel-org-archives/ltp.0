From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 2 Jul 2019 15:00:28 +0200
Subject: [LTP] [PATCH] scenario_groups/default: run the kernel_misc test
 after the cve test
In-Reply-To: <5D19B256.5080609@cn.fujitsu.com>
References: <20190628103900.10113-1-po-hsu.lin@canonical.com>
 <5D19A7E1.10607@cn.fujitsu.com>
 <CAMy_GT96S3dVkevTkE2GUwyz_ugFjb1RsHd_ATARUB-BaYQo6Q@mail.gmail.com>
 <5D19B256.5080609@cn.fujitsu.com>
Message-ID: <20190702130028.GA9252@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> It seems that the value of /proc/sys/kernel/tainted only be increased.

That is by design, since otherwise people would erase the track of
unsigned/out-of-tree modules being loaded...

-- 
Cyril Hrubis
chrubis@suse.cz
