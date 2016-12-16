From: the_hoang0709@yahoo.com <the_hoang0709@yahoo.com>
Date: Fri, 16 Dec 2016 19:58:35 +0700
Subject: [LTP] [PATCH v2] Fix mistake in strcmp() for skipping in aarch64.
	And there is the same error in aarch64be, so add it.
Message-ID: <20161216125835.12024-1-the_hoang0709@yahoo.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


Signed-off-by: Vertigo <the_hoang0709@yahoo.com>
---
 testcases/kernel/mem/tunable/max_map_count.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-Fix-mistake-in-strcmp-for-skipping-in-aarch64.patch
Type: text/x-patch
Size: 569 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20161216/d5885d64/attachment.bin>
