Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1URipJ-000564-Oj
	for ltp-list@lists.sourceforge.net; Mon, 15 Apr 2013 12:48:05 +0000
Date: Mon, 15 Apr 2013 14:48:52 +0200
From: chrubis@suse.cz
Message-ID: <20130415124851.GD1091@rei>
References: <cover.1366016616.git.zliu@redhat.com>
	<6ef835ef36aa173ec83872bddf13673a6aa47f18.1366016616.git.zliu@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6ef835ef36aa173ec83872bddf13673a6aa47f18.1366016616.git.zliu@redhat.com>
Subject: Re: [LTP] [PATCH v4 3/3] mm/thp: add new case thp05
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
> +	snprintf(path, BUFSIZ, PATH_KHPD "scan_sleep_millisecs");
> +	SAFE_FILE_SCANF(NULL, path, "%d", &pre_thp_scan_sleep_millisecs);
> +	SAFE_FILE_PRINTF(cleanup, path, "%d", 0);
> +
> +	snprintf(path, BUFSIZ, PATH_KHPD "alloc_sleep_millisecs");
> +	SAFE_FILE_SCANF(NULL, path, "%d", &pre_thp_alloc_sleep_millisecs);
> +	SAFE_FILE_PRINTF(NULL, path, "%d", 0);
> +
> +	snprintf(path, BUFSIZ, PATH_THP "enabled");
> +	write_file(path, "always");

Same as the previous one. Remove the useless snprintf() and pass the
strings directly.

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
