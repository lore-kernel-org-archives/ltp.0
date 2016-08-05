From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 5 Aug 2016 08:10:45 -0400 (EDT)
Subject: [LTP] [PATCH] syscalls/madvise06: Exclude other factor that
 leading to failure
In-Reply-To: <1470173002-19754-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1470173002-19754-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <768798867.1339125.1470399045351.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Xiao Yang" <yangx.jy@cn.fujitsu.com>
> To: ltp@lists.linux.it
> Cc: jstancek@redhat.com, "Xiao Yang" <yangx.jy@cn.fujitsu.com>
> Sent: Tuesday, 2 August, 2016 11:23:22 PM
> Subject: [PATCH] syscalls/madvise06: Exclude other factor that leading to failure
> 
> Make sure that madvise(MADV_WILLNEED) supports swap prefetch. We
> can't distinguish between kernel bug and unsupported swap, because
> the same error happens on RHEL6.8GA which madvise(MADV_WILLNEED)
> doesn't support swap prefetch. This feature has been pushed since
> kernel 3.10.0.
> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>

Pushed with small changes to commit message, I added
commit that introduced this feature for reference.

Regards,
Jan
