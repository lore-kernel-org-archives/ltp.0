From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 3 May 2021 16:15:49 +0200
Subject: [LTP] [PATCH 1/3 v2] syscalls/chown: Rewrite chown/chown02.c
 with the new api
In-Reply-To: <20210430094513.162499-2-xieziyao@huawei.com>
References: <20210430094513.162499-1-xieziyao@huawei.com>
 <20210430094513.162499-2-xieziyao@huawei.com>
Message-ID: <YJAFldREJ1aQBDdh@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with minor changes, thanks.

* I've updated the documentation comment a bit
* Moved the chmod() to the run() function so that the test
  changes back the modified permissions with -i parameter

-- 
Cyril Hrubis
chrubis@suse.cz
