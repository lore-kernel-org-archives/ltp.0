From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 18 Jul 2018 14:37:26 +0200
Subject: [LTP] [PATCH ltp] syscalls/ipc/msgstress/msgstress{01, 02, 03,
 04}: update TCID
In-Reply-To: <20180706090325.9923-1-yixin.zhang@intel.com>
References: <20180706090325.9923-1-yixin.zhang@intel.com>
Message-ID: <20180718123726.GC7117@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  /*
>   * Get and manipulate a message queue.
> - * Same as msgctl09 but gets the actual msgmni value under procfs.
> + * Same as msgctl09(msgstress02) but gets the actual msgmni value under procfs.

Why do we keep the old name here and put the new one in parenthesis?

Otherwise this is obviously correct and a good catch.

-- 
Cyril Hrubis
chrubis@suse.cz
