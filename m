Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1RkIlN-0004kr-Rr
	for ltp-list@lists.sourceforge.net; Mon, 09 Jan 2012 17:12:01 +0000
Received: from mail-tul01m020-f175.google.com ([209.85.214.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1RkIlI-0008JU-8b
	for ltp-list@lists.sourceforge.net; Mon, 09 Jan 2012 17:12:01 +0000
Received: by obcwn6 with SMTP id wn6so5759328obc.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 09 Jan 2012 09:11:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20120109105133.GB27172@eguan-t400.redhat.com>
References: <1326102275-32485-1-git-send-email-caspar@casparzhang.com>
	<20120109105133.GB27172@eguan-t400.redhat.com>
Date: Mon, 9 Jan 2012 09:11:50 -0800
Message-ID: <CAGH67wSHbU+1ptij7-X9ysU2CZXFOxtD7NYD9Yn0SuRtXThaUg@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] syscalls/xattr: fix compile when xattr.h not exist
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Eryu Guan <eguan@redhat.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

On Mon, Jan 9, 2012 at 2:51 AM, Eryu Guan <eguan@redhat.com> wrote:
> On Mon, Jan 09, 2012 at 05:44:35PM +0800, Caspar Zhang wrote:
>>
>> if <attr/xattr.h> doesn't exist, compliation will fail. Fix it in
>> autotools level.
>
> Tested on system without xattr.h and everything worked fine.
>
> Thanks for fixing this!
>
> Eryu Guan
>>
>> Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
>> ---
>> =A0configure.ac =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0| =A0 =A01 +
>> =A0testcases/kernel/syscalls/getxattr/getxattr01.c | =A0 15 ++++++++++++=
+--
>> =A0testcases/kernel/syscalls/getxattr/getxattr02.c | =A0 16 ++++++++++++=
+---
>> =A0testcases/kernel/syscalls/setxattr/setxattr01.c | =A0 15 ++++++++++++=
+--
>> =A0testcases/kernel/syscalls/setxattr/setxattr02.c | =A0 16 ++++++++++++=
+---
>> =A05 files changed, 53 insertions(+), 10 deletions(-)
>>
>
>> diff --git a/configure.ac b/configure.ac
>> index 00d3720..6b3870a 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -36,6 +36,7 @@ AC_CHECK_HEADERS([ \
>> =A0 =A0 =A0libaio.h \
>> =A0 =A0 =A0mm.h \
>> =A0 =A0 =A0pthread.h \
>> + =A0 =A0attr/xattr.h \
>> =A0 =A0 =A0linux/genetlink.h \
>> =A0 =A0 =A0linux/mempolicy.h \
>> =A0 =A0 =A0linux/module.h \
>> diff --git a/testcases/kernel/syscalls/getxattr/getxattr01.c b/testcases=
/kernel/syscalls/getxattr/getxattr01.c
>> index 8db6743..c74ffc9 100644
>> --- a/testcases/kernel/syscalls/getxattr/getxattr01.c
>> +++ b/testcases/kernel/syscalls/getxattr/getxattr01.c
>> @@ -37,7 +37,6 @@
>>
>> =A0#include <sys/types.h>
>> =A0#include <sys/stat.h>
>> -#include <attr/xattr.h>
>> =A0#include <errno.h>
>> =A0#include <fcntl.h>
>> =A0#include <unistd.h>
>> @@ -45,9 +44,16 @@
>> =A0#include <stdlib.h>
>> =A0#include <string.h>
>>
>> +#include "config.h"
>> =A0#include "test.h"
>> =A0#include "usctest.h"
>>
>> +char *TCID =3D "getxattr01";
>> +
>> +#ifdef HAVE_ATTR_XATTR_H
>> +
>> +#include <attr/xattr.h>
>> +
>> =A0#define XATTR_TEST_KEY "user.testkey"
>> =A0#define XATTR_TEST_VALUE "this is a test value"
>> =A0#define XATTR_TEST_VALUE_SIZE 20
>> @@ -56,7 +62,6 @@
>> =A0static void setup(void);
>> =A0static void cleanup(void);
>>
>> -char *TCID =3D "getxattr01";
>> =A0char filename[BUFSIZ];
>>
>> =A0struct test_case {
>> @@ -171,3 +176,9 @@ static void cleanup(void)
>> =A0 =A0 =A0 TEST_CLEANUP;
>> =A0 =A0 =A0 tst_rmdir();
>> =A0}
>> +#else /* HAVE_ATTR_XATTR_H */
>> +int main(int argc, char *argv[])
>> +{
>> + =A0 =A0 tst_brkm(TCONF, NULL, "<attr/xattr.h> does not exist.");
>> +}
>> +#endif
>> diff --git a/testcases/kernel/syscalls/getxattr/getxattr02.c b/testcases=
/kernel/syscalls/getxattr/getxattr02.c
>> index 54d8949..52c5812 100644
>> --- a/testcases/kernel/syscalls/getxattr/getxattr02.c
>> +++ b/testcases/kernel/syscalls/getxattr/getxattr02.c
>> @@ -41,7 +41,6 @@
>> =A0#include <sys/types.h>
>> =A0#include <sys/stat.h>
>> =A0#include <sys/wait.h>
>> -#include <attr/xattr.h>
>> =A0#include <errno.h>
>> =A0#include <fcntl.h>
>> =A0#include <unistd.h>
>> @@ -50,9 +49,16 @@
>> =A0#include <stdlib.h>
>> =A0#include <string.h>
>>
>> +#include "config.h"
>> =A0#include "test.h"
>> =A0#include "usctest.h"
>>
>> +char *TCID =3D "getxattr02";
>> +
>> +#ifdef HAVE_ATTR_XATTR_H
>> +
>> +#include <attr/xattr.h>

The only thing requested is that:

#ifdef HAVE_ATTR_XATTR_H
#include <attr/xattr.h>
#endif

(please note the whitespace difference) be moved further up in the
file to be sorted properly with the rest of the #includes, as noted in
the style guide.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Ridiculously easy VDI. With Citrix VDI-in-a-Box, you don't need a complex
infrastructure or vast IT resources to deliver seamless, secure access to
virtual desktops. With this all-in-one solution, easily deploy virtual =

desktops for less than the cost of PCs and save 60% on VDI infrastructure =

costs. Try it free! http://p.sf.net/sfu/Citrix-VDIinabox
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
