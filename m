From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 30 Mar 2017 09:34:08 -0400 (EDT)
Subject: [LTP] [PATCH v2] syscalls/memfd_create: Fix build failure
	when	HAVE_FALLOCATE not defined
In-Reply-To: <1490870937-1160-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <58DCD4B1.5060705@cn.fujitsu.com>
 <1490870937-1160-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <1207400808.17400953.1490880848704.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
> ---
>  include/lapi/fallocate.h                                     | 11
>  +++++++++--
>  testcases/kernel/syscalls/memfd_create/memfd_create_common.c |  4 ++--
>  2 files changed, 11 insertions(+), 4 deletions(-)

ACK, it builds now OK for me.

Regards,
Jan
