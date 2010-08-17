Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1OlSQ5-0005jA-N3
	for ltp-list@lists.sourceforge.net; Tue, 17 Aug 2010 20:06:01 +0000
Received: from mail-bw0-f47.google.com ([209.85.214.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OlSQ4-0007fC-Ur
	for ltp-list@lists.sourceforge.net; Tue, 17 Aug 2010 20:06:01 +0000
Received: by bwz12 with SMTP id 12so4095426bwz.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 17 Aug 2010 13:05:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTinneeNUA0NJwh3v_Lhjx=YSHm6dfXNpxVoJHCS=@mail.gmail.com>
References: <4C6AD534.2020109@redhat.com>
	<AANLkTimPmB9fNdv2f+zS42Y_+T+6_4y1enDv=K_sHkY=@mail.gmail.com>
	<AANLkTinneeNUA0NJwh3v_Lhjx=YSHm6dfXNpxVoJHCS=@mail.gmail.com>
Date: Tue, 17 Aug 2010 13:05:54 -0700
Message-ID: <AANLkTinF=7RB+U6aexwoRzvxnHLMgz73U8U6CVGXD7tj@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: dmarlin@redhat.com, LTP list <ltp-list@lists.sourceforge.net>

On Tue, Aug 17, 2010 at 1:00 PM, Mike Frysinger <vapier@gentoo.org> wrote:
> On Tue, Aug 17, 2010 at 3:47 PM, Garrett Cooper wrote:
>> On Tue, Aug 17, 2010 at 11:30 AM, David Marlin wrote:
>>> The testcase mallopt01 skips performing the test when UCLINUX=3D1, but =
the
>>> mallinfo structure is defined outside the #if !defined(UCLINUX) block.
>>>
>>> Attached is a patch to move the mallinfo structure definition inside the
>>> #if !defined(UCLINUX) block.
>>
>> ACK.
>
> meaning you're going to merge it ? ;) =A0this change looks fine of course.

Yeah. ACK -> all's good, I'm going to commit later. I kind of adopted
it after looking at the yum list, because it's a lot quicker to say
and less redundant than:

Acked-by: Garrett Cooper <yanegomi@gmail.com>

;)...

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
