From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 3 Aug 2021 17:20:26 +0200
Subject: [LTP] [PATCH v2] shmget02: check if CONFIG_HUGETLBFS enabled in
 kernel
In-Reply-To: <20210802160620.9544-1-bogdan.lezhepekov@suse.com>
References: <20210802160620.9544-1-bogdan.lezhepekov@suse.com>
Message-ID: <YQleuulCqCGvyiju@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Two tests call shmget with a flag SHM_HUGETLB, trying to
> allocate the segment using "huge" pages. The hugetlbpage
> support needs to be enabled in kernel (CONFIG_HUGETLBFS),
> otherwise shmget returns EINVAL.

There are a few minor style problems in the patch, have you checked it
with checkpatch.pl and make check as described in:

https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#2-coding-style

https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#6-test-contribution-checklist

-- 
Cyril Hrubis
chrubis@suse.cz
