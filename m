Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1SUsV8-0003ma-Oa
	for ltp-list@lists.sourceforge.net; Thu, 17 May 2012 04:39:46 +0000
Received: from mail-ob0-f175.google.com ([209.85.214.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1SUsV7-0004Hm-UF
	for ltp-list@lists.sourceforge.net; Thu, 17 May 2012 04:39:46 +0000
Received: by obhx4 with SMTP id x4so2673618obh.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 16 May 2012 21:39:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4FB466B6.8060508@cn.fujitsu.com>
References: <20120516145353.GA12228@saboteur.suse.cz>
	<1337219962-5782-1-git-send-email-penght@cn.fujitsu.com>
	<4FB45E98.3010506@cn.fujitsu.com>
	<CAGH67wSxwhPXQ_j5ryRQe4-en-wYf3iLUgrn9xtcQ54dR1FsaA@mail.gmail.com>
	<4FB46381.2010400@cn.fujitsu.com>
	<CAGH67wTa2Y6mXP9Wv229s8Wdzp57uN=hcB63eEvW6Ud0osdUOw@mail.gmail.com>
	<CAGH67wStJk_mqT46zqJ5FPNHLEeBjcyPo6i050xMwmpCm5aoBQ@mail.gmail.com>
	<4FB466B6.8060508@cn.fujitsu.com>
Date: Wed, 16 May 2012 21:39:40 -0700
Message-ID: <CAGH67wSv02CxLFBDDuO8dRWNp03AmHmnYqTd3UN2mQkF8SO8ZQ@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH v2] ltp-pan.c: fix error of Total Tests
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
To: Peng Haitao <penght@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

On Wed, May 16, 2012 at 7:47 PM, Peng Haitao <penght@cn.fujitsu.com> wrote:
>
> Garrett Cooper said the following on 2012-5-17 10:40:
>>> You can easily trigger this problem with the following spoofed runtest =
scenario:
>>>
>>> aok echo "hello"
>>> donotexist donotexist
>>> exit_quickly exit 1
>>> true true
>>>
>
> The test log is as follows:
>
> Running tests.......
> <<<test_start>>>
> tag=3Daok stime=3D1337251363
> cmdline=3D"echo "hello""
> contacts=3D""
> analysis=3Dexit
> <<<test_output>>>
> hello
> <<<execution_status>>>
> initiation_status=3D"ok"
> duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
> cutime=3D0 cstime=3D0
> <<<test_end>>>
> <<<test_start>>>
> tag=3Ddonotexist stime=3D1337251363
> cmdline=3D"donotexist"
> contacts=3D""
> analysis=3Dexit
> <<<test_output>>>
> <<<execution_status>>>
> initiation_status=3D"pan(17520): execvp of 'donotexist' (tag donotexist) =
failed. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 errno:2 =A0No such file or directory"
> duration=3D0 termination_type=3Dexited termination_id=3D2 corefile=3Dno
> cutime=3D0 cstime=3D0
> <<<test_end>>>
> <<<test_start>>>
> tag=3Dexit_quickly stime=3D1337251363
> cmdline=3D"exit 1"
> contacts=3D""
> analysis=3Dexit
> <<<test_output>>>
> <<<execution_status>>>
> initiation_status=3D"pan(17520): execvp of 'exit' (tag exit_quickly) fail=
ed. =A0errn =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 o:2 =A0No such file or directory"

I suppose it would have worked, had this actually been a command and
not a shell built-in. Could you please replace 'exit 1' with 'false'?

...

Thanks!
-Garrett

---------------------------------------------------------------------------=
---
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and =

threat landscape has changed and how IT managers can respond. Discussions =

will include endpoint security, mobile security and the latest in malware =

threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
