Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PBVlK-0004f3-OG
	for ltp-list@lists.sourceforge.net; Thu, 28 Oct 2010 16:55:38 +0000
Received: from mail-fx0-f47.google.com ([209.85.161.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PBVlJ-0000nZ-Gw
	for ltp-list@lists.sourceforge.net; Thu, 28 Oct 2010 16:55:38 +0000
Received: by fxm3 with SMTP id 3so2181751fxm.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 28 Oct 2010 09:55:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <000a01cb7649$81dee5f0$859cb1d0$@co.jp>
References: <4CC8D7DE.9060700@cn.fujitsu.com>
	<000a01cb7649$81dee5f0$859cb1d0$@co.jp>
Date: Thu, 28 Oct 2010 09:55:31 -0700
Message-ID: <AANLkTikcco_LCUZQyunWNwWA3g_11ZD-sBpaWtvXj_+r@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] Fix all tests pass error
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
To: Mitani <mitani@ryobi.co.jp>
Cc: ltp-list@lists.sourceforge.net

On Wed, Oct 27, 2010 at 7:40 PM, Mitani <mitani@ryobi.co.jp> wrote:
>> -----Original Message-----
>> From: Gui Jianfeng [mailto:guijianfeng@cn.fujitsu.com]
>> Sent: Thursday, October 28, 2010 10:55 AM
>> To: Garrett Cooper
>> Cc: mitani@ryobi.co.jp; ltp-list@lists.sourceforge.net
>> Subject: [PATCH] Fix all tests pass error
>>
>> ret_code comes from "set +x" which always return 0, this makes all tests
>> PASS.
>> Actually, "set +x" isn't needed here, just get rid of it.
>>
>> Signed-off-by: Gui Jianfeng <guijianfeng@cn.fujitsu.com>
>> ---
>> =A0testcases/open_posix_testsuite/bin/run-tests.sh | =A0 =A02 --
>> =A01 files changed, 0 insertions(+), 2 deletions(-)
>>
>> diff --git a/testcases/open_posix_testsuite/bin/run-tests.sh
>> b/testcases/open_posix_testsuite/bin/run-tests.sh
>> index 6a03856..04a39dd 100755
>> --- a/testcases/open_posix_testsuite/bin/run-tests.sh
>> +++ b/testcases/open_posix_testsuite/bin/run-tests.sh
>> @@ -48,8 +48,6 @@ run_test() {
>>
>> =A0 =A0 =A0 sh -c "$SCRIPT_DIR/t0 $TIMEOUT_VAL ./$1 $(cat ./$(echo "$1"
>> | sed 's,\.[^\.]*,,').args 2>/dev/null)" > $complog 2>&1
>>
>> - =A0 =A0 set +x
>> -
>> =A0 =A0 =A0 ret_code=3D$?
>>
>> =A0 =A0 =A0 if [ "$ret_code" =3D "0" ]; then
>> --
>> 1.7.0.4
>
>
> Great!
>
> I was forestalled :)
> I have the same opinion, too.

Fixed -- thanks :/...
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
