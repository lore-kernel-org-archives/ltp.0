Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NqKoy-0002it-6f
	for ltp-list@lists.sourceforge.net; Sat, 13 Mar 2010 06:27:36 +0000
Received: from mail-iw0-f176.google.com ([209.85.223.176])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NqKox-0004GY-F7
	for ltp-list@lists.sourceforge.net; Sat, 13 Mar 2010 06:27:36 +0000
Received: by iwn6 with SMTP id 6so382232iwn.4
	for <ltp-list@lists.sourceforge.net>;
	Fri, 12 Mar 2010 22:27:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4B9B0B3A.3080008@cn.fujitsu.com>
References: <4B9B0B3A.3080008@cn.fujitsu.com>
Date: Fri, 12 Mar 2010 22:27:30 -0800
Message-ID: <364299f41003122227w6859d6f3i829466a6fc5099f2@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [BUG?] proc01: read /proc/acpi/event failed if acpi
	daemon stopped
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
To: Shi Weihua <shiwh@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

On Fri, Mar 12, 2010 at 7:49 PM, Shi Weihua <shiwh@cn.fujitsu.com> wrote:
> An error message occured when i tested proc01.
> ---------
> proc01 =A0 =A0 =A01 =A0TFAIL =A0: =A0read failed: /proc/acpi/event: errno=
=3DEAGAIN(11): Resource temporarily unavailable
> ---------
>
> If "service acpid start", this message will be turned to:
> ---------
> proc01 =A0 =A0 =A00 =A0TINFO =A0: =A0/proc/acpi/event: known issue: errno=
=3DEBUSY(16): Device or resource busy
> ---------
>
> I think we should to add a check of acpi daemon's status in testcases/ker=
nel/fs/proc/proc01.c.

    No, that's making things too complicated and won't scale as every
distro has developed a different means for specifying the status for a
service. Why not just add EAGAIN for that /proc node?
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
