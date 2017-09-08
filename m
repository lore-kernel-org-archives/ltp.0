From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 8 Sep 2017 03:21:29 -0400 (EDT)
Subject: [LTP] [PATCH] [RFC] lib/tst_test: Report 0 if test has both
 TPASS	and TCONF
In-Reply-To: <20170907155745.9116-1-chrubis@suse.cz>
References: <20170907155745.9116-1-chrubis@suse.cz>
Message-ID: <1529683625.10671733.1504855289141.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> It's probably a bit more logical to report a succes if only part of the
> test was skipped and the rest was sucessful. That way we can distinguish
> tests that were compiled-out completely or where the kernel does not
> support the particular syscall at all. The difference is about 15
> testcases that report TPASS instead of TCONF after this change.

Looks good to me. I've noticed more TCONFs too with your all_filesystems patch,
where some filesystems didn't support all features.

Regards,
Jan
