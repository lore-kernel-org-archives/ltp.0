Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1RiAEX-0005up-Rd
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 19:41:17 +0000
Received: from mail-tul01m020-f175.google.com ([209.85.214.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1RiAEX-0007Zq-7n
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 19:41:17 +0000
Received: by mail-tul01m020-f175.google.com with SMTP id wn6so18177194obc.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 03 Jan 2012 11:41:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4F03012E.40901@imgtec.com>
References: <4F03012E.40901@imgtec.com>
Date: Tue, 3 Jan 2012 11:41:17 -0800
Message-ID: <CAGH67wSkZqMJJ9u_o-LGVKzx-gnTb7ydd6U9s=tCa8x6Uwq_FA@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH 17/21] network/lib6/asapi_04: Cast pointer
 arithmetic to proper integer
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
To: Markos Chandras <Markos.Chandras@imgtec.com>
Cc: ltp-list@lists.sourceforge.net

On Tue, Jan 3, 2012 at 5:22 AM, Markos Chandras
<Markos.Chandras@imgtec.com> wrote:
> Hi, please review the attached patch

    "%p" is better.
Thanks,
-Garrett

------------------------------------------------------------------------------
Write once. Port to many.
Get the SDK and tools to simplify cross-platform app development. Create 
new or port existing apps to sell to consumers worldwide. Explore the 
Intel AppUpSM program developer opportunity. appdeveloper.intel.com/join
http://p.sf.net/sfu/intel-appdev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
