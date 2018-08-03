From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 3 Aug 2018 11:13:12 +0200
Subject: [LTP] [RFC] [PATCH] lib: Fix result propagation after exec() +
 tst_reinit()
In-Reply-To: <1077521162.37312079.1533126920056.JavaMail.zimbra@redhat.com>
References: <20180731130852.22739-1-chrubis@suse.cz>
 <1077521162.37312079.1533126920056.JavaMail.zimbra@redhat.com>
Message-ID: <20180803091312.GA32272@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > and also adds a needs_ipc_path flag to
> > tst_test structure, which causes the library not to unlink the IPC file
> > after it has been mapped and also inserts LTP_IPC_PATH to the
> > environment.
> 
> What is the negative of skipping unlink() for all tests?
> Test itself runs in separate process, so cleanup_ipc() should run
> anyway and clean it.

Well we use test ID as well as pid for the filename so it should be
unique enough, we also do O_EXCL on the file so I guess that it should
be safe enough not to unlink() it after it has been mapped.

There is one downside though, in a case that there is no tmpfs mounted
we fall back to mapping a file, in which case we will trigger writeback
to the storage by updating the piece of memory.

And given that there are actually very few testcases that needs to
access the test library from the children started by exec I would like
to keep unlinking the file unless needed.

> .needs_ipc_path - I'm worried users won't know what this is for.
> Maybe if it was called ".child_needs_reinit"? reinit appears
> to be the only reason we need to keep shm_path around.

That sounds definitely better.

-- 
Cyril Hrubis
chrubis@suse.cz
