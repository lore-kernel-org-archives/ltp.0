From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 3 Feb 2016 13:43:14 +0100
Subject: [LTP] [PATCH v3] syscalls/fchmodat: fix test,
 don't use test current directory
In-Reply-To: <1454429469-4915-1-git-send-email-alexey.kodanev@oracle.com>
References: <1454429469-4915-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <20160203124313.GB30788@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> * use tmp directory for the test files,
> * remove hard-coded tmp directory path,
> * test fails with more than one iteration - cleanup after
>   each iteration,
> * make use of safe macros.

Acked.

-- 
Cyril Hrubis
chrubis@suse.cz
