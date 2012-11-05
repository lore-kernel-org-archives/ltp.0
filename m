Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1TVLtj-00067t-7r
	for ltp-list@lists.sourceforge.net; Mon, 05 Nov 2012 12:35:23 +0000
Date: Mon, 5 Nov 2012 13:32:53 +0100
From: chrubis@suse.cz
Message-ID: <20121105123253.GB24282@rei.suse.cz>
References: <1351894898-14489-1-git-send-email-tdmackey@twitter.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1351894898-14489-1-git-send-email-tdmackey@twitter.com>
Subject: Re: [LTP] [PATCH] proc01: Add EAGAIN to known issues for acpi/event
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
To: David Mackey <tdmackey@twitter.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Calling read on /proc/acpi/event with O_NONBLOCK will return EAGAIN if
> the acpi bus event list is empty and no process is listening for events.
> This is a common return code if acpid is not running.
> 
> - Add EAGAIN to known issues list for /proc/acpi/event.

Commited, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
LogMeIn Central: Instant, anywhere, Remote PC access and management.
Stay in control, update software, and manage PCs from one command center
Diagnose problems and improve visibility into emerging IT issues
Automate, monitor and manage. Do more in less time with Central
http://p.sf.net/sfu/logmein12331_d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
