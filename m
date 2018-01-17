From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 17 Jan 2018 03:54:18 -0500 (EST)
Subject: [LTP] [PATCH] safe_mount: Do not try mount() syscall for FUSE fs
In-Reply-To: <20180116092318.20521-1-chrubis@suse.cz>
References: <20180116092318.20521-1-chrubis@suse.cz>
Message-ID: <1990718613.918376.1516179258863.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> The problem here is that there exists two NTFS implementations. There is
> a readonly support in the kernel and full read/write FUSE
> implementation. If there is a NTFS kernel module present on the system
> the mount() syscall successfuly mounts the device in read-only mode
> which causes the tests to fail once they attempt to create a file.
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>

This would prevent test using read-only kernel version of NTFS,
but no such test exists (and EROFS tests use tmpfs).

ACK

Regards,
Jan
