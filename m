From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 5 Sep 2016 07:30:40 -0400 (EDT)
Subject: [LTP] [PATCH] utimensat: fix immutable file retcodes for 4.8.0
 and newer.
In-Reply-To: <1472720773-9914-1-git-send-email-asavkov@redhat.com>
References: <1472720773-9914-1-git-send-email-asavkov@redhat.com>
Message-ID: <1053337099.1794428.1473075040524.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Artem Savkov" <asavkov@redhat.com>
> To: ltp@lists.linux.it
> Cc: chrubis@suse.cz, jstancek@redhat.com, "Artem Savkov" <asavkov@redhat.com>
> Sent: Thursday, 1 September, 2016 11:06:13 AM
> Subject: [PATCH] utimensat: fix immutable file retcodes for 4.8.0 and newer.
> 
> Kernel 4.8.0 contains patch "337684a fs: return EPERM on immutable inode"
> that
> makes operations on immutable files return EPERM instead of EACCESS.
> 
> Adjust utimensat test to check new retcode for kernels 4.8.0 and newer.
> 
> Signed-off-by: Artem Savkov <asavkov@redhat.com>
> ---

Looks good. 4.8 hasn't been released yet, so this patch is only in
-rc builds so far. We don't try to mirror -rc changes as closely
since things are sometimes unstable/get reverted/etc. So as fyi,
we'll probably push this only after 4.8 gets released.

Regards,
Jan
