From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 3 Jul 2019 16:30:37 +0200
Subject: [LTP] [PATCH v1 2/2] syscalls/lstat02: rewrote testcase
In-Reply-To: <20190611104747.14689-2-camann@suse.com>
References: <20190611104747.14689-1-camann@suse.com>
 <20190611104747.14689-2-camann@suse.com>
Message-ID: <20190703143037.GC17665@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with minor change, thanks.

I've removed everything but the chmod, which is the only call needed,
from cleanup.

-- 
Cyril Hrubis
chrubis@suse.cz
