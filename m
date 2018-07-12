From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 12 Jul 2018 03:17:16 -0400 (EDT)
Subject: [LTP] [PATCH v3] syscalls/shmctl05: new test for IPC
	file	use-after-free bug
In-Reply-To: <20180711165547.175982-1-ebiggers3@gmail.com>
References: <20180711165547.175982-1-ebiggers3@gmail.com>
Message-ID: <303503399.32203839.1531379836792.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> From: Eric Biggers <ebiggers@google.com>
> 
> Test for a bug in the System V IPC subsystem that resulted in a shared
> memory file being used after it was freed (or being freed).
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

ack, I'll give Cyril chance to review as well.

Regards,
Jan
