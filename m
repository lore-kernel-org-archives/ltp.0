Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Y0tQA-0002EP-4G
	for ltp-list@lists.sourceforge.net; Tue, 16 Dec 2014 14:48:18 +0000
Date: Tue, 16 Dec 2014 15:47:55 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141216144754.GA4322@rei>
References: <1417612136-10890-1-git-send-email-liwang@redhat.com>
	<152932834.6076324.1417612296820.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <152932834.6076324.1417612296820.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH] /vm/hugepage/thp/thp05: cleanup should not use
 safe macros
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
To: Li Wang <liwang@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
Rebased and pushed with a few cosmetic changes (see below), thanks.

> +int file_scanf(const char *file, const int lineno,
> +		     const char *path, const char *fmt, ...)
> +{
> +	va_list va;
> +	FILE *f;
> +	int exp_convs, ret;
> +
> +	f = fopen(path, "r");
> +
> +	if (f == NULL) {
> +		tst_resm(TWARN,
> +			"Failed to close FILE '%s' at %s:%d",
                                   ^
				   open
> +			 path, file, lineno);
> +		return 1;
> +	}
> +

...

> +	if (fclose(f)) {
> +		tst_resm(TWARN,
> +			 "Failed to close FILE '%s' at %s:%d",
> +			 path, file, lineno);
> +		return 1;
> +	}
> +
> +	return 0;
> +
> +err:
> +	if (fclose(f)) {
> +		tst_resm(TWARN,
> +			 "Failed to close FILE '%s' at %s:%d",
> +			 path, file, lineno);
> +		return 1;
                 ^
		 This is not needed because of the return 1 right below.
> +	}
> +	return 1;
> +}

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=164703151&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
