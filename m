From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 5 Jun 2020 04:27:56 -0400 (EDT)
Subject: [LTP] LTP: syscalls: regression on mainline - ioctl_loop01
 mknod07 setns01
In-Reply-To: <CA+G9fYuGwcE3zyMFQPpfA0CyW=4WOg9V=kCfKhS7b8930jQofA@mail.gmail.com>
References: <CA+G9fYuGwcE3zyMFQPpfA0CyW=4WOg9V=kCfKhS7b8930jQofA@mail.gmail.com>
Message-ID: <203212099.14886500.1591345676708.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Following three test cases reported as regression on Linux mainline kernel
> on x86_64, arm64, arm and i386
> 
>   ltp-syscalls-tests:
>     * ioctl_loop01
>     * mknod07

Test updated:
  https://github.com/linux-test-project/ltp/commit/13fcfa2d6bdd1fb71c4528b47170e8e8fb3a8a32

>     * setns01

commit 303cc571d107 ("nsproxy: attach to namespaces via pidfds")
changed errno that is returned for regular file from EINVAL to EBADF.
This appears to fit more current man page, so I think we need to fix
test to accept both. (I'm looking into that)

