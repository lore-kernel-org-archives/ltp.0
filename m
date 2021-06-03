From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 3 Jun 2021 13:51:22 +0200
Subject: [LTP] [PATCH 1/2] syscalls/fchown: Convert fchown04 to the new
 API
In-Reply-To: <20210531112522.9082-2-xieziyao@huawei.com>
References: <20210531112522.9082-1-xieziyao@huawei.com>
 <20210531112522.9082-2-xieziyao@huawei.com>
Message-ID: <YLjCOvs1WNZiIB3G@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with two minor changes, thanks.

* Removed the SAFE_SETEUID(0) from cleanup since it's not needed

* Added if (fd > 0) to the cleanup, since technically the test can exit
  with TBROK even before these filedescriptors are open so we have to do
  this check

-- 
Cyril Hrubis
chrubis@suse.cz
