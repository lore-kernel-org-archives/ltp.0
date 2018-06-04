From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 4 Jun 2018 14:32:01 +0200
Subject: [LTP] LTP CVE "cve-2011-2183" failed on x86_64,
 arm32 beaglebone x15
In-Reply-To: <20180604120733.GC3362@rei>
References: <CA+G9fYuUAPvwBjXjw_EATrMoLPtS5imGo7foqchmAFD=TUdVXQ@mail.gmail.com>
 <20180604120733.GC3362@rei>
Message-ID: <20180604123201.GD3362@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> That is an obvious bug in the test, the value of run should be restored
> only if we managed to change it.

I've pushed a slightly different patch that fixes the issue:

https://github.com/linux-test-project/ltp/commit/ffc8005a002ecc6f0d70675f7dee79cd481acffc

Thanks for the report.

-- 
Cyril Hrubis
chrubis@suse.cz
