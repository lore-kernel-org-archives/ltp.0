From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 5 Apr 2018 11:52:14 +0200
Subject: [LTP] [PATCH 1/2] syscalls/preadv01: Run test for all
	filesystems
In-Reply-To: <1522400003-11319-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1522400003-11319-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20180405095214.GB31751@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Looking at the test running it for all filesystems would not make much
sense as it is since as far as I can tell:

1) setup() creates a file and writes data to it
   - dirty pagecache record is created

2) test() reads data from the file
   - kernel will copy the data from pagecache

3) test library cleanup will umount() the device
   - dirty pagecache is written at this point

So we will not reach any filesystem specific code at all.

I guess that we may fix that by opening second file descriptor with
O_DIRECT which would bypass pagecache so each read/write request would
trigger I/O request from the block device.

-- 
Cyril Hrubis
chrubis@suse.cz
