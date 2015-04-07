Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YfTNW-0002cy-Pm
	for ltp-list@lists.sourceforge.net; Tue, 07 Apr 2015 13:17:18 +0000
Date: Tue, 7 Apr 2015 15:16:59 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150407131658.GB9535@rei>
References: <fcfdc0e76da63f0dac43e44738a6d5f85e638ada.1428407537.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <fcfdc0e76da63f0dac43e44738a6d5f85e638ada.1428407537.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH] mtest06: pick a distant address to mmap at
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Test expects, that either file is mmaped and read will
> result in expected pattern or file is not mapped and
> read will trigger SIGSEGV.
> 
> However there is also possibility that unrelated mmap,
> (e.g. from pthread_exit or printf call chain) will pick the
> same area between munmap/mmap calls for map_address, which
> creates a race where data read from map_address are unexpected.
> 
> This patch makes a dummy mmap/munmap of large block to find
> some distant location, where futher mmap calls are unlikely
> to occur. Middle of this area is then used to mmap map_address.

Acked and I suppose that this should be pushed to the git before the
release.

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
