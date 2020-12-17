From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 17 Dec 2020 15:44:21 +0100
Subject: [LTP] [PATCH v4 0/3] shell API setup/cleanup checks
Message-ID: <20201217144424.19414-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

previous version posted in
https://patchwork.ozlabs.org/project/ltp/list/?series=178107&state=*

But this version properly run cleanup function after test start
(IMHO most important part of the patchset).

Kind regards,
Petr

Petr Vorel (3):
  tst_test.sh: Call cleanup function after test start
  tst_test.sh: Warn on missing cleanup function
  tst_test.sh: Exit when setup declared but not defined

 doc/test-writing-guidelines.txt | 10 +++++++---
 testcases/lib/tst_test.sh       | 16 ++++++++++++----
 2 files changed, 19 insertions(+), 7 deletions(-)

-- 
2.29.2

