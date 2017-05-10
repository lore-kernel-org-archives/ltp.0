From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 10 May 2017 04:56:38 -0400 (EDT)
Subject: [LTP] [RFC] [PATCH] move_pages12: Allocate and free hugepages
 prior	the test
In-Reply-To: <20170509140458.26343-1-chrubis@suse.cz>
References: <20170509140458.26343-1-chrubis@suse.cz>
Message-ID: <510505896.9544779.1494406598104.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> This commit adds code into the test setup to mmap(), mbind() and fault
> hugepages on both testing nodes prior to the test run in order to make sure
> that there is enough continous space for the move_pages() syscall to move
> huge
> pages back and forth.

I'm still getting sporadic failures with 4.11 kernel. It's freshly
booted system, so I would expect fragmentation to be low:

# numactl -H; ./move_pages12 
available: 2 nodes (0-1)
node 0 cpus: 0 2 4 6 8 10 12 14 16 18 20 22
node 0 size: 31963 MB
node 0 free: 31600 MB
node 1 cpus: 1 3 5 7 9 11 13 15 17 19 21 23
node 1 size: 32251 MB
node 1 free: 31915 MB
node distances:
node   0   1 
  0:  10  20 
  1:  20  10

tst_test.c:847: INFO: Timeout per run is 0h 05m 00s
move_pages12.c:184: INFO: Free RAM 65040204 kB
move_pages12.c:139: INFO: Allocating and freeing 2 hugepages on node 0
move_pages12.c:139: INFO: Allocating and freeing 2 hugepages on node 1
nodes: 0 1
move_pages12.c:87: FAIL: move_pages failed: ENOMEM

Summary:
passed   0
failed   1
skipped  0
warnings 0

Regards,
Jan
