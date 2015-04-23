Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YlF3w-0008Mm-FZ
	for ltp-list@lists.sourceforge.net; Thu, 23 Apr 2015 11:12:56 +0000
Date: Thu, 23 Apr 2015 13:12:30 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150423111230.GC18237@rei.suse.de>
References: <1427752830-21595-1-git-send-email-ceh@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1427752830-21595-1-git-send-email-ceh@ti.com>
Subject: Re: [LTP] [ltp][PATCH] daemonlib.sh: Don't assume service support
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
To: Carlos Hernandez <ceh@ti.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Some systems (i.e. embedded distributions) do not support service.
> Instead /etc/init.d/ scripts are called directly. So use service if
> available otherwise try to start daemon by calling /etc/init.d/
> script.

Pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
BPM Camp - Free Virtual Workshop May 6th at 10am PDT/1PM EDT
Develop your own process in accordance with the BPMN 2 standard
Learn Process modeling best practices with Bonita BPM through live exercises
http://www.bonitasoft.com/be-part-of-it/events/bpm-camp-virtual- event?utm_
source=Sourceforge_BPM_Camp_5_6_15&utm_medium=email&utm_campaign=VA_SF
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
