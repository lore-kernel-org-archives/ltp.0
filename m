From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 10 Oct 2017 15:10:59 +0200
Subject: [LTP] [PATCH/RFC] lib: add LTP_IPC_PATH to env. variables by
 default
In-Reply-To: <928440776c092e8a6da22c42b83606a142d90887.1507638841.git.jstancek@redhat.com>
References: <928440776c092e8a6da22c42b83606a142d90887.1507638841.git.jstancek@redhat.com>
Message-ID: <20171010131059.GE4970@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Can you also remove the explicit passing of tst_ipc_envp in the
creat07.c? Then we may as well get rid of the tst_ipc_envp[] array
completely.

-- 
Cyril Hrubis
chrubis@suse.cz
