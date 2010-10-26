Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PAfrs-000420-JJ
	for ltp-list@lists.sourceforge.net; Tue, 26 Oct 2010 09:30:56 +0000
Received: from mail-wy0-f175.google.com ([74.125.82.175])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PAfrr-00047J-Kt
	for ltp-list@lists.sourceforge.net; Tue, 26 Oct 2010 09:30:56 +0000
Received: by wya21 with SMTP id 21so4275589wya.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 26 Oct 2010 02:30:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTindXutyim_xrTBf86SQbOgPU__6GjhYojDwL+sr@mail.gmail.com>
References: <1140423440.1496611288083756370.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
	<AANLkTindXutyim_xrTBf86SQbOgPU__6GjhYojDwL+sr@mail.gmail.com>
Date: Tue, 26 Oct 2010 02:30:49 -0700
Message-ID: <AANLkTik3wLJHaB4HZCQZ=ha36vc+_OGZnes_Zqpbp+DL@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH v2] fix keyctl01 revoke argument on s390x
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
To: Caspar Zhang <czhang@redhat.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

On Tue, Oct 26, 2010 at 2:29 AM, Garrett Cooper <yanegomi@gmail.com> wrote:
> On Tue, Oct 26, 2010 at 2:02 AM, Caspar Zhang <czhang@redhat.com> wrote:
>> >From 1101aa2287f761df5cfab29806baf49fadd80c34 Mon Sep 17 00:00:00 2001
>> From: Caspar Zhang <casparant@gmail.com>
>> Date: Tue, 26 Oct 2010 16:54:13 +0800
>> Subject: [PATCH] fix keyctl revoke argument
>>
>> add some codes to find an unused id instead of
>> using #define directly.
>>
>> Signed-off-by: Caspar Zhang <czhang@redhat.com>
>>
>> ---
>> =A0testcases/kernel/syscalls/keyctl/keyctl01.c | =A0 15 +++++++++++++--
>> =A01 files changed, 13 insertions(+), 2 deletions(-)
>>
>> diff --git a/testcases/kernel/syscalls/keyctl/keyctl01.c b/testcases/ker=
nel/syscalls/keyctl/keyctl01.c
>> index 292e573..57f334f 100644
>> --- a/testcases/kernel/syscalls/keyctl/keyctl01.c
>> +++ b/testcases/kernel/syscalls/keyctl/keyctl01.c
>> @@ -40,6 +40,7 @@
>>
>> =A0#include <stdio.h>
>> =A0#include <errno.h>
>> +#include <stdint.h>
>> =A0#include <linux/keyctl.h>
>> =A0/* Harness Specific Include Files. */
>> =A0#include "test.h"
>> @@ -110,6 +111,7 @@ void setup() {
>> =A0int main(int ac, char **av) {
>> =A0 =A0 =A0 =A0int ret;
>> =A0 =A0 =A0 =A0int lc; =A0 =A0 =A0 =A0 /* loop counter */
>> + =A0 =A0 =A0 int i, nonexist_key;
>> =A0 =A0 =A0 =A0char *msg; =A0 =A0 =A0/* message returned from parse_opts=
 */
>>
>> =A0 =A0 =A0 =A0/* parse standard options */
>> @@ -126,7 +128,7 @@ int main(int ac, char **av) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Tst_count =3D 0;
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0for (testno =3D 1; testno < TST_TOTAL; ++=
testno) {
>> -
>> +
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Call keyctl() and ask =
for a keyring's ID. */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D syscall(__NR_keyc=
tl, KEYCTL_GET_KEYRING_ID,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0KEY_SPEC_USER_SESSION_KEYRING);
>> @@ -136,8 +138,17 @@ int main(int ac, char **av) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(=
TFAIL | TERRNO, "KEYCTL_GET_KEYRING_ID");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* find a non-existed key =
*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D INT32_MAX; i > =
-INT32_MAX; --i)
>
> INT32_MIN is actually preferred over INT32_MAX as that would be an
> invalid value (integers are represented in two's complement).

Sorry, misstated this -- the negative value would be correct. The
positive value would be wrong.

>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D sy=
scall(__NR_keyctl, KEYCTL_READ, i);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret =
=3D=3D -1 && errno =3D=3D ENOKEY)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 nonexist_key =3D i;
>
> This is ok, but you could actually get rid of i entirely and just
> decrement nonexist_key :).
>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Call keyctl. */
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D syscall(__NR_keyct=
l, KEYCTL_REVOKE, "MyKey");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D syscall(__NR_keyct=
l, KEYCTL_REVOKE, nonexist_key);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ret !=3D -1) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(=
TFAIL | TERRNO, "KEYCTL_REVOKE succeeded unexpectly");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
>
> Otherwise, the trivial patch looks ok :).

---------------------------------------------------------------------------=
---
Nokia and AT&T present the 2010 Calling All Innovators-North America contest
Create new apps & games for the Nokia N8 for consumers in  U.S. and Canada
$10 million total in prizes - $4M cash, 500 devices, nearly $6M in marketing
Develop with Nokia Qt SDK, Web Runtime, or Java and Publish to Ovi Store =

http://p.sf.net/sfu/nokia-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
