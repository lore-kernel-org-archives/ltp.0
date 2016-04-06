From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 6 Apr 2016 11:56:15 +0200
Subject: [LTP] [PATCH V4] madvice: new case for madvise(WILLNEED)
In-Reply-To: <1459839897-12848-1-git-send-email-liwang@redhat.com>
References: <1459839897-12848-1-git-send-email-liwang@redhat.com>
Message-ID: <20160406095615.GA19271@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	tst_resm(TINFO, "PageFault(no madvice): %d", get_page_fault_num());
> +
> +	pg_sz = getpagesize();

I've moved this getpagesize() to setup() since we don't have to call it
each test iteration and pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
