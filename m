Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1SWWGa-0006ta-Ro
	for ltp-list@lists.sourceforge.net; Mon, 21 May 2012 17:19:32 +0000
Received: from mail-yx0-f175.google.com ([209.85.213.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1SWWGX-0002B4-2R
	for ltp-list@lists.sourceforge.net; Mon, 21 May 2012 17:19:32 +0000
Received: by yenl13 with SMTP id l13so5467195yen.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 21 May 2012 10:19:23 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 21 May 2012 10:19:23 -0700
Message-ID: <CAGH67wSN3uk5v5F=ZBsEGuNCZgEsfwNnQZmEjVPmCjY6fdRtqw@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: [LTP] "more-syscalls" branch
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
To: LTP list <ltp-list@lists.sourceforge.net>

    In order to get LTP more up to date and expand breadth of syscall
requirements testing, I'm going to be working on adding more syscall
tests to LTP over the next couple weeks. I started out with
inotify(7), but I want to move on to newer syscalls that exercise MI
(machine independent) functionality, while at the same time do not
want to duplicate work being done by others elsewhere.
    The long and short of it is that I want to update Linux compat in
FreeBSD (or at least provide the tests to do that) and in order to
achieve that, I need up-to-date testcases that pass on an older
version of Fedora running 2.6 (say Fedora 10) and Fedora 17 (runs
3.3). The current testcases are ok, but not exhaustive in all areas
and that's what I'm aiming to improve.
    Thoughts on this and also an idea of where we need to add more
exhaustive testcases (otherwise I'll have to work through the list and
pore over manpages looking for my next "target" :)..)?
Thanks!
-Garrett

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
