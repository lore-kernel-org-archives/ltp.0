From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 7 Jul 2021 16:50:56 +0200
Subject: [LTP] [PATCH 1/2 v2] fork07: Rewrite the test to a proper
 synchronization
In-Reply-To: <20210705075903.98692-2-xieziyao@huawei.com>
References: <20210705075903.98692-1-xieziyao@huawei.com>
 <20210705075903.98692-2-xieziyao@huawei.com>
Message-ID: <YOW/UPq3PWZ3uFDT@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with two minor changes, thanks.

* Added better description to the docparse comment

* Added SAFE_CLOSE() at the end of the run() otherwise the test
  will fail on large enough -i parameter (when it hits ulimit for open
  files)

-- 
Cyril Hrubis
chrubis@suse.cz
