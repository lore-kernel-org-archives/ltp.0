Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1RiEAD-0000b5-7N
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 23:53:05 +0000
Received: from mail-tul01m020-f175.google.com ([209.85.214.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1RiEAC-0006a3-FV
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 23:53:05 +0000
Received: by obcwn6 with SMTP id wn6so18559546obc.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 03 Jan 2012 15:52:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <201201031834.45745.vapier@gentoo.org>
References: <4F02DBAF.5040202@imgtec.com>
	<201201031557.08072.vapier@gentoo.org>
	<CAGH67wSrnkWdC8vYubfur6p2-Vs03F6LKvnZumtb-ZW-dWLy8g@mail.gmail.com>
	<201201031834.45745.vapier@gentoo.org>
Date: Tue, 3 Jan 2012 15:52:58 -0800
Message-ID: <CAGH67wQD7miw85g3mBGrjnx3nCo=gy1vutqbTmM2LnrOOYfi5w@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH 05/21] syscalls: Cast st_nlink variables to proper
	integers
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

On Tue, Jan 3, 2012 at 3:34 PM, Mike Frysinger <vapier@gentoo.org> wrote:
> On Tuesday 03 January 2012 17:19:25 Garrett Cooper wrote:
>> The 'solution' for the issues with
>> format strings and long integers is generally cast to [u]intmax_t,
>> then use %zd or %zu.
>
> eek, almost ;)
>
> ssize_t -> %zd
> size_t -> %zu
> intmax_t -> %jd
> uintmax_t -> %ju

Yeah (lol)... thanks for the correction :)!
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
