From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 23 Jan 2018 03:31:02 -0500 (EST)
Subject: [LTP] [RFC] [PATCH] lib/tst_test: Use CLOCK_MONOTONIC for -I
 option.
In-Reply-To: <20180122141931.12464-1-chrubis@suse.cz>
References: <20180122141931.12464-1-chrubis@suse.cz>
Message-ID: <2120958980.3059541.1516696262620.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> CLOCK_MONOTONIC has been added to linux in the 2.5 development branch so
> this syscall is available in all 2.6 kernels hence it's reasonable to be
> used it in the test library at this point it has been 15 years after
> all.

LGTM.
Compile tested on rhel59 rhel62 rhel69 rhel7 rhel6i386.

Regards,
Jan
