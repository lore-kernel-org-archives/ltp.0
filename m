From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 9 May 2017 08:39:05 -0400 (EDT)
Subject: [LTP] [PATCH] move_pages12: fix Warning on system which not
 support	hugepage
In-Reply-To: <20170508054247.994-1-liwang@redhat.com>
References: <20170508054247.994-1-liwang@redhat.com>
Message-ID: <1687696917.9134394.1494333545245.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it







----- Original Message -----
> WARNING:
>  tst_test.c:847: INFO: Timeout per run is 0h 05m 00s
>  move_pages_support.c:407: CONF: at least 2 allowed NUMA nodes are required
>  safe_file_ops.c:301: WARN: Failed to close FILE '/proc/sys/vm/nr_hugepages'
>  at move_pages12.c:159: EOPNOTSUPP
> 
> Signed-off-by: Li Wang <liwang@redhat.com>
> ---

Pushed.

Thanks,
Jan
