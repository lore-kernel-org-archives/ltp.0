Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1Ri9yH-00013o-RU
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 19:24:29 +0000
Received: from mail-tul01m020-f175.google.com ([209.85.214.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Ri9yH-0006ja-33
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 19:24:29 +0000
Received: by obcwn6 with SMTP id wn6so18149496obc.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 03 Jan 2012 11:24:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4F02E1B9.2090603@imgtec.com>
References: <4F02E1B9.2090603@imgtec.com>
Date: Tue, 3 Jan 2012 11:24:23 -0800
Message-ID: <CAGH67wRnBFxdBgQos0Px8GscXQ+Sn30JNmM-z2KU7-v6Vc7d3A@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH 09/21] realtime/lib/Makefile: Fix path for
	config.mk
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

On Tue, Jan 3, 2012 at 3:08 AM, Markos Chandras
<Markos.Chandras@imgtec.com> wrote:
> Hi, please review the attached patch

No -- this breaks out-of-tree compiles.
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
