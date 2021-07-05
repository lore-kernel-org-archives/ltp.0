From: Joerg Vehlow <lkml@jv-coder.de>
Date: Mon,  5 Jul 2021 15:50:13 +0200
Subject: [LTP] [PATCH 0/1] fs_bind: Convert to ltp tests
Message-ID: <20210705135014.679200-1-lkml@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi everyone,

I know this is a huge changeset, but there is not really a good way to         
break it down into multiple commits. Every step in between would either
lead to a broken test suite or a change, that is then changed again.
So I made this one huge commit, that converts all of the tests of the     
testsuite in one go.

I added some minor bugfixes especially added umounts, because some where
missing and some were redundant. I also dropped all useless output (bare ls).

I may have overused EXPECT_PASS a bit here, but I think it does not do any harm,
if all mounts are checked.

Joerg


