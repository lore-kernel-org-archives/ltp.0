From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 7 Jul 2021 16:53:54 +0200
Subject: [LTP] [PATCH 2/2 v2] fork08: Rewrite the test to a proper
 synchronization
In-Reply-To: <20210705075903.98692-3-xieziyao@huawei.com>
References: <20210705075903.98692-1-xieziyao@huawei.com>
 <20210705075903.98692-3-xieziyao@huawei.com>
Message-ID: <YOXAAi5T/kmuzuoT@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Here as well, pushed with minor changes, thanks.

* Updated the coment to explicitly state that close() does not affect
  the fd in parent

* Added SAFE_CLOSE() to the second child as well

-- 
Cyril Hrubis
chrubis@suse.cz
