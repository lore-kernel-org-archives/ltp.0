From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 14 Feb 2017 08:49:20 -0500 (EST)
Subject: [LTP] [PATCH 4/4] syscalls: Make use of SAFE_MACROS in cleanup
In-Reply-To: <20170214122639.442-4-chrubis@suse.cz>
References: <20170214122639.442-1-chrubis@suse.cz>
 <20170214122639.442-4-chrubis@suse.cz>
Message-ID: <930240521.4328472.1487080160832.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: ltp@lists.linux.it
> Sent: Tuesday, 14 February, 2017 1:26:39 PM
> Subject: [LTP] [PATCH 4/4] syscalls: Make use of SAFE_MACROS in cleanup
> 
> Convert newlib tests to use SAFE_MACROS() in cleanup where possible.
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>

Looks good to me.

I also ran all syscalls tests on 4.9 (with RHEL7.4 userspace).
There were 2 known failures: utimensat01 and madvise07
