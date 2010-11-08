Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PFZDi-0007GP-TQ
	for ltp-list@lists.sourceforge.net; Mon, 08 Nov 2010 21:25:42 +0000
Received: from mail-ey0-f175.google.com ([209.85.215.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PFZDh-0000uc-NJ
	for ltp-list@lists.sourceforge.net; Mon, 08 Nov 2010 21:25:42 +0000
Received: by mail-ey0-f175.google.com with SMTP id 28so3081283eya.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 08 Nov 2010 13:25:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4CCFC531.9090509@cn.fujitsu.com>
References: <4CCFC177.8070102@cn.fujitsu.com> <4CCFC531.9090509@cn.fujitsu.com>
Date: Mon, 8 Nov 2010 13:25:41 -0800
Message-ID: <AANLkTikSEryW9jCDcKA9q0bq_7fRE8L+PMvL1ioiG8Xk@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [POSIX][PATCH] Remove POSIX non-compliant API
	pthread_getattr_np
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

On Tue, Nov 2, 2010 at 1:00 AM, Bian Naimeng <biannm@cn.fujitsu.com> wrote:
> Sorry to make a noise, please ignore this patch.
> However, maybe PTS_UNRESOLVED is better if "ssize !=3D stacksize" at the =
child thread.
>
> Bian Naimeng wrote:
>> The pthread_getattr_np is not a POSIX compliant API, it's unnecessary to=
 test it.
>>
>> Signed-off-by: Bian Naimeng <biannm@cn.fujitsu.com>
>>
>> ---
>> =A0.../interfaces/pthread_attr_setstacksize/2-1.c =A0 =A0 | =A0 17 ++++-=
------------
>> =A01 files changed, 4 insertions(+), 13 deletions(-)
>>
>> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthre=
ad_attr_setstacksize/2-1.c b/testcases/open_posix_testsuite/conformance/int=
erfaces/pthread_attr_setstacksize/2-1.c
>> index 668fd96..c91c946 100644
>> --- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr=
_setstacksize/2-1.c
>> +++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr=
_setstacksize/2-1.c
>> @@ -14,7 +14,6 @@
>> =A0 * 4. =A0In the created thread, read stacksize
>> =A0 */
>>
>> -/* For pthread_getattr_np(3) -- not a POSIX compliant API */
>> =A0#ifndef _GNU_SOURCE
>> =A0#define _GNU_SOURCE
>> =A0#endif
>> @@ -35,21 +34,13 @@
>> =A0size_t stack_size;
>> =A0void *stack_addr;
>>
>> -void *thread_func()
>> +void *thread_func(void *arg)
>> =A0{
>> - =A0 =A0 pthread_attr_t attr;
>> + =A0 =A0 pthread_attr_t *pattr =3D (pthread_attr_t *)arg;
>> =A0 =A0 =A0 size_t ssize;
>> =A0 =A0 =A0 int rc;
>>
>> - =A0 =A0 if ((rc =3D pthread_getattr_np(pthread_self(), &attr)) !=3D 0)=
 {
>> - =A0 =A0 =A0 =A0 =A0 =A0 printf(ERROR_PREFIX "pthread_getattr_np: %s\n"=
, strerror(rc));
>> - =A0 =A0 =A0 =A0 =A0 =A0 exit(PTS_FAIL);
>> - =A0 =A0 }
>> - =A0 =A0 if ((rc =3D pthread_attr_init(&attr)) !=3D 0) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 printf(ERROR_PREFIX "pthread_attr_init: %s\n",=
 strerror(rc));
>> - =A0 =A0 =A0 =A0 =A0 =A0 exit(PTS_FAIL);
>> - =A0 =A0 }
>> - =A0 =A0 if ((rc =3D pthread_attr_getstacksize(&attr, &ssize)) !=3D 0) {
>> + =A0 =A0 if ((rc =3D pthread_attr_getstacksize(pattr, &ssize)) !=3D 0) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 printf(ERROR_PREFIX "pthread_attr_getstacksi=
ze: %s\n",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 strerror(rc));
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 exit(PTS_FAIL);
>> @@ -106,7 +97,7 @@ int main()
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0exit(PTS_UNRESOLVED);
>> =A0 =A0 =A0 =A0 =A0}
>>
>> - =A0 =A0 rc =3D pthread_create(&new_th, &attr, thread_func, NULL);
>> + =A0 =A0 rc =3D pthread_create(&new_th, &attr, thread_func, &attr);
>> =A0 =A0 =A0 if (rc !=3D 0) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printf(ERROR_PREFIX "pthread_create: =
%s\n", strerror(rc));
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0exit(PTS_FAIL);

Possibly, but the only problem with that is that there really needs to
be a means to sample the current thread stack size. That's what's
missing that needs to go into the POSIX spec.
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
