From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 18 Apr 2018 14:14:56 +0200
Subject: [LTP] [PATCH 3/5] syscalls/mkdir02: Cleanup && Convert to new
	API
In-Reply-To: <1521804892-5783-3-git-send-email-xuyang.jy@cn.fujitsu.com>
References: <1521804892-5783-1-git-send-email-xuyang.jy@cn.fujitsu.com>
 <1521804892-5783-3-git-send-email-xuyang.jy@cn.fujitsu.com>
Message-ID: <20180418121456.GB19992@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've further cleaned up the patch and pushed, thanks.

* Moved the setup part (the S_ISGID directory creation to the setup)

* Got rid of the useless result propagation as newlib propagates test
  results from child processes automatically

-- 
Cyril Hrubis
chrubis@suse.cz
