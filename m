From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 17 Aug 2016 16:46:05 +0200
Subject: [LTP] Removal of ipc_stress testcases
Message-ID: <20160817144604.GA11954@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
As recently discussed here the testcases/kernel/ipc/ipc_stress/ were not
meant to be executed as a single testcases (as it's done in the ipc
runtest file) but were designed to be executed from a single stress
script. These testcases depends on each other and fail if the order of
tests is randomized. They do not cleanup the System V resources at the
end of the test, etc.

The code quality of these is quite low and the System V IPC is covered
by the testcases in syscalls.

So I would like to get rid of these. Does anybody opposes the removal?

-- 
Cyril Hrubis
chrubis@suse.cz
