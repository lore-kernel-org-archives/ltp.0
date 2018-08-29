From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 29 Aug 2018 08:19:29 -0400 (EDT)
Subject: [LTP] [PATCH 3/4] syscalls/mlock201: Add new testcase
In-Reply-To: <1534844339-8655-3-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1534844339-8655-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1534844339-8655-3-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <864746561.43466655.1535545169373.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> Check the basic functionality of mlock2(2) since kernel v2.6.9.
> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>

> + * Description:
> + * Check the basic functionality of the mlock2(2) since kernel v2.6.9:
> + * 1) Use mlock2(2) without MLOCK_ONFAULT to lock memory in the specified
> + *    range that is multiples of page size or not, and the VmLck from
> + *    /proc/PID/status shows correct size of memory that is locked by PID.
> + * 2) Use mlock2(2) with MLOCK_ONFAULT to lock memory in the specified
> + *    range that is multiples of page size or not, and the VmLck from
> + *    /proc/PID/status show correct size of memory that is locked by PID.

Can we also check if MLOCK_ONFAULT doesn't make non-present pages present,
but it still locks present pages? (mincore(2) or /proc/pid/pagemap)

Regards,
Jan
