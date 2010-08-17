Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapierfilter@gmail.com>) id 1OlSL6-0005Lh-7b
	for ltp-list@lists.sourceforge.net; Tue, 17 Aug 2010 20:00:52 +0000
Received: from mail-fx0-f47.google.com ([209.85.161.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OlSL5-0006TM-Bh
	for ltp-list@lists.sourceforge.net; Tue, 17 Aug 2010 20:00:52 +0000
Received: by fxm6 with SMTP id 6so4746456fxm.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 17 Aug 2010 13:00:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTimPmB9fNdv2f+zS42Y_+T+6_4y1enDv=K_sHkY=@mail.gmail.com>
References: <4C6AD534.2020109@redhat.com>
	<AANLkTimPmB9fNdv2f+zS42Y_+T+6_4y1enDv=K_sHkY=@mail.gmail.com>
Date: Tue, 17 Aug 2010 16:00:45 -0400
Message-ID: <AANLkTinneeNUA0NJwh3v_Lhjx=YSHm6dfXNpxVoJHCS=@mail.gmail.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: dmarlin@redhat.com, LTP list <ltp-list@lists.sourceforge.net>

On Tue, Aug 17, 2010 at 3:47 PM, Garrett Cooper wrote:
> On Tue, Aug 17, 2010 at 11:30 AM, David Marlin wrote:
>> The testcase mallopt01 skips performing the test when UCLINUX=1, but the
>> mallinfo structure is defined outside the #if !defined(UCLINUX) block.
>>
>> Attached is a patch to move the mallinfo structure definition inside the
>> #if !defined(UCLINUX) block.
>
> ACK.

meaning you're going to merge it ? ;)  this change looks fine of course.
-mike

------------------------------------------------------------------------------
This SF.net email is sponsored by 

Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
