From: the_hoang0709@yahoo.com <the_hoang0709@yahoo.com>
Date: Sun,  9 Apr 2017 15:38:05 +0700
Subject: [LTP]  [PATCH] setpriority01: Fix failure on read-only machine
In-Reply-To: <1491727085-3873-1-git-send-email-the_hoang0709@yahoo.com>
References: <1491727085-3873-1-git-send-email-the_hoang0709@yahoo.com>
Message-ID: <1491727085-3873-2-git-send-email-the_hoang0709@yahoo.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


Return 32 if /etc/passwd is read-only.
Fixes: #137
See also: #88

Signed-off-by: Hoang Nguyen <the_hoang0709@yahoo.com>
---
 testcases/kernel/syscalls/setpriority/setpriority01.c | 5 +++++
 1 file changed, 5 insertions(+)

-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-setpriority01-Fix-failure-on-read-only-machine.patch
Type: text/x-patch
Size: 600 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20170409/2e4ae532/attachment.bin>
