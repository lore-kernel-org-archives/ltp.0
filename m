Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PFQAK-0004qe-Jl
	for ltp-list@lists.sourceforge.net; Mon, 08 Nov 2010 11:45:36 +0000
Received: from mail-ww0-f53.google.com ([74.125.82.53])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PFQAJ-0002HG-Fm
	for ltp-list@lists.sourceforge.net; Mon, 08 Nov 2010 11:45:36 +0000
Received: by wwb31 with SMTP id 31so5424573wwb.10
	for <ltp-list@lists.sourceforge.net>;
	Mon, 08 Nov 2010 03:45:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4CD7D71B.1000605@cn.fujitsu.com>
References: <4CCFD4C8.8060007@cn.fujitsu.com>
	<AANLkTi=ma-dX1YAJgc5sesDx67G75eOMGEUA3+uxOQsu@mail.gmail.com>
	<4CD7D71B.1000605@cn.fujitsu.com>
Date: Mon, 8 Nov 2010 03:45:29 -0800
Message-ID: <AANLkTin99K4+jUWAdYQRdj+XDLpOzBKVd1rdJ_q7hboN@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [POSIX][PATCH]pthread_mutex_getprioceiling should return
 EINVAl when mutex's protocol is PTHREAD_PRIO_NONE.
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
To: Bian Naimeng <biannm@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

2010/11/8 Bian Naimeng <biannm@cn.fujitsu.com>:
>
> Garrett Cooper wrote:
>> On Tue, Nov 2, 2010 at 2:07 AM, Bian Naimeng <biannm@cn.fujitsu.com> wro=
te:
>>> The default value of the mutex's protocol shall be PTHREAD_PRIO_NONE,
>>> so pthread_mutex_getprioceiling should return EINVAL.
>>>
>>> Signed-off-by: Bian Naimeng <biannm@cn.fujitsu.com>
>>>
>>> ---
>>> =A0.../interfaces/pthread_mutex_getprioceiling/1-1.c =A0| =A0 30 ++++++=
++++++++++++++
>>> =A01 files changed, 30 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthr=
ead_mutex_getprioceiling/1-1.c b/testcases/open_posix_testsuite/conformance=
/interfaces/pthread_mutex_getprioceiling/1-1.c
>>> index d9251e6..65c8c6b 100644
>>> --- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mut=
ex_getprioceiling/1-1.c
>>> +++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mut=
ex_getprioceiling/1-1.c
>>> @@ -18,6 +18,7 @@
>>> =A0#include <pthread.h>
>>> =A0#include <stdio.h>
>>> =A0#include <sched.h>
>>> +#include <errno.h>
>>> =A0#include "posixtest.h"
>>>
>>> =A0int main()
>>> @@ -29,6 +30,7 @@ int main()
>>> =A0 =A0 =A0 =A0 =A0return PTS_UNRESOLVED;
>>> =A0 =A0 =A0 =A0#endif */
>>>
>>> + =A0 =A0 =A0 pthread_mutexattr_t mattr;
>>> =A0 =A0 =A0 =A0pthread_mutex_t mutex;
>
> =A0... snip ...
>
>
>>> +
>>> + =A0 =A0 =A0 /* Get the prioceiling of the mutex. */
>>> =A0 =A0 =A0 =A0if(pthread_mutex_getprioceiling(&mutex, &prioceiling) !=
=3D 0)
>>> =A0 =A0 =A0 =A0{
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printf("Test FAILED: Error obtaining the=
 priority ceiling\n");
>>
>> =A0 =A0 A patch similar to this will be committed soon. The above patch
>> has several correctness issues with perror (you have to capture the
>> error and play it back via strerror), and the original test author
>> accidentally mixed up one of the requirements between
>> pthread_mutex_getprioceiling and pthread_mutexattr_getprioceiling as
>> well by accident. This helped unroot a requirements issue on FreeBSD
>> with PTHREAD_PRIO_INHERIT, and it might so similar on Linux.
>
> =A0OK. I think it's better if you can send your patch at this thread. ^_^

http://ltp.git.sourceforge.net/git/gitweb.cgi?p=3Dltp/ltp.git;a=3Dcommit;h=
=3D68332a1

>> =A0 =A0 Partial credit will be `awarded' for having keen eyes on this
>> issue though :).
>
> =A0Thanks very much. ^_^

No problem. Here's the other commit (because I forgot to mention you
in the first one ><):

http://ltp.git.sourceforge.net/git/gitweb.cgi?p=3Dltp/ltp.git;a=3Dcommit;h=
=3D17fb758

Cheers!
-Garrett

---------------------------------------------------------------------------=
---
The Next 800 Companies to Lead America's Growth: New Video Whitepaper
David G. Thomson, author of the best-selling book "Blueprint to a =

Billion" shares his insights and actions to help propel your =

business during the next growth cycle. Listen Now!
http://p.sf.net/sfu/SAP-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
