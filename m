Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapierfilter@gmail.com>) id 1OlSTE-0006wj-5U
	for ltp-list@lists.sourceforge.net; Tue, 17 Aug 2010 20:09:16 +0000
Received: from mail-fx0-f47.google.com ([209.85.161.47])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OlSTD-00082R-9N
	for ltp-list@lists.sourceforge.net; Tue, 17 Aug 2010 20:09:16 +0000
Received: by fxm6 with SMTP id 6so4753127fxm.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 17 Aug 2010 13:09:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTinF=7RB+U6aexwoRzvxnHLMgz73U8U6CVGXD7tj@mail.gmail.com>
References: <4C6AD534.2020109@redhat.com>
	<AANLkTimPmB9fNdv2f+zS42Y_+T+6_4y1enDv=K_sHkY=@mail.gmail.com>
	<AANLkTinneeNUA0NJwh3v_Lhjx=YSHm6dfXNpxVoJHCS=@mail.gmail.com>
	<AANLkTinF=7RB+U6aexwoRzvxnHLMgz73U8U6CVGXD7tj@mail.gmail.com>
Date: Tue, 17 Aug 2010 16:09:09 -0400
Message-ID: <AANLkTi=q=WXuPOqBB7nadhu8iO+tDdM02yGTPi9zykoR@mail.gmail.com>
From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [LTP] problems building mallopt01.c for uClinux
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: dmarlin@redhat.com, LTP list <ltp-list@lists.sourceforge.net>

On Tue, Aug 17, 2010 at 4:05 PM, Garrett Cooper wrote:
> On Tue, Aug 17, 2010 at 1:00 PM, Mike Frysinger wrote:
>> On Tue, Aug 17, 2010 at 3:47 PM, Garrett Cooper wrote:
>>> On Tue, Aug 17, 2010 at 11:30 AM, David Marlin wrote:
>>>> The testcase mallopt01 skips performing the test when UCLINUX=3D1, but=
 the
>>>> mallinfo structure is defined outside the #if !defined(UCLINUX) block.
>>>>
>>>> Attached is a patch to move the mallinfo structure definition inside t=
he
>>>> #if !defined(UCLINUX) block.
>>>
>>> ACK.
>>
>> meaning you're going to merge it ? ;) =A0this change looks fine of cours=
e.
>
> Yeah. ACK -> all's good, I'm going to commit later. I kind of adopted
> it after looking at the yum list, because it's a lot quicker to say
> and less redundant than:
>
> Acked-by: Garrett Cooper <yanegomi@gmail.com>

ok, but following the original LKML style, people who ACK usually
arent the ones who actually pick up & merge
-mike

---------------------------------------------------------------------------=
---
This SF.net email is sponsored by =


Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev =

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
