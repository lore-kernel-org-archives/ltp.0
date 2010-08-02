Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <gurudas.pai@oracle.com>) id 1OfpIX-0000UY-ST
	for ltp-list@lists.sourceforge.net; Mon, 02 Aug 2010 07:18:57 +0000
Received: from rcsinet10.oracle.com ([148.87.113.121])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OfpIT-00010t-Vl
	for ltp-list@lists.sourceforge.net; Mon, 02 Aug 2010 07:18:57 +0000
Message-ID: <4C566EB5.5060202@oracle.com>
Date: Mon, 02 Aug 2010 12:37:33 +0530
From: Gurudas Pai <gurudas.pai@oracle.com>
MIME-Version: 1.0
References: <4C56646B.2060702@oracle.com>	<AANLkTinw4gJOzmkxf=0WVGGekfzecmW8CkwbKrKaad_o@mail.gmail.com>	<4C566914.6070205@oracle.com>
	<AANLkTik5-mTC+1iSB8u9ouvOs_7CJTMuPoWQYhvVbnN0@mail.gmail.com>
In-Reply-To: <AANLkTik5-mTC+1iSB8u9ouvOs_7CJTMuPoWQYhvVbnN0@mail.gmail.com>
Subject: Re: [LTP] LTP-20100630:tcore.sh test fails
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
Cc: ltp-list@lists.sourceforge.net

>>
>> Test is still failing , do you think this is an os issue ?
> 
> Don't know. Some more digging would need to be done in terms of
> whether or not the binary is properly SSE compiled (because XMM
> appears to be an SSE register according to a quick google search), and
> you should probably check with the binutils/gdb/redhat folks for more
> details about changes to the binutils, gdb, and/or libelf packages.
> 
Thanks, will look into this and update.

Thanks a lot for your time and effort :)

-Guru

------------------------------------------------------------------------------
The Palm PDK Hot Apps Program offers developers who use the
Plug-In Development Kit to bring their C/C++ apps to Palm for a share
of $1 Million in cash or HP Products. Visit us here for more details:
http://p.sf.net/sfu/dev2dev-palm
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
