From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 9 Nov 2018 06:34:46 -0500 (EST)
Subject: [LTP] [PATCH v2] getrlimit/getrlimit03: new test for
	underlying	syscall variants
In-Reply-To: <20181107212213.129534-1-ghackmann@google.com>
References: <20181106194725.GA11344@rei.lan>
 <20181107212213.129534-1-ghackmann@google.com>
Message-ID: <644528592.71694894.1541763286038.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> Depending on the architecture, Linux provides up to three syscalls that
> have been used to implement getrlimit(2) in different libc
> implementations.  These syscalls differ in the size and signedness of
> rlim_t.
> 
> This test compares the results returned by all three syscalls, confirming
> that they either match or were appropriately capped at the respective
> RLIM_INFINITY constant.
> 
> Signed-off-by: Greg Hackmann <ghackmann@google.com>

Looks good to me, worked fine across number of old/new RHEL distros.

Regards,
Jan
