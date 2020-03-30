From: Jozef Pupava <jpupava@suse.com>
Date: Mon, 30 Mar 2020 12:12:20 +0200
Subject: [LTP] [PATCH v2 0/2] Update syscalls/fsync02 to new API
Message-ID: <20200330101222.25371-1-jpupava@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

v2:
Extended description of patch 2, decreased BLOCKSIZE value to keep
short test run and fixed f_bavail calculation on file systems which
support tail packing.


Jozef Pupava (2):
  Update syscalls/fsync02 to new API
  Fix calculations and defined constants

 testcases/kernel/syscalls/fsync/fsync02.c | 238 +++++++---------------
 1 file changed, 78 insertions(+), 160 deletions(-)

-- 
2.25.0

