From: Yuriy Kolerov <yuriy.kolerov@synopsys.com>
Date: Wed, 16 Sep 2015 17:46:15 +0300
Subject: [LTP] [PATCH v2] Include config.mk and features.mk in env_pre.mk
	for all targets
Message-ID: <1442414775-16702-1-git-send-email-yuriy.kolerov@synopsys.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


If config.mk or features.mk doesn't exist it's not an error
for some targets which are filtered below (e.g. clean).
However these config files may be needed for those targets
thus it would be wise to do silent inclusion.

In particular open_posix_testsuite is not cleaned without
including these .mk files.

Signed-off-by: Yuriy Kolerov <yuriy.kolerov@synopsys.com>
---
 include/mk/env_pre.mk | 7 +++++++
 1 file changed, 7 insertions(+)

-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-Include-config.mk-and-features.mk-in-env_pre.mk-for-.patch
Type: text/x-patch
Size: 704 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20150916/16d6ee80/attachment.bin>
