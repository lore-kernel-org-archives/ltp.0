Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1URmEK-00039k-5E
	for ltp-list@lists.sourceforge.net; Mon, 15 Apr 2013 16:26:08 +0000
Date: Mon, 15 Apr 2013 18:26:51 +0200
From: chrubis@suse.cz
Message-ID: <20130415162650.GA2405@rei>
References: <cover.1366016616.git.zliu@redhat.com>
	<9ef6222c6ec4ae13864cb6983a907fe41704cb16.1366016616.git.zliu@redhat.com>
	<20130415124305.GC1091@rei> <516C211C.1040105@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <516C211C.1040105@redhat.com>
Subject: Re: [LTP] [PATCH v4 1/3] mm/thp: new case thp04.c
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
To: Zhouping Liu <zliu@redhat.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

Hi!
> >> +		 * or not.
> >> +		 */
> >> +		sleep(10);
> >> +		count++;
> >> +
> >> +		SAFE_FILE_SCANF(cleanup, PATH_KHPD "pages_collapsed",
> >> +			       "%ld", &pages_collapsed);
> >> +		SAFE_FILE_SCANF(cleanup, PATH_KHPD "max_ptes_none",
> >> +			       "%ld", &max_ptes_none);
> >> +		SAFE_FILE_SCANF(cleanup, PATH_KHPD "pages_to_scan",
> >> +			       "%ld", &pages_to_scan);
> >> +
> >> +		if (pages_collapsed != old_pages_collapsed ||
> >> +		    max_ptes_none != old_max_ptes_none ||
> >> +		    pages_to_scan != old_pages_to_scan) {
> >> +			old_pages_collapsed = pages_collapsed;
> >> +			old_max_ptes_none = max_ptes_none;
> >> +			old_pages_to_scan = pages_to_scan;
> >> +		} else {
> >> +			changing = 0;
> >> +		}
> >> +	}
> >> +
> >> +	tst_resm(TINFO, "khugepaged daemon takes %ds to scan all thp pages",
> >> +		 count * 10);
> >> +}
> > Ah, so it acutally does polling, this is fine.
> >
> > How long scanning takes. If it is about 10 seconds, we should poll
> > faster so that the testcase has chance to finish reasonably fast.
> > (if it takes 10 seconds and we miss the first windows it will sleep
> >   doing noting for another ten seconds)
> 
> so how about 5 seconds? I will test the value on different systems.

If the scan takes 10 seconds to finish I would go for 2 seconds sleep as
that can increase the duration maximally by 20%, which is not as bad as
100% or 50%. The overhead of opening and reading a file should be really
small.

> >> +	write_file(path, "always");
> > Where this came from? Does the function check for failures? Why not to
> > use SAFE_FILE_PRINTF() as the rest of the file?
> 
> yes, there's some confused issue here.
> 
> but I have tried to use SAFE_FILE_PRINTF, but it didn't work fine for 
> transparent_hugepage/enabled,
> if # cat /sys/kernel/mm/transparent_hugepage/enabled
>        always [madvise] never
> SAFE_FILE_PRINTF only get 'always', expected 'madvise'
> if # cat /sys/kernel/mm/transparent_hugepage/enabled
> [always] madvise never
> SAFE_FILE_PRINTF get '[always]', expected 'always'
> 
> I didn't find the reason why SAFE_FILE_PRINTF couldn't get the expected 
> value?

That is strange, the only difference is that SAFE_FILE_PRINTF() uses
FILE interface while write_file() uses file descriptor directly.
Otherwise they should do exactly the same in this case. If they don't
something is broken.

Do you have a snipped of code that misbehaves this way?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Precog is a next-generation analytics platform capable of advanced
analytics on semi-structured data. The platform includes APIs for building
apps and a phenomenal toolset for data science. Developers can use
our toolset for easy data analysis & visualization. Get a free account!
http://www2.precog.com/precogplatform/slashdotnewsletter
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
