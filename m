Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MNwmI-0001cT-9F
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 22:35:14 +0000
Received: from mail-yx0-f195.google.com ([209.85.210.195])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MNwm7-0006ft-Ao
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 22:35:09 +0000
Received: by yxe33 with SMTP id 33so5198067yxe.28
	for <ltp-list@lists.sourceforge.net>;
	Mon, 06 Jul 2009 15:35:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <200907061810.04510.vapier@gentoo.org>
References: <364299f40907061455n2f95c877sb40d6a97e856fd03@mail.gmail.com>
	<200907061810.04510.vapier@gentoo.org>
Date: Mon, 6 Jul 2009 15:35:02 -0700
Message-ID: <364299f40907061535s19bbe0b8o3c716b5320f2f9f8@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Content-Type: multipart/mixed; boundary=0016e644cc6ef1f178046e111d5e
Subject: Re: [LTP] [PATCH] Missing limits.h include and test.h style in
	system_specific_process_info.c
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Mike Frysinger <vapier@gentoo.org>
Cc: ltp-list@lists.sourceforge.net

--0016e644cc6ef1f178046e111d5e
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2009 at 3:10 PM, Mike Frysinger<vapier@gentoo.org> wrote:
> On Monday 06 July 2009 17:55:43 Garrett Cooper wrote:
>> 1. test.h is in .../include/. Thus #include should be #include
>> "test.h", not #include <test.h>.
>> 2. limits.h should be explicitly stated because certain constants are
>> used in system_specific_process_info.c (SHRT_MAX for instance).
>>
>> Signed-off-by: Garrett Cooper <yanegomi@gmail.com>
>
> unified diffs only please. =A0context diffs are awful.

And again.
-Garrett

--0016e644cc6ef1f178046e111d5e
Content-Type: application/octet-stream; 
	name="system-specific-process-info-fix-includes.diff"
Content-Disposition: attachment; 
	filename="system-specific-process-info-fix-includes.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fwtrsa2f1

SW5kZXg6IGxpYi9zeXN0ZW1fc3BlY2lmaWNfcHJvY2Vzc19pbmZvLmMKPT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQpSQ1Mg
ZmlsZTogL2N2c3Jvb3QvbHRwL2x0cC9saWIvc3lzdGVtX3NwZWNpZmljX3Byb2Nlc3NfaW5mby5j
LHYKcmV0cmlldmluZyByZXZpc2lvbiAxLjIKZGlmZiAtdSAtcjEuMiBzeXN0ZW1fc3BlY2lmaWNf
cHJvY2Vzc19pbmZvLmMKLS0tIGxpYi9zeXN0ZW1fc3BlY2lmaWNfcHJvY2Vzc19pbmZvLmMJMjcg
SmFuIDIwMDkgMTQ6NDg6MzggLTAwMDAJMS4yCisrKyBsaWIvc3lzdGVtX3NwZWNpZmljX3Byb2Nl
c3NfaW5mby5jCTYgSnVsIDIwMDkgMjI6MzI6NDQgLTAwMDAKQEAgLTI3LDEwICsyNywxMCBAQAog
ICovCiAKIAotCiAjaW5jbHVkZSA8ZmNudGwuaD4KKyNpbmNsdWRlIDxsaW1pdHMuaD4KICNpbmNs
dWRlIDxzeXMvdHlwZXMuaD4KLSNpbmNsdWRlIDx0ZXN0Lmg+CisjaW5jbHVkZSAidGVzdC5oIgog
CiAjZGVmaW5lIEJVRlNJWkUgNTEyCiAK
--0016e644cc6ef1f178046e111d5e
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--0016e644cc6ef1f178046e111d5e
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--0016e644cc6ef1f178046e111d5e--

