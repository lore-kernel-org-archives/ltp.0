From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 13 Aug 2021 15:49:02 +0200
Subject: [LTP] [PATCH 1/3] syscalls/creat08: Convert to new API
In-Reply-To: <20210806154557.19551-1-mdoucha@suse.cz>
References: <20210806154557.19551-1-mdoucha@suse.cz>
Message-ID: <YRZ4TmJWcL8zJgg6@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Btw, it looks that this is one of the test failing on tubmbleweed, it
looks like the "bin" group is no longer present on the system.

Can't we just pick two non-zero numbers for the groupids instead of
trying to resolve whatever groups are supposed to be on the system?

We may as well add an library API to request one or two group ids to the
test library so that they are hardcoded only in a single place.

See:
https://progress.opensuse.org/issues/96644
https://openqa.opensuse.org/tests/1872454

-- 
Cyril Hrubis
chrubis@suse.cz
