From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 27 Sep 2019 13:38:26 +0200
Subject: [LTP] [PATCH] syscalls/acct02: Check read size.
In-Reply-To: <20190925135634.GA32581@dell5510>
References: <20190925094721.18932-1-chrubis@suse.cz>
 <20190925135634.GA32581@dell5510>
Message-ID: <20190927113826.GC17233@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've just pushed this patch + one more special case for read_bytes == 0,
can you please give it a try and check that at least the test works
where it was working previously?

-- 
Cyril Hrubis
chrubis@suse.cz
