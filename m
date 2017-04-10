From: Li Wang <liwang@redhat.com>
Date: Mon, 10 Apr 2017 18:05:42 +0800
Subject: [LTP] [PATCH V2 00/14] Convert LTP kernel/mem/testcase to New API
Message-ID: <20170410100556.4465-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

v1 --> v2

 * take use of safe macro of LTP in testcase

 * add new SAFE_READ_MEMINFO macro in 
    mem/lib: convert to new API

 * fix OOM timeout issue by new commit:
    mem/oom: fix the timeout issue


-- 
2.9.3

