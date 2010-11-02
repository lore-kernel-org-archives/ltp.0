Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PD6Gy-0006tB-BE
	for ltp-list@lists.sourceforge.net; Tue, 02 Nov 2010 02:06:52 +0000
Received: from mail-wy0-f175.google.com ([74.125.82.175])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PD6Gx-0003Jr-G8
	for ltp-list@lists.sourceforge.net; Tue, 02 Nov 2010 02:06:52 +0000
Received: by wya21 with SMTP id 21so6309568wya.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 01 Nov 2010 19:06:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4CCF7166.1050105@cn.fujitsu.com>
References: <4CCF6B53.5050109@cn.fujitsu.com>
	<AANLkTimZFKMZ3YYjr7k3gkjagZUXwwWyjw5YjTfVLURO@mail.gmail.com>
	<4CCF7166.1050105@cn.fujitsu.com>
Date: Mon, 1 Nov 2010 19:06:45 -0700
Message-ID: <AANLkTinQU6f8kzND7j28bgnvzi8GvpAv0kLTZcfww2_Q@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [POSIX][PATCH]Cleanup the test shm_open/2-1 to make a
	good format
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

On Mon, Nov 1, 2010 at 7:03 PM, Bian Naimeng <biannm@cn.fujitsu.com> wrote:
>>> ---
>>> =A0.../conformance/interfaces/shm_open/2-1.c =A0 =A0 =A0 =A0 =A0| =A0 =
=A04 +++-
>>> =A01 files changed, 3 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/shm_=
open/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/shm_open=
/2-1.c
>>> index f4bab48..b0adce6 100644
>>> --- a/testcases/open_posix_testsuite/conformance/interfaces/shm_open/2-=
1.c
>>> +++ b/testcases/open_posix_testsuite/conformance/interfaces/shm_open/2-=
1.c
>>> @@ -17,7 +17,9 @@
>>>
>>> =A0int main()
>>> =A0{
>>> - =A0 =A0 =A0 =A0printf("Will not test that the shm_open() function cre=
ate an open file description\nthat refers to the shared memory object and a=
 file descriptor that refers to\nthat open file description.");
>>> + =A0 =A0 =A0 =A0printf("Will not test that the shm_open() function cre=
ate an open file"
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0"description that refers to the shared mem=
ory object and a file"
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0"descriptor that refers to that open file =
description.\n");
>>> =A0 =A0 =A0 =A0 return PTS_UNTESTED;
>>> =A0}
>>
>> =A0 =A0 Actually, that will look a lot worse because you just removed so=
me
>> spaces in areas. description should be descriptor, etc.
>
> =A0Yes, it's my mistake. Thank you for pointing out it. ^_^

I'm tempted to just delete this test because it's a no-op. Anyone object?

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
