From: Jiri Jaburek <jjaburek@redhat.com>
Date: Fri, 10 Jun 2016 16:04:35 +0200
Subject: [LTP] [PATCH] syscalls/fcntl34: use struct flock64 on 32bit
In-Reply-To: <1465562609-11947-1-git-send-email-jjaburek@redhat.com>
References: <1465562609-11947-1-git-send-email-jjaburek@redhat.com>
Message-ID: <575AC8F3.8090301@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On a second thought, the patched code isn't very nice on 64bit systems
(even though the sizes work out correctly). Also, the same codepath
is tested (on 32bit) via the _64 build, so it would perhaps make more
sense to disable the non-FILE_OFFSET_BITS=64 test on 32bit.

I'll send a new patch.

Thanks.
