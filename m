Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PfSoG-0001Nm-0G
	for ltp-list@lists.sourceforge.net; Wed, 19 Jan 2011 07:50:28 +0000
Received: from mail-ww0-f41.google.com ([74.125.82.41])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.72) id 1PfSoF-0008Pc-40
	for ltp-list@lists.sourceforge.net; Wed, 19 Jan 2011 07:50:27 +0000
Received: by wwi18 with SMTP id 18so326214wwi.4
	for <ltp-list@lists.sourceforge.net>;
	Tue, 18 Jan 2011 23:50:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4D367AF5.5070905@cn.fujitsu.com>
References: <4D367AF5.5070905@cn.fujitsu.com>
Date: Tue, 18 Jan 2011 23:50:20 -0800
Message-ID: <AANLkTinKh4BD1uKJK1YZvYv+LgBWt8ZVFSuEkn73tDuC@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] creat07: "-F $LTPROOT/testcases/bin/test1" should
 be removed
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
To: Peng Haitao <penght@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

On Tue, Jan 18, 2011 at 9:47 PM, Peng Haitao <penght@cn.fujitsu.com> wrote:
> Hi Garrett,
>
> "-F $LTPROOT/testcases/bin/test1" should be removed when execute creat07.

Committed -- thanks!
-Garrett

------------------------------------------------------------------------------
Protect Your Site and Customers from Malware Attacks
Learn about various malware tactics and how to avoid them. Understand 
malware threats, the impact they can have on your business, and how you 
can protect your company and customers by using code signing.
http://p.sf.net/sfu/oracle-sfdevnl
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
