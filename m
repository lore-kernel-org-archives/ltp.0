From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 25 Feb 2019 16:26:40 +0100
Subject: [LTP] [PATCH v4 9/9] syscalls/sync_file_range: add sync device
 test-case
In-Reply-To: <1550739616-24054-10-git-send-email-sumit.garg@linaro.org>
References: <1550739616-24054-1-git-send-email-sumit.garg@linaro.org>
 <1550739616-24054-10-git-send-email-sumit.garg@linaro.org>
Message-ID: <20190225152640.GD6132@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
This tests fails for me for fuse based filesystems, the call returns 0
but does not write anything, the questions is if this is desired
behavior or not.

Also we should as well add a second test here that sync only a middle of
a written region of a file and expects that the data written are
somewhere between a few percents of the synced size.

-- 
Cyril Hrubis
chrubis@suse.cz
