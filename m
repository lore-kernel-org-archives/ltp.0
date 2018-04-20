From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 20 Apr 2018 13:36:46 +0200
Subject: [LTP] [RFC PATCH v3 07/10] ima/ima_mmap: Reduce sleep + log it
In-Reply-To: <20180419195503.7194-8-pvorel@suse.cz>
References: <20180419195503.7194-1-pvorel@suse.cz>
 <20180419195503.7194-8-pvorel@suse.cz>
Message-ID: <20180420113646.GC19090@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Proper synchronization between the processes wouldn't harm here.

FIY: we do have checkpoints for the shell library that can be used both
     from C sources as well as shell.

But given how big this patchset is at this point, it can wait for v2 I
guess.

-- 
Cyril Hrubis
chrubis@suse.cz
