From: Christian Brauner <christian.brauner@ubuntu.com>
Date: Wed, 17 Jun 2020 00:56:11 +0200
Subject: [LTP] [PATCH 1/2] nsproxy: restore EINVAL for non-namespace file
 descriptor
In-Reply-To: <https://lore.kernel.org/lkml/20200615213843.2ojgm3ob7kp3qq6a@wittgenstein>
References: <https://lore.kernel.org/lkml/20200615213843.2ojgm3ob7kp3qq6a@wittgenstein>
Message-ID: <20200616225612.4068799-1-christian.brauner@ubuntu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The LTP testsuite reported a regression where users would now see EBADF
returned instead of EINVAL when an fd was passed that referred to an open
file but the file was not a nsfd. Fix this by continuing to report EINVAL.

Reported-by: kernel test robot <rong.a.chen@intel.com>
Cc: Jan Stancek <jstancek@redhat.com>
Cc: Cyril Hrubis <chrubis@suse.cz>
Link: https://lore.kernel.org/lkml/20200615085836.GR12456@shao2-debian
Fixes: 303cc571d107 ("nsproxy: attach to namespaces via pidfds")
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
I plan on sending this to Linus once it has sat in for-next for a few
days.
---
 kernel/nsproxy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
index b03df67621d0..cd356630a311 100644
--- a/kernel/nsproxy.c
+++ b/kernel/nsproxy.c
@@ -531,7 +531,7 @@ SYSCALL_DEFINE2(setns, int, fd, int, flags)
 	} else if (!IS_ERR(pidfd_pid(file))) {
 		err = check_setns_flags(flags);
 	} else {
-		err = -EBADF;
+		err = -EINVAL;
 	}
 	if (err)
 		goto out;

base-commit: b3a9e3b9622ae10064826dccb4f7a52bd88c7407
-- 
2.27.0

