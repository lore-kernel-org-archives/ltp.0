From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 22 Sep 2017 04:47:30 -0400 (EDT)
Subject: [LTP] [PATCH] lib/tst_test: avoid cleanup by cloned test threads
In-Reply-To: <20170920202306.170298-1-smuckle.linux@gmail.com>
References: <20170920202306.170298-1-smuckle.linux@gmail.com>
Message-ID: <1761004181.19742274.1506070050664.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Some versions of glibc and bionic report the same PID for parent and
> child when clone() is called with CLONE_VM but not CLONE_THREAD. This
> can cause cleanup to be incorrectly run by the child.
> 
> Avoid this by using a direct syscall for getpid when running the
> cleanup.
> 

Pushed.

Thanks,
Jan
