Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1RiDdU-0006Mc-1u
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 23:19:16 +0000
Received: from mail-tul01m020-f175.google.com ([209.85.214.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1RiDdT-00060M-IF
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 23:19:16 +0000
Received: by obcwn6 with SMTP id wn6so18522569obc.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 03 Jan 2012 15:19:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <201201031529.03842.vapier@gentoo.org>
References: <4F02CD36.2010600@imgtec.com>
	<201201031529.03842.vapier@gentoo.org>
Date: Tue, 3 Jan 2012 15:19:10 -0800
Message-ID: <CAGH67wTawMPbNFgRrnkC=1rogn32-C36kJHERhZJSYKTvS-fFg@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH 04/21] syscalls: Use %zu modifier to print
 variables of type size_t
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
Cc: ltp-list@lists.sourceforge.net, Markos Chandras <Markos.Chandras@imgtec.com>

On Tue, Jan 3, 2012 at 12:29 PM, Mike Frysinger <vapier@gentoo.org> wrote:
> On Tuesday 03 January 2012 04:41:10 Markos Chandras wrote:
>> Hi, please review the attached patch
>
> using %zu for size_t is good

+1.
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
