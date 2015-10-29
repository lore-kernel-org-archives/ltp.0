From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 29 Oct 2015 12:57:46 +0100
Subject: [LTP] [PATCH 6/11] mmap/mmap12: Testcase failed when no root
 user run it
In-Reply-To: <1446001907-43525-6-git-send-email-cuibixuan@huawei.com>
References: <1446001907-43525-1-git-send-email-cuibixuan@huawei.com>
 <1446001907-43525-6-git-send-email-cuibixuan@huawei.com>
Message-ID: <20151029115746.GA23990@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Add tst_require_root() to testcase for open /proc/self/pagemap file.

On my machines the /proc/self/pagemap is readable by the process (it's
owned by the user that has started the program).

What is output of ls -l /proc/self/pagemap on your machine?

-- 
Cyril Hrubis
chrubis@suse.cz
