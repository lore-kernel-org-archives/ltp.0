Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1P8dPy-0005dO-Mg
	for ltp-list@lists.sourceforge.net; Wed, 20 Oct 2010 18:29:42 +0000
Received: from mail-ey0-f175.google.com ([209.85.215.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1P8dPx-0004NF-NX
	for ltp-list@lists.sourceforge.net; Wed, 20 Oct 2010 18:29:42 +0000
Received: by eye27 with SMTP id 27so856120eye.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 20 Oct 2010 11:29:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20101020125537.GA3623@hallyn.com>
References: <AANLkTinR7pDvxfq32hkVSFq-wrkiJk-9O1JPkehpKQw-@mail.gmail.com>
	<20101020125537.GA3623@hallyn.com>
Date: Wed, 20 Oct 2010 11:29:35 -0700
Message-ID: <AANLkTi=x90kyOtU1xRHewnL-1yNV=DxJsm_Qk3YQ1EaM@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] smack testcase
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
To: "Serge E. Hallyn" <serge.hallyn@canonical.com>
Cc: ltp-list@lists.sourceforge.net

On Wed, Oct 20, 2010 at 5:55 AM, Serge E. Hallyn
<serge.hallyn@canonical.com> wrote:
> Quoting ARJIT SHARMA (joyarjit@gmail.com):
>> Hi,
>>
>> =A0 =A0 =A0Inside the smack testcase, the sript "smack_common.sh" has a =
function
>> named "check_onlycap()" , please tell me its functionality =A0as every t=
ime
>> this function is reporting that =A0 onlycap is "" not the expected "".
>>
>> the log of the testcase is as follows---
>
> Yeah the check seems backward. =A0Does this patch help?
>
> From efe6116a6b284bb409b7fe9946cf990092183650 Mon Sep 17 00:00:00 2001
> From: Serge Hallyn <serge.hallyn@canonical.com>
> Date: Wed, 20 Oct 2010 07:54:21 -0500
> Subject: [PATCH 1/1] Fix inverted logic testing for string which is NOT e=
mpty
>
> Signed-off-by: Serge Hallyn <serge.hallyn@canonical.com>
> ---
> =A0testcases/kernel/security/smack/smack_common.sh | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/testcases/kernel/security/smack/smack_common.sh b/testcases/=
kernel/security/smack/smack_common.sh
> index eb339f3..25405fe 100755
> --- a/testcases/kernel/security/smack/smack_common.sh
> +++ b/testcases/kernel/security/smack/smack_common.sh
> @@ -36,7 +36,7 @@ check_mounted() {
>
> =A0check_onlycap() {
> =A0 =A0 =A0 =A0onlycap=3D`cat "$smackfsdir/onlycap" 2>/dev/null`
> - =A0 =A0 =A0 if [ -z "$onlycap" ]; then
> + =A0 =A0 =A0 if [ ! -z "$onlycap" ]; then
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cat <<EOM
> =A0The smack label reported for $smackfsdir/onlycap is "$onlycap", not th=
e expected "".
> =A0EOM

    Yes, the logic was backwards. Please try the code I just pushed to
git to see whether or not it works for you (its intent is like
Serge's, but I improved the mount check as well, as it previously just
checked to see whether or not the directory existed, which was silly).
Thanks!
-Garrett

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
