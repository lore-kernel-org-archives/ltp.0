From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 7 Sep 2017 05:13:00 -0400 (EDT)
Subject: [LTP] [RFC] [PATCH 15/15] fs/fs_fill: Add a test to fill a FS
 in a	few threads
In-Reply-To: <20170905160918.6477-15-chrubis@suse.cz>
References: <20170905160918.6477-1-chrubis@suse.cz>
 <20170905160918.6477-15-chrubis@suse.cz>
Message-ID: <1046515100.10136321.1504775580893.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Runs CPU+2 threads that write into FS until they got ENOSPC, then delete
> a file and continue.
> 
> Older exfat fails with EIO instead of ENOSPC, it has been fixed in:

This test is producing a lot of output, most of it is TINFO from tst_fs_fill().
For example on 2 CPU KVM guest running RHEL6 I get ~200 kB of output.

# du -h log.txt
208K    log.txt

I was going to suggest tst_atomic_load() instead of volatile, but that
patch-set is not applied yet.

Regards,
Jan
