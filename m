Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PBVuR-0005Nw-9g
	for ltp-list@lists.sourceforge.net; Thu, 28 Oct 2010 17:05:03 +0000
Received: from mail-ww0-f41.google.com ([74.125.82.41])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PBVuQ-00023Y-3u
	for ltp-list@lists.sourceforge.net; Thu, 28 Oct 2010 17:05:03 +0000
Received: by wwe15 with SMTP id 15so1390290wwe.4
	for <ltp-list@lists.sourceforge.net>;
	Thu, 28 Oct 2010 10:04:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4CC96358.1000108@linux.vnet.ibm.com>
References: <AANLkTinKu3Kx0FMdgvvG34rc6tcv4Wt5qV1jaAnGzHnv@mail.gmail.com>
	<4CC8464F.80605@linux.vnet.ibm.com>
	<AANLkTikAcaMa0zZ_pfrW_W8H=VqhCvMge8wm+AFbpSEs@mail.gmail.com>
	<4CC96358.1000108@linux.vnet.ibm.com>
Date: Thu, 28 Oct 2010 10:04:56 -0700
Message-ID: <AANLkTik9KxUzfv=g_YC5D1E_12kcvrRR+Y5yMqDy8Fff@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] Realtime tests on embedded target
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
To: gowrishankar <gowrishankar.m@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net, David Peverley <pev@sketchymonkey.com>

On Thu, Oct 28, 2010 at 4:49 AM, gowrishankar
<gowrishankar.m@linux.vnet.ibm.com> wrote:
> On Wednesday 27 October 2010 09:34 PM, David Peverley wrote:
>>
>> Hi Gowrishankar,
>>
>> I've just pulled down this version and it behaves the same for me?!
>> The build sequence I am performing is :
>>
>> =A0 =A0$ cd ltp-full-20100630
>> =A0 =A0$ =A0./configure --build=3Di686-pc-linux --host=3Darm-none-linux-=
gnueabi
>> --prefix=3D/opt/ltp-20100630
>> =A0 =A0$ make all
>> =A0 =A0$ mkdir ~/test-sysroot
>> =A0 =A0$ make SKIP_IDCHECK=3D1 DESTDIR=3D~/test-sysroot install
>> =A0 =A0$ find ~/test-sysroot | grep "testcases/realtime"
>>
>>
>
> Right, I too observed the same.
>
> Garrett, any idea on to turn installation of RT tests ?

    I'm going to keep the existing hierarchy under
testcases/realtime/... for consistency and because I don't want to
rewrite a bunch of test scripts to live nicely under testcases/bin/...
    I'll work on this in the next couple of days; completing this task
will be trivial.
Thanks!
-Garrett

>> This shows no files installed...?! If I take the cross compile out of
>> the equation and build natively :
>> =A0 =A0$ make distclean
>> =A0 =A0$ =A0./configure
>> =A0 =A0$ make all
>> =A0 =A0$ rm -rf ~/test-sysroot/*
>> =A0 =A0$ make SKIP_IDCHECK=3D1 DESTDIR=3D~/test-sysroot install
>> =A0 =A0$ find ~/test-sysroot | grep "testcases/realtime"
>>
>> This also behaves the same way!
>>
>> Looking at your output, I just realised that you don't run a "make
>> install" so I'm guessing that implies that you're not doing this and
>> are executing your tests directly from the source / build tree which
>> would explain the discrepancy?
>>
>> Also, on my second point, what are your thoughts on the fact that the
>> test-run scripts invoke make/gcc which is a problem for embedded
>> targets?
>>
>> Cheers,
>>
>> ~Pev
>>
>>
>>
>> On 27 October 2010 16:33, gowrishankar
>> <gowrishankar.m@linux.vnet.ibm.com> =A0wrote:
>>
>>>
>>> On Wednesday 27 October 2010 06:13 PM, David Peverley wrote:
>>>
>>>>
>>>> Hi all,
>>>>
>>>> I've managed to get to the point where I should be able to run the
>>>> realtime tests on my target but there are a few issues :
>>>>
>>>>
>>>>
>>>
>>> Hi David,
>>>
>>> We have not encountered such issues in our environment.
>>> I usually do:
>>> ltp:> =A0./configure
>>> ltp:> =A0make
>>> ltp:> =A0cd testcases/realtime
>>> ltp:> =A0make
>>>
>>> and run tests either through test_realtime.sh or run.sh in
>>> testcases/realtime/ .
>>>
>>> By the way, I am using last stable (atleast for RT) release
>>> ltp-full-20100630 .
>>>
>>> Can you please let us know which version you are trying atm.
>>> Also, can you please check ltp-full-20100630 ?
>>>
>>> Thanks,
>>> Gowrishankar
>>>
>>>>
>>>> 1) The run script "testscripts/test_realtime.sh" sources
>>>> "$LTPROOT/testcases/realtime/scripts/setenv.sh" - this isn't copied by
>>>> make install.
>>>>
>>>> 2) After manually copying in, "setenv.sh" sets up paths to use test
>>>> definitions under "$LTPROOT/testcases/realtime/" - these aren't copied
>>>> by make install either.
>>>>
>>>> 3 ) Generally we now have a bit of a pain as various scripts now try
>>>> to invoke "make" - I think this should really only be a build-time
>>>> thing and not part of the test run scritps? Is this actually necessary
>>>> as most embedded targets aren't likely to have local make/gcc! I've
>>>> commented them out for now for initial testing...
>>>>
>>>> 4) After copying in the whole of "testcases/realtime" I run a
>>>> run_auto.sh script (sched_jitter/run_auto.sh) this fails as it's
>>>> looking for the executable in its working dir (I guess where the
>>>> scripts make pass would have put it). However, the previous build and
>>>> make install put all the executables in $LTPROOT/testcases/bin as
>>>> you'd expect.
>>>>
>>>> I'd be happy to address& =A0 =A0submit changes but these are significa=
nt
>>>> changes to make so it would make sense to check with stake-holders
>>>> first if anyone's aware or looking at this actively?
>>>>
>>>> Cheers,
>>>>
>>>> ~Pev
>>>>
>>>>
>>>>
>>>> ----------------------------------------------------------------------=
--------
>>>> Nokia and AT&T present the 2010 Calling All Innovators-North America
>>>> contest
>>>> Create new apps& =A0 =A0games for the Nokia N8 for consumers in =A0U.S=
. and
>>>> Canada
>>>> $10 million total in prizes - $4M cash, 500 devices, nearly $6M in
>>>> marketing
>>>> Develop with Nokia Qt SDK, Web Runtime, or Java and Publish to Ovi Sto=
re
>>>> http://p.sf.net/sfu/nokia-dev2dev
>>>> _______________________________________________
>>>> Ltp-list mailing list
>>>> Ltp-list@lists.sourceforge.net
>>>> https://lists.sourceforge.net/lists/listinfo/ltp-list
>>>>
>>>>
>>>>
>>>
>>>
>>
>>
>> ------------------------------------------------------------------------=
------
>> Nokia and AT&T present the 2010 Calling All Innovators-North America
>> contest
>> Create new apps& =A0games for the Nokia N8 for consumers in =A0U.S. and =
Canada
>> $10 million total in prizes - $4M cash, 500 devices, nearly $6M in
>> marketing
>> Develop with Nokia Qt SDK, Web Runtime, or Java and Publish to Ovi Store
>> http://p.sf.net/sfu/nokia-dev2dev
>> _______________________________________________
>> Ltp-list mailing list
>> Ltp-list@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/ltp-list
>>
>>
>
>

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
