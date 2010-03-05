Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NnezS-0006GA-D3
	for ltp-list@lists.sourceforge.net; Fri, 05 Mar 2010 21:23:22 +0000
Received: from mail-pw0-f47.google.com ([209.85.160.47])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NnezR-0006PT-H5
	for ltp-list@lists.sourceforge.net; Fri, 05 Mar 2010 21:23:22 +0000
Received: by pwi5 with SMTP id 5so2396407pwi.34
	for <ltp-list@lists.sourceforge.net>;
	Fri, 05 Mar 2010 13:23:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <201003051529.20596.vapier@gentoo.org>
References: <000301cabb68$7fb08c30$7f11a490$@co.jp>
	<201003051529.20596.vapier@gentoo.org>
Date: Fri, 5 Mar 2010 13:23:15 -0800
Message-ID: <364299f41003051323y4c63e0dbx3d721c08296c9524@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] Is there another method to download?
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
Cc: ltp-list@lists.sourceforge.net, Mitani <mitani@ryobi.co.jp>

On Fri, Mar 5, 2010 at 12:29 PM, Mike Frysinger <vapier@gentoo.org> wrote:
> On Thursday 04 March 2010 02:01:22 Mitani wrote:
>> I tried to get source by using GIT.
>> But It failed with following message:
>>
>> ------------
>> # git clone git://ltp.git.sourceforge.net/gitroot/ltp/ltp-dev.git ltp-dev
>> Initialized empty Git repository in /home/mitani/wk/ltp-dev/.git/
>> fatal: Unable to look up ltp.git.sourceforge.net (port 9418) (Temporary
>> failure in name resolution)
>> #
>> ------------
>>
>> It seems to be caused by the fact that port 9418 does not open.
>> This is a problem by me.
>> But I think that there are some companies which don't open a port 9418
>> due to the security. I think that it becomes the problem in those
>> companies that GIT cannot be used.
>>
>> I'm saved very much if there is the method to download via HTTP.
>
> we have no control over this. =A0talk to sf.net about the issue.
>
> in the meantime, use the gitweb interface to download snapshots.

    Can you DNS resolve ltp.git.sourceforge.net from that machine?
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
