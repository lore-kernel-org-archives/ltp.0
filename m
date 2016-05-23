From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 23 May 2016 16:36:11 +0200
Subject: [LTP] [PATCH] mem/oom: fork may fail before test
In-Reply-To: <9e8fc1797bd3bf0fe725a4b589e4fabda09ea0b8.1463669846.git.jstancek@redhat.com>
References: <9e8fc1797bd3bf0fe725a4b589e4fabda09ea0b8.1463669846.git.jstancek@redhat.com>
Message-ID: <20160523143611.GD25488@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> On systems with small RAM and vm.overcommit_memory == 2,
> the system may already be in state where Committed_AS is
> larger than CommitLimit due to various backround daemons
> (NM, tuned, polkitd,...) asking for big allocations.
> 
> In such instances oom testcases report TBROK on very first fork.
> This patch allows this to be a valid outcome (TPASS).

Looks good to me, acked.

-- 
Cyril Hrubis
chrubis@suse.cz
