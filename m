From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 2 Aug 2018 06:53:44 -0400 (EDT)
Subject: [LTP] [PATCH] Move getcwd05 to realpath01 and fix for old distro
In-Reply-To: <20180801134717.29909-1-mmoese@suse.de>
References: <20180801134717.29909-1-mmoese@suse.de>
Message-ID: <1535534013.37569108.1533207223994.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> The testcase getcwd05 is a regression test for cve-2018-1000001 [1].
> However, there were changes in the behavior of libc functions, that some
> older
> distributions refused to backport.
> The testcase was two testcases, one for getcwd() and one for realpath().
> While the behavior of getcwd() changed, it is totally independent from
> the thestcase for the vulnerability in realpath. So, this test should be
> moved to realpath/realpath01.c. In addition, the test of getcwd() is
> totally unneeded here to test realpath() for the fix.
> 
> [1]
> https://sourceware.org/git/gitweb.cgi?p=glibc.git;a=commitdiff;h=52a713fdd0a30e1bd79818e2e3c4ab44ddca1a94
> 
> Signed-off-by: Michael Moese <mmoese@suse.de>

Looks good to me, ack.
Adding Petr, as he wrote the original test.

Regards,
Jan
