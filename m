Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UsBOD-0006mG-Qn
	for ltp-list@lists.sourceforge.net; Thu, 27 Jun 2013 12:33:29 +0000
Date: Thu, 27 Jun 2013 14:35:00 +0200
From: chrubis@suse.cz
Message-ID: <20130627123500.GC5384@rei>
References: <51C95F37.3000409@cn.fujitsu.com> <20130625141727.GK31268@rei>
	<51CA495D.9090500@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51CA495D.9090500@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v2] mmap/mmap12.c: new case to test MAP_POPULATE
 of mmap
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
To: DAN LI <li.dan@cn.fujitsu.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

> >> +	while (num_pages > 0) {
> >> +		ret = read(pm, &pagemap, sizeof(unsigned long long));
> >> +		if (ret < 0)
> >> +			tst_brkm(TFAIL | TERRNO, NULL, "Read pagemap failed");
> >> +		/*
> >> +		 * Check if the page is present.
> >> +		 */
> >> +		if (!(pagemap & (1ULL<<63))) {
> >> +			close(pm);
> >> +			fclose(maps);
> >> +			return 1;
> > 
> > I would perpahs be more verbose here and go over all of the pages and
> > list these that are not mapped, but that is a minor nitpick. 
> > 
> 
> You mean listing every page which is not present?

Yes please, nothing fancy just short message with address of the page
and its ordering number in the mapping printed using tst_resm with
TINFO.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
