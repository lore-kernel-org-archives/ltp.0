From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu,  5 Apr 2018 16:01:46 +0200
Subject: [LTP] Make use of .needs_rofs
Message-ID: <20180405140154.6218-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This patchset firstly introduces minor changes to the test library which
are needed in order to convert more testcases to the newly introduced
.needs_rofs flag. Then converts about 1/3 of the existing EROFS tests
to use it.

The main motivation for this work is to speed up the syscalls run, since
we have many testcases that take a few seconds to run for no good
reason. The resulting speedup after this patchest is applied is about
half a minute for me and may be much greater on machines with slow I/O.

This also means that we can gain another minute by converting the rest
of the testcases.

Also this should fix these testcases on android as a side effect.

