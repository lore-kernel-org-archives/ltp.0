Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1N5J0k-0001p7-PA
	for ltp-list@lists.sourceforge.net; Tue, 03 Nov 2009 13:01:22 +0000
Received: from mail-pz0-f191.google.com ([209.85.222.191])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N5J0c-0008NZ-VP
	for ltp-list@lists.sourceforge.net; Tue, 03 Nov 2009 13:01:22 +0000
MIME-Version: 1.0
In-Reply-To: <1257238010.5162.12.camel@subratamodak.linux.ibm.com>
References: <1257220567.10382.3.camel@munipradeep-laptop>
	<1257221513.11048.1.camel@munipradeep-laptop>
	<1257238010.5162.12.camel@subratamodak.linux.ibm.com>
Date: Tue, 3 Nov 2009 05:01:08 -0800
Message-ID: <364299f40911030501y1c16a694r4ef8bfbfc80cb9cf@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [Ltp-results] Got warning message on ltp-full-20091031
	while running ./configure
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
To: subrata@linux.vnet.ibm.com
Cc: ltp-list <ltp-list@lists.sf.net>

On Tue, Nov 3, 2009 at 12:46 AM, Subrata Modak
<subrata@linux.vnet.ibm.com> wrote:
> Muni,
>
> This should be reported to LTP Mailing list. Garret, can you just look
> into this ?
>
> Regards--
> Subrata
>
> On Tue, 2009-11-03 at 09:41 +0530, Munipradeep Beerakam wrote:
>> Hi,
>>
>> In addition to that I also got the below warning as well. Forgot to add
>> it before.
>>
>> configure: WARNING: linux/netlink.h: present but cannot be compiled
>> configure: WARNING: linux/netlink.h: =A0 =A0 check for missing prerequis=
ite
>> headers?
>> configure: WARNING: linux/netlink.h: see the Autoconf documentation
>> configure: WARNING: linux/netlink.h: =A0 =A0 section "Present But Cannot=
 Be
>> Compiled"
>> configure: WARNING: linux/netlink.h: proceeding with the preprocessor's
>> result
>> configure: WARNING: linux/netlink.h: in the future, the compiler will
>> take precedence
>> configure: WARNING: =A0 =A0 ##
>> ------------------------------------------------ ##
>> configure: WARNING: =A0 =A0 ## Report this to
>> ltp-results@lists.sourceforge.net ##
>> configure: WARNING: =A0 =A0 ##
>> ------------------------------------------------ ##
>>
>> Thanks
>> Muni
>>
>> On Tue, 2009-11-03 at 09:26 +0530, Munipradeep Beerakam wrote:
>> > Hi,
>> >
>> > I got the following warning messages while running "./configure" on the
>> > ltp-full-20091031. However, make and make install worked fine.
>> >
>> > configure: WARNING: linux/genetlink.h: present but cannot be compiled
>> > configure: WARNING: linux/genetlink.h: =A0 =A0 check for missing
>> > prerequisite headers?
>> > configure: WARNING: linux/genetlink.h: see the Autoconf documentation
>> > configure: WARNING: linux/genetlink.h: =A0 =A0 section "Present But Ca=
nnot
>> > Be Compiled"
>> > configure: WARNING: linux/genetlink.h: proceeding with the
>> > preprocessor's result
>> > configure: WARNING: linux/genetlink.h: in the future, the compiler will
>> > take precedence
>> > configure: WARNING: =A0 =A0 ##
>> > ------------------------------------------------ ##
>> > configure: WARNING: =A0 =A0 ## Report this to
>> > ltp-results@lists.sourceforge.net ##
>> > configure: WARNING: =A0 =A0 ##
>> > ------------------------------------------------ ##

    Yeah -- I need to find the header that defines u32 (instead of
uint32 or uint32_t). Does anyone know which one was that again? I
thought it was a kernel specific datatype (and in that event it
shouldn't be exported).
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay =

ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
