From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 25 Sep 2017 15:59:15 +0200
Subject: [LTP] [PATCH] mm: mmapstress04: Remove arguments passed to the
 test.
In-Reply-To: <20170922225941.100991-1-sspatil@google.com>
References: <20170922225941.100991-1-sspatil@google.com>
Message-ID: <20170925135915.GA31931@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> The test doesn't take any arguments, so don't pass it any.

Good catch, we missed that on the test rewrite, pushed.

Side note: I guess that we should fix the test library not to ignore positional
           parameters since that would have caught it in the first place. But
	   that one will wait till we are done with the release.

-- 
Cyril Hrubis
chrubis@suse.cz
