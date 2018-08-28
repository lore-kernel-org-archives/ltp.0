From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 28 Aug 2018 07:38:38 -0400 (EDT)
Subject: [LTP] [PATCH v2] newlib_tests/test_exec.c: Fix compiler
	error	before glibc v2.11
In-Reply-To: <1535328355-16759-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20180824145656.GA5131@rei>
 <1535328355-16759-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1159033665.43135384.1535456318096.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> Before glibc v2.11, execvpe() was not introduced and resulted in
> compiler error, so we replace execvpe() with execve() and update
> test-writing-guidelines.txt.
> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>

This is older than oldest RHEL distro I still use to check LTP builds,
but it works fine on more recent ones, so ACK.

Regards,
Jan
