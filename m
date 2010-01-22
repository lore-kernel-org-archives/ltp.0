Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NYAxX-0007ry-Il
	for ltp-list@lists.sourceforge.net; Fri, 22 Jan 2010 04:17:23 +0000
Received: from mail-pw0-f43.google.com ([209.85.160.43])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NYAxW-0005NP-RL
	for ltp-list@lists.sourceforge.net; Fri, 22 Jan 2010 04:17:23 +0000
Received: by pwj11 with SMTP id 11so537169pwj.2
	for <ltp-list@lists.sourceforge.net>;
	Thu, 21 Jan 2010 20:17:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4B591601.701@teldevice.co.jp>
References: <0016e649c930347566047d6e6c5b@google.com>
	<4B591601.701@teldevice.co.jp>
Date: Thu, 21 Jan 2010 20:17:16 -0800
Message-ID: <364299f41001212017l4f4f4f26sc316ad193b7bbf8e@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] i.MX31 Platform Embedded Linux LTP Test
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

On Thu, Jan 21, 2010 at 7:05 PM, TED ITC Agarwal Ashish
<ashish.g@teldevice.co.jp> wrote:
> Hi All
>
> As i am novice to LTP. thanks for your help.
>
>
>> =A0 =A0Please read the INSTALL file for more details on how to configure,
>>compile, and install LTP. The out-of-build-tree method may be suitable
>>for your needs.
>>HTH,
>> -Garrett
>
>
>> cross compile LTP for the target board and port only binary for the
>> required test cases and the required scripts.
>>--
>>md.zafar.ziya
>
>
> yes it is true that Cross compile option will help me out.
> but the main target for now is to how to cross compile LTP.
>
> i did goo' for the cross compile steps or hints but not got any specific
> help from whr i have to start
> or wch way i will proceed.
>
> like some questions mention that there were some settings to the makefile
>
> ------------------------------------
>
> CROSS_COMPILER=3D/opt/ppc64/powerpc64-linux/bin/powerpc64-linux-
> CROSS_CFLAGS=3D -mpowerpc64
> LDFLAGS=3D-static
> LOADLIBES=3D-lpthread -lc -lresolv -lnss_dns -lnss_files -lm -lc
> LIB_DIR=3D/lib64
> export LOADLIBES LIB_DIR
> ---------------------------------------
>
> i had no idea about what to do where to do :(
>
> really it feels you terrible ...
>
> but i had no other choice .. i tried to search lot but not succeeded
> :-(
>
> Please suggest me any link that can help me or the starting point manual
>
> any language material will be a gre8 help :)
>
> --
> Ashish
>
>
>
> md.zafar.ziya@gmail.com ????????:
>>
>> Hi,
>>
>> cross compile LTP for the target board and port only binary for the
>> required test cases and the required scripts.

What versions of LTP are you gentlemen using?
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Confere=
nce
attendees to learn about information security's most important issues throu=
gh
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
