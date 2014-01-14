Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1W34O0-0001gg-Jf
	for ltp-list@lists.sourceforge.net; Tue, 14 Jan 2014 13:50:32 +0000
Date: Tue, 14 Jan 2014 14:50:07 +0100
From: chrubis@suse.cz
Message-ID: <20140114135007.GA21469@rei>
References: <CADqC_Hq=ivTffZYogdg9doXU1zdGJZM34OhM0deuHJ7RNrO-Gg@mail.gmail.com>
	<CADqC_HrK3E-yrpMFkKAgEg=Eyt9GO0TafKcmD9eG4ZL2zhBVCA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CADqC_HrK3E-yrpMFkKAgEg=Eyt9GO0TafKcmD9eG4ZL2zhBVCA@mail.gmail.com>
Subject: Re: [LTP] Issue with commands
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
To: Asha Gowda <ashagow@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Actually I am getting the same response for all the commands listed before
> "sh: $'mail_tests.sh\r': command not found"
> 
> What could be the issue?

Looks like corrupted text files, most likely wrongly unpacked archive,
have unpacked it on Windows and then copied them to Linux machine?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
CenturyLink Cloud: The Leader in Enterprise Cloud Services.
Learn Why More Businesses Are Choosing CenturyLink Cloud For
Critical Workloads, Development Environments & Everything In Between.
Get a Quote or Start a Free Trial Today. 
http://pubads.g.doubleclick.net/gampad/clk?id=119420431&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
