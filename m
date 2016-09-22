From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 22 Sep 2016 17:47:20 +0200
Subject: [LTP] [PATCH 2/2] syscalls/access05: reconstruct and convert to
 new API
In-Reply-To: <1469698729-5860-2-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <1469698729-5860-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
 <1469698729-5860-2-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <20160922154719.GA11476@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with minor changes, thanks.

* There is no need to disable the test on uClinux once the EFAULT
  testcases were removed

* Got rid of the confusing INV_OK constant and used -1 directly

-- 
Cyril Hrubis
chrubis@suse.cz
