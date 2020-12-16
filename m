From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 16 Dec 2020 11:10:07 +0100
Subject: [LTP] [PATCH 0/5] Small docparser fixes
Message-ID: <20201216101012.14644-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


Cyril Hrubis (5):
  docparse/docparse: Warn on truncated docstring
  doc_parse/data_storage: Bump the array max size
  docparse/docparse: Eat only first whitespace for comment block
  syscalls/abort: Remove second space before description text
  syscalls/move_pages12: Add one more kernel git hash

 docparse/data_storage.h                       |  2 +-
 docparse/docparse.c                           |  9 ++--
 testcases/kernel/syscalls/abort/abort01.c     |  3 +-
 .../kernel/syscalls/move_pages/move_pages12.c | 52 ++++++++++++-------
 4 files changed, 40 insertions(+), 26 deletions(-)

-- 
2.26.2

