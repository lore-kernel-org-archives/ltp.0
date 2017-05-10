From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 10 May 2017 15:49:30 +0200
Subject: [LTP] [RFC] [PATCH] move_pages12: Allocate and free hugepages
 prior	the test
In-Reply-To: <510505896.9544779.1494406598104.JavaMail.zimbra@redhat.com>
References: <20170509140458.26343-1-chrubis@suse.cz>
 <510505896.9544779.1494406598104.JavaMail.zimbra@redhat.com>
Message-ID: <20170510130125.GE29838@rei.suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've got a hint from our kernel devs that the problem may be that the
per-node hugepage pool limits are set too low and increasing these
seems to fix the issue for me. Apparently the /proc/sys/vm/nr_hugepages
is global limit while the per-node limits are in sysfs.

Try increasing:

/sys/devices/system/node/node*/hugepages/hugepages-2048kB/nr_hugepages

Also if I write 0 to the nr_hugepages there while the test is running
move_pages() fails with ENOMEM reproducibly.

I will prepare a patch that will increase these limits in the test setup
temporarily.

-- 
Cyril Hrubis
chrubis@suse.cz
