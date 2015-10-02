From: Yuriy Kolerov <Yuriy.Kolerov@synopsys.com>
Date: Fri, 2 Oct 2015 12:23:13 +0000
Subject: [LTP] [PATCH] syscalls/setregid02: Fix retrieving a group of
 user "nobody"
In-Reply-To: <1443010817-10169-1-git-send-email-yuriy.kolerov@synopsys.com>
References: <1443010817-10169-1-git-send-email-yuriy.kolerov@synopsys.com>
Message-ID: <3ABF60118B9B784CA5BF7C841D2F00ECFA269F@de02wembxa.internal.synopsys.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello!

Ping.

Regards,
Yuriy Kolerov


> -----Original Message-----
> From: Yuriy Kolerov [mailto:yuriy.kolerov@synopsys.com]
> Sent: Wednesday, September 23, 2015 3:20 PM
> To: ltp@lists.linux.it; Vineet Gupta; Alexey Brodkin; Anton Kolesov
> Cc: Francois Bedard; yuriy.kolerov@synopsys.com
> Subject: [LTP] [PATCH] syscalls/setregid02: Fix retrieving a group of user
> "nobody"
> 
> 
> In setup this test sets UID and GID of the user "nobody". Then it expects that
> user "nobody" is in group "nobody" and tries to retrive a structure for group
> "nobody" using getgrnam(). However some Linux distributions use group
> "nogroup" for user "nobody".
> Thus it's necessary to retrieve a group of user "nobody" not by hardcoded
> name but by its GID. It's necessary because group "nobody" may not exist.
> 
> I've replaced a variable "nobody" by more generic "ltpgroup".
> Then I've splitted a macro GET_GID on GET_GROUP_BY_NAME an
> GET_GROUP_BY_GID and used GET_GROUP_BY_GID for getting a group for
> the user "nobody".
> 
> On my test system I have user "nobody" in group "nogroup". So I've got this
> error messages for this test:
> 
>     ----------->8----------
>     setregid02.c:160: getgrnam("nobody") failed: errno=SUCCESS(0): Success
>     setregid02.c:160: Remaining cases broken
>     ----------->8----------
> 
> Signed-off-by: Yuriy Kolerov <yuriy.kolerov@synopsys.com>
> ---
>  testcases/kernel/syscalls/setregid/setregid02.c | 31 ++++++++++++++++----
> -----
>  1 file changed, 20 insertions(+), 11 deletions(-)

-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-syscalls-setregid02-Fix-retrieving-a-group-of-user-n.patch
Type: application/octet-stream
Size: 2306 bytes
Desc: 0001-syscalls-setregid02-Fix-retrieving-a-group-of-user-n.patch
URL: <http://lists.linux.it/pipermail/ltp/attachments/20151002/f6765d44/attachment.obj>
