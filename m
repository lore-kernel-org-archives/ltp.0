From: Li Wang <liwang@redhat.com>
Date: Tue, 18 Jul 2017 16:22:57 +0800
Subject: [LTP] [PATCH v3 00/15] Convert LTP mem/testcase to new API
Message-ID: <20170718082312.3946-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

v2 --> v3

 * fix OOM timeout issue by new commit:
  	mem/oom: disable timeouts for testcase in demand

 * move common code to ksm_common.h:
  	mm/ksm: move the common code to ksm_common.h

 * take use of SAFE_MACRO in mem/thp testcases

-- 
2.9.3

