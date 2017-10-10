From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 10 Oct 2017 11:06:56 -0400 (EDT)
Subject: [LTP] [PATCH/RFC] lib: add LTP_IPC_PATH to env. variables by
 default
In-Reply-To: <20171010131059.GE4970@rei.lan>
References: <928440776c092e8a6da22c42b83606a142d90887.1507638841.git.jstancek@redhat.com>
 <20171010131059.GE4970@rei.lan>
Message-ID: <43494702.28232749.1507648016506.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi!
> Can you also remove the explicit passing of tst_ipc_envp in the
> creat07.c? Then we may as well get rid of the tst_ipc_envp[] array
> completely.

Sent as new series except for 2 patches you already ACK-ed:
  5deaf719987f security/dirtyc0w: synchronize parent and child
  13b2549855af lib: allow checkpoints to be used by any uid

Regards,
Jan
