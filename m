From: Hongzhi.Song <hongzhi.song@windriver.com>
Date: Fri, 12 Jul 2019 05:21:07 -0400
Subject: [LTP] [PATCH V3] getrlimit03: adjust a bit of code to compatiable
 with mips32
Message-ID: <1562923268-8132-1-git-send-email-hongzhi.song@windriver.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

V3:
	The V2 break other arch. fix it.

V2: 
	modify commit log

Hongzhi.Song (1):
  getrlimit03: adjust a bit of code to compatiable with mips32

 testcases/kernel/syscalls/getrlimit/getrlimit03.c | 9 +++++++++
 1 file changed, 9 insertions(+)

-- 
2.8.1

