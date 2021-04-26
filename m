From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 26 Apr 2021 14:50:21 +0200
Subject: [LTP] [PATCH] Modify the test logic of mincore.
In-Reply-To: <f73913c8-f6ca-d8ea-60c8-e4002ac16dba@uniontech.com>
References: <20210330104613.1059-1-zhanglianjie@uniontech.com>
 <YHRcJOUer87SUn6v@yuki>
 <cded02a5-6668-8524-d588-b965ed1a7086@uniontech.com>
 <YHgd/NDLJzz68uDl@yuki>
 <e3eabee4-6616-84dc-cc8d-bc4f23228637@uniontech.com>
 <YH1H4qZwqSNom4RO@yuki>
 <f73913c8-f6ca-d8ea-60c8-e4002ac16dba@uniontech.com>
Message-ID: <YIa3Dbsl7FY6IC8f@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> The test was passed before the cve patch was applied, and the test
> failed after the patch was applied, and the test results were the same
> on both the x86 and mips architectures.
>
> This cve patch changes mincore() to count "mapped" pages instead of 
> "cached" pages.

I've looked at at the mincore code and found what is your problem. The
initiall patch that fixed the CVE was wrong and later reverted and
replaced with a different fix:

commit 134fca9063ad4851de767d1768180e5dede9a881
Author: Jiri Kosina <jkosina@suse.cz>
Date:   Tue May 14 15:41:38 2019 -0700

    mm/mincore.c: make mincore() more conservative


So it's your kernel that is broken and the test is fine.

-- 
Cyril Hrubis
chrubis@suse.cz
