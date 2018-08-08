From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 8 Aug 2018 03:27:49 -0400 (EDT)
Subject: [LTP] [PATCH] lib: Fix result propagation after exec()
	+	tst_reinit()
In-Reply-To: <20180807142549.13877-1-chrubis@suse.cz>
References: <20180807142549.13877-1-chrubis@suse.cz>
Message-ID: <1353623142.39451274.1533713269397.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> The result pointer wasn't initialized in tst_reinit(), which haven't
> allowed for test result propagation to the main test process and there
> is actually no reason not to do that. So this commit initializes the
> results pointer in tst_reinit() and also adds a child_needs_reinit flag
> to tst_test structure, which causes the library not to unlink the IPC
> file after it has been mapped and also inserts LTP_IPC_PATH to the
> environment.
> 
> This commit also adds a test that also shows the usage of the API and
> documentation.
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> CC: Eddie Horng <eddiehorng.tw@gmail.com>

ack
