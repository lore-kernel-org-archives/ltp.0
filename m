From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 21 Mar 2017 16:27:11 +0100
Subject: [LTP] [PATCH v4 5/6] syscalls: added memfd_create dir and
 memfd_create/memfd_create01.c
In-Reply-To: <1489595740-26159-6-git-send-email-jracek@redhat.com>
References: <1489595740-26159-1-git-send-email-jracek@redhat.com>
 <1489595740-26159-6-git-send-email-jracek@redhat.com>
Message-ID: <20170321152711.GC32105@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  .../syscalls/memfd_create/memfd_create_common.h    | 457 +++++++++++++++++++++

Just a short question before further review, do you intend to write more
testcases that will use this header?

Since as it is the memfd_create02 needs only the memfd_new function and
the ASSERT that memfd_create() is implemented in kernel and including
that header in memfd_create02.c yields a few "unused function" warnings.
There are a couple of ways how to fix that but the easies solution would
be moving these functions into the memfd_create01.c in a case that
these are not needed for further testcases.

-- 
Cyril Hrubis
chrubis@suse.cz
