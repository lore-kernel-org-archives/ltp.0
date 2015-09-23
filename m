From: Yuriy Kolerov <yuriy.kolerov@synopsys.com>
Date: Wed, 23 Sep 2015 15:20:17 +0300
Subject: [LTP] [PATCH] syscalls/setregid02: Fix retrieving a group of user
	"nobody"
Message-ID: <1443010817-10169-1-git-send-email-yuriy.kolerov@synopsys.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


In setup this test sets UID and GID of the user "nobody". Then
it expects that user "nobody" is in group "nobody" and tries to
retrive a structure for group "nobody" using getgrnam(). However
some Linux distributions use group "nogroup" for user "nobody".
Thus it's necessary to retrieve a group of user "nobody" not by
hardcoded name but by its GID. It's necessary because group
"nobody" may not exist.

I've replaced a variable "nobody" by more generic "ltpgroup".
Then I've splitted a macro GET_GID on GET_GROUP_BY_NAME an
GET_GROUP_BY_GID and used GET_GROUP_BY_GID for getting a group
for the user "nobody".

On my test system I have user "nobody" in group "nogroup". So
I've got this error messages for this test:

    ----------->8----------
    setregid02.c:160: getgrnam("nobody") failed: errno=SUCCESS(0): Success
    setregid02.c:160: Remaining cases broken
    ----------->8----------

Signed-off-by: Yuriy Kolerov <yuriy.kolerov@synopsys.com>
---
 testcases/kernel/syscalls/setregid/setregid02.c | 31 ++++++++++++++++---------
 1 file changed, 20 insertions(+), 11 deletions(-)

-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-syscalls-setregid02-Fix-retrieving-a-group-of-user-n.patch
Type: text/x-patch
Size: 2238 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20150923/edef6641/attachment.bin>
