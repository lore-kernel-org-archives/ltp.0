From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 4 Apr 2016 19:30:38 +0200
Subject: [LTP] [PATCH V3] madvice: new case for madvise(WILLNEED)
In-Reply-To: <1459488281-23882-1-git-send-email-liwang@redhat.com>
References: <1459488281-23882-1-git-send-email-liwang@redhat.com>
Message-ID: <20160404173038.GB16610@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +#ifdef __x86_64__

Last question, why do we limit the test to x86_64?

Since apart from hardcoded page size, there does not seem to be anything
x86_64 specific at all.

Otherwise the test looks fine.

-- 
Cyril Hrubis
chrubis@suse.cz
