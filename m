From: kai.kang@windriver.com <kai.kang@windriver.com>
Date: Wed, 16 Sep 2015 18:13:12 +0800
Subject: [LTP] [PATCH] V2: replace inline with static inline for gcc 5.x
Message-ID: <1442398393-12186-1-git-send-email-kai.kang@windriver.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Kai Kang <kai.kang@windriver.com>

V2:
* replace 'inline' with 'static inline' both for declare and definition

Kai Kang (1):
  replace inline with static inline for gcc 5.x

 testcases/kernel/controllers/libcontrollers/libcontrollers.c | 2 +-
 testcases/kernel/controllers/libcontrollers/libcontrollers.h | 2 +-
 testcases/kernel/syscalls/kill/kill10.c                      | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.4.1

