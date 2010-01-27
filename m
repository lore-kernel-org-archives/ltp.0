Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Na4VZ-0001uO-9O
	for ltp-list@lists.sourceforge.net; Wed, 27 Jan 2010 09:48:21 +0000
Received: from mail-pw0-f43.google.com ([209.85.160.43])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Na4VY-00065D-FF
	for ltp-list@lists.sourceforge.net; Wed, 27 Jan 2010 09:48:21 +0000
Received: by pwj11 with SMTP id 11so3961446pwj.2
	for <ltp-list@lists.sourceforge.net>;
	Wed, 27 Jan 2010 01:48:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4B593DD8.2080207@teldevice.co.jp>
References: <4B593DD8.2080207@teldevice.co.jp>
Date: Wed, 27 Jan 2010 01:48:14 -0800
Message-ID: <364299f41001270148g4a9b14f2ua4ceb75e4df9403c@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] LTP installation configure Error
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
To: TED ITC Agarwal Ashish <ashish.g@teldevice.co.jp>
Cc: LTP Mailing List <ltp-list@lists.sourceforge.net>

2010/1/21 TED ITC Agarwal Ashish <ashish.g@teldevice.co.jp>:
> Hello Shanmuga
>
> This is Ashish Agarwal.
>
> I also had the same problem as you fight with Quota ....
>
> what i got at end is it may be something related to the tools and sw inst=
alled over my system.
>
> i also had fight with the issue last week.
>
>>I am doing cross compilation of LTP with ARM.
>
>>When I do ./configure, I'm also getting the same error message in
>>ltp-full-20091231 release.
>
>> =A0 =A0 =A0 configure: error: Couldn't find functional copy of quota v2 =
- are you >
>>running 2.4.x ?
>>As per your suggestion I have tried to do `man 2 quotactl', I'm getting t=
he
>>following message.
>> =A0 =A0 =A0 =A0No manual entry for quotactl in section 2
>>I have ubuntu in my system. I'm able to cross compile with the previous r=
elease
>>"ltp-full-20091130".
>>Is there any setup is missing in my system for this release?
>>Help me to resolve this issue.
>
>
>
> i had some info mail list achieve can be found at
>
> http://tinyurl.com/yzntwqt
> [converted to tiny URL]

This was `fixed' on CVS HEAD in the past two weeks after someone was
kind enough to help me out by providing the details I needed for quota
v1.

> i was able to do it for the installed kernel over x86 PC. (Fedora 7, kern=
el 2.6.23.17-88 )
>
> but now what i want is to CROSS compile this, if you have any source of i=
nfo about CROSS_COMPILE Issue plz let me know :)
>
> I didn't find any steps how to start with cross compile. :(
>
> i greped the source ltp-full-20091231 for CROSS_COMPILER but it is not pr=
esent to how to start with cross compile is still :x for me
>
> i know it is tricky to ask info from you this way,
> but

    CROSS_COMPILE, etc isn't needed as of 10/31/2009; it may be what
kernel.org does for compiling kernel sources, but it doesn't match
what autoconf enabled packages do, and isn't very flexible if you need
to specify multiple tools with differing prefixes. If you use
appropriate values for AR, CC, CFLAGS, CPPFLAGS, LD, LDFLAGS, and
LDLIBS when calling configure for your environment, you'll achieve
what you need to cross-compile LTP.
    Please see INSTALL as a relevant example on how to use ./configure
appropriately.
HTH,
-Garrett

---------------------------------------------------------------------------=
---
The Planet: dedicated and managed hosting, cloud storage, colocation
Stay online with enterprise data centers and the best network in the busine=
ss
Choose flexible plans and management services without long-term contracts
Personal 24x7 support from experience hosting pros just a phone call away.
http://p.sf.net/sfu/theplanet-com
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
