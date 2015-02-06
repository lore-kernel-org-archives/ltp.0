Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <liwang@redhat.com>) id 1YJd2c-0007zx-7J
	for ltp-list@lists.sourceforge.net; Fri, 06 Feb 2015 07:09:26 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YJd2a-0005bX-M9
	for ltp-list@lists.sourceforge.net; Fri, 06 Feb 2015 07:09:26 +0000
Message-ID: <1423206548.27888.29.camel@dhcp-13-206.nay.redhat.com>
From: Li Wang <liwang@redhat.com>
Date: Fri, 06 Feb 2015 15:09:08 +0800
In-Reply-To: <1423040387-2029-2-git-send-email-wangxg.fnst@cn.fujitsu.com>
References: <20150203095709.GB15330@rei.scz.novell.com>
	<1423040387-2029-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
	<1423040387-2029-2-git-send-email-wangxg.fnst@cn.fujitsu.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH v2 2/2] syscalls/mmap16: regression test for data
 corruption when blocksize < pagesize for mmaped data
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi,

I found there are two new LTP changes have been applied, which would be
probably impact to your case:
commit aabb8340f63ed31afe995fd97795e542dc68b93c
    Include usctest.h in test.h
commit 605fa3362fd7cef0baa2131be32cf44661783d3e
    Get rid of TEST_CLEANUP

Seems we should remove two lines of the testcase as below otherwise it 
can't be compile.

BTW, I tested it on patched kernel it can works well and Bug reproduced
with unpatched kernel.

Thanks,
Li Wang

On Wed, 2015-02-04 at 16:59 +0800, Xiaoguang Wang wrote:
> This data corruption fixed by:
...
> +
> +#include <stdio.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <sys/types.h>
> +#include <sys/wait.h>
> +#include <unistd.h>
> +#include <sys/mount.h>
> +#include <sys/mman.h>
> +
> +#include "usctest.h"    <=========== remove 
> +#include "test.h"
> +#include "safe_macros.h"
> +
> +#define MNTPOINT	"mntpoint"
> +#define FS_BLOCKSIZE	1024
...
> +
> +static void cleanup(void)
> +{
> +	TEST_CLEANUP;   <============ remove
> +
> +	if (chdir(".."))
> +		tst_resm(TWARN | TERRNO, "chdir('..') failed");
> +	if (mount_flag && tst_umount(MNTPOINT) < 0)
> +		tst_resm(TWARN | TERRNO, "umount device:%s failed", device);
> +	if (device)
> +		tst_release_device(NULL, device);
> +	tst_rmdir();
> +}


------------------------------------------------------------------------------
Dive into the World of Parallel Programming. The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
