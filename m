Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1US3Kb-00046f-9a
	for ltp-list@lists.sourceforge.net; Tue, 16 Apr 2013 10:41:45 +0000
Date: Tue, 16 Apr 2013 12:42:29 +0200
From: chrubis@suse.cz
Message-ID: <20130416104228.GA17259@rei>
References: <cover.1366107814.git.zliu@redhat.com>
	<a6942bb2d9d35f695b5067a7008620110c769222.1366107814.git.zliu@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a6942bb2d9d35f695b5067a7008620110c769222.1366107814.git.zliu@redhat.com>
Subject: Re: [LTP] [PATCH v5 3/3] mm/thp: add new case thp05
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
Here is the last nit (the rest of the code looks ok).

Applies for the next test as well.

> +void setup(void)
> +{
> +	char path[BUFSIZ];
> +
> +	tst_require_root(NULL);
> +
> +	if (access(PATH_THP, F_OK) == -1)
> +		tst_brkm(TCONF, NULL, "THP is not enabled");
> +
> +	if (!is_numa(NULL))
> +		tst_brkm(TCONF, NULL, "The case need a NUMA system.");
> +
> +	SAFE_FILE_SCANF(NULL, PATH_KHPD "scan_sleep_millisecs",
> +			"%d", &pre_thp_scan_sleep_millisecs);
> +	SAFE_FILE_PRINTF(NULL, PATH_KHPD "scan_sleep_millisecs", "%d", 0);
> +
> +	SAFE_FILE_SCANF(NULL, PATH_KHPD "alloc_sleep_millisecs",
> +			"%d", &pre_thp_alloc_sleep_millisecs);
> +	SAFE_FILE_PRINTF(NULL, PATH_KHPD "alloc_sleep_millisecs", "%d", 0);

No need to convert the constant integer via "%d", just pass the "0"
string.

> +	SAFE_FILE_SCANF(NULL, PATH_THP "enabled", "%[^\n]", pre_thp_enabled);
> +	SAFE_FILE_PRINTF(NULL, PATH_THP "enabled", "%s", "always");

No need to pass the "always" via "%s", just pass it directly.

> +
> +	tst_sig(FORK, DEF_HANDLER, NULL);
> +	TEST_PAUSE;
> +}



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
