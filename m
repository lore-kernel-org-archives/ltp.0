From: Martin Doucha <mdoucha@suse.cz>
Date: Tue, 17 Sep 2019 14:16:26 +0200
Subject: [LTP] [PATCH v2 0/2] Increase fsync() coverage - GH#452
Message-ID: <20190917121627.6294-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Apologies for resubmitting patch #2 so quickly. V2 uses SAFE_CLOSE() inside
test cases to ensure that reused file descriptors will not interfere
with other test runs. It also fixes signed/unsigned comparison compiler
warning in cleanup().

Martin Doucha (2):
  Update syscalls/fsync03 to new API
  Improve coverage in syscalls/fsync03

 testcases/kernel/syscalls/fsync/fsync03.c | 189 +++++++++-------------
 1 file changed, 76 insertions(+), 113 deletions(-)

-- 
2.22.1

