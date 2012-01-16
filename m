Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Jin.Li@windriver.com>) id 1RmfwG-0001p5-Uy
	for ltp-list@lists.sourceforge.net; Mon, 16 Jan 2012 06:21:04 +0000
Received: from mail1.windriver.com ([147.11.146.13])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RmfwG-0003aE-3h
	for ltp-list@lists.sourceforge.net; Mon, 16 Jan 2012 06:21:04 +0000
Message-ID: <4F13C1C0.3050307@windriver.com>
Date: Mon, 16 Jan 2012 14:20:48 +0800
From: Jin Li <Jin.Li@windriver.com>
MIME-Version: 1.0
References: <4F13940B.8050209@windriver.com>
	<201201160047.33401.vapier@gentoo.org>
In-Reply-To: <201201160047.33401.vapier@gentoo.org>
Subject: Re: [LTP] A question about mktemp in script runltp
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: ltp-list@lists.sourceforge.net



Mike Frysinger wrote:
> On Sunday 15 January 2012 22:05:47 Jin Li wrote:
>> In runltp script, mktemp is used to create a temp directory. see below :
>>
>> mnt_pnt=`mktemp -d --tmpdir=${TMP} mnt_pnt.XXXXXX`
>>
>> But I have a little confused about the argument "--tmpdir"
>>
>> I prefer to use "-p ${TMP}" to replace "--tmpdir=${TMP}"
> 
> why ?

o, I see the difference.

I am using the mktemp from 30 September 2001.

It is so old that can't recognize the argument "--tmpdir"

It's time to update my Linux.

Jin

> -mike

------------------------------------------------------------------------------
RSA(R) Conference 2012
Mar 27 - Feb 2
Save $400 by Jan. 27
Register now!
http://p.sf.net/sfu/rsa-sfdev2dev2
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
