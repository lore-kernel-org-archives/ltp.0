From: Joerg Vehlow <lkml@jv-coder.de>
Date: Thu,  8 Jul 2021 07:57:53 +0200
Subject: [LTP] [PATCH v3 0/4] fs_bind: Convert to ltp tests
Message-ID: <20210708055757.945702-1-lkml@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

I split up the patch into 4 commits. The first one just renames
all tests to the new nameing schema, in order to make git detect
renames instead of delete/add.

Additonal in v2:
 - Fixed indentation (should be tabs in all new files now)
Changes in v3:
 - Fix portability issue in getopts usage

Joerg


