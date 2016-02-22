From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 22 Feb 2016 12:18:26 +0100
Subject: [LTP] [PATCH] input: add kernel version check
In-Reply-To: <1455874725-31499-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1455874725-31499-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20160222111826.GA5704@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> In this test case, the functionality of input has been improved by
> following patch:
> 'commit 4369c64c79a2 ("Input: Send events one packet at a time")'.
> So it's not appropriate for testing on kernels that are lower than
> 3.7.0 anymore.

Are you sure that you have pointed out right commit? The commit
description does not seem relevant.

Also can you please describe why the testcases fail before 3.7.0 and
how? Does kernel send empty sync events?

-- 
Cyril Hrubis
chrubis@suse.cz
