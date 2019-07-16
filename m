From: Hongzhi.Song <hongzhi.song@windriver.com>
Date: Tue, 16 Jul 2019 05:04:21 -0400
Subject: [LTP] [PATCH V5] getrlimit03: adjust a bit of code to compatiable
 with mips32
Message-ID: <1563267862-42483-1-git-send-email-hongzhi.song@windriver.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

V5:
	replace __mips macro with __mips__
V4:
	Use ABI32 macro to filter mips32
V3:
	The V2 break other arch. fix it.
V2: 
	modify commit log

Hongzhi.Song (1):
  getrlimit03: adjust a bit of code to compatiable with mips32

 testcases/kernel/syscalls/getrlimit/getrlimit03.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

-- 
2.8.1

