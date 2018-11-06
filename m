From: Hongzhi.Song <hongzhi.song@windriver.com>
Date: Tue, 6 Nov 2018 02:09:52 -0500
Subject: [LTP] [PATCH V2] setrlimit05: Use another method to get bad address
Message-ID: <1541488193-67790-1-git-send-email-hongzhi.song@windriver.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

V2:
    put tst_get_bad_add() to setup();

Hongzhi.Song (1):
  kernel/syscall/setrlimit05.c: use a legal bad address for mips

 testcases/kernel/syscalls/setrlimit/setrlimit05.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

-- 
2.8.1

