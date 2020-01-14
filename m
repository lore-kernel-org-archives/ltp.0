From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 14 Jan 2020 07:53:16 -0500 (EST)
Subject: [LTP] [PATCH] syscalls/statx05: Fix failures on s390 & old libc
In-Reply-To: <20200114124900.22223-1-chrubis@suse.cz>
References: <20200114124900.22223-1-chrubis@suse.cz>
Message-ID: <1836578080.1900093.1579006396291.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> When encryption is not enabled in the kernel e4crypt fails with non-zero
> exit value. The value is then stored to long via the TEST() macro. The
> problem is that WEXITSTATUS() does not work with long on big endian s390
> on older libc[1][2]. And while this is not our bug, it also does not
> make sense to misuse the TEST() macro for catching return value from
> tst_test().
> 
> [1] https://sourceware.org/bugzilla/show_bug.cgi?id=19613
> [2]
> https://sourceware.org/git/gitweb.cgi?p=glibc.git;h=b49ab5f4503f36dcbf43f821f817da66b2931fe6
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>

LGTM.

Acked-by: Jan Stancek <jstancek@redhat.com>

