From: Jozef Pupava <jpupava@suse.cz>
Date: Tue, 24 Mar 2020 14:38:33 +0100
Subject: [LTP] [PATCH 0/2] Update syscalls/fsync02 to new API
Message-ID: <20200324143259.6943c413@daedruan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

this patchset is part of GH issue #452, update syscalls/fsync02 to
new API and avoid zero or negative int results in calculations.

Jozef Pupava (2):
  Update syscalls/fsync02 to new API
  Avoid zero or negative int results in calculations

 testcases/kernel/syscalls/fsync/fsync02.c | 234+++++++----------------
 1 file changed, 76 insertions(+), 158 deletions(-)

-- 
2.16.4
