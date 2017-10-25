From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 25 Oct 2017 11:23:44 +0200
Subject: [LTP] [PATCH v4] syscalls/keyctl07: new test for oops when
 reading negative key
In-Reply-To: <20171019172827.25716-1-ebiggers3@gmail.com>
References: <20171019172827.25716-1-ebiggers3@gmail.com>
Message-ID: <20171025092344.GE4244@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Add a test for a bug which caused the kernel to dereference a bogus
> pointer when using KEYCTL_READ to read from a negative key.

Thanks a lot for the updated version, pushed.

-- 
Cyril Hrubis
chrubis@suse.cz
