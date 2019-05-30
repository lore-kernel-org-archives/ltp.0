From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 30 May 2019 06:31:21 -0400 (EDT)
Subject: [LTP] [PATCH 1/2] lib/tst_test: introduce
 tst_test->some_filesystems
In-Reply-To: <20190530102336.10898-1-xzhou@redhat.com>
References: <20190530102336.10898-1-xzhou@redhat.com>
Message-ID: <1564717500.25330071.1559212281463.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> Like all_filesystems, some_filesystems option let tcase to run on
> specific filesystems.
> In order to implement this, change run_tcases_per_fs to accept a
> parameter indicating which filesystems need to test.
> 
> To let tcase use this option, we need some other flags set
> Eg:
> static char *some_filesystems[] = {"ext4", "xfs", "btrfs"};

What happens if one of them is not supported/available?
Will it be skipped/TCONF?

