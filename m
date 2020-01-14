From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 14 Jan 2020 17:25:37 +0100
Subject: [LTP] [PATCH 3/3] syscalls/llseek02: convert to new library and
 add SEEK_SET test
In-Reply-To: <1576012458-31108-3-git-send-email-zhufy.jy@cn.fujitsu.com>
References: <1576012458-31108-1-git-send-email-zhufy.jy@cn.fujitsu.com>
 <1576012458-31108-3-git-send-email-zhufy.jy@cn.fujitsu.com>
Message-ID: <20200114162537.GB9508@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've rewritten the test so that it uses test structure, because the
functions for different seek tests were nearly the same. I've also fixed
a few problems, for instance there is no reason for the test to require
root and pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
