From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 2 Jun 2016 03:58:25 -0400 (EDT)
Subject: [LTP] [RFC] shell wrappers for tst_checkpoint
In-Reply-To: <1464791693-10249-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1464791693-10249-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <904217705.1759877.1464854305705.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Stanislav Kholmanskikh" <stanislav.kholmanskikh@oracle.com>
> To: ltp@lists.linux.it
> Cc: "vasily isaenko" <vasily.isaenko@oracle.com>
> Sent: Wednesday, 1 June, 2016 4:34:51 PM
> Subject: [LTP] [RFC] shell wrappers for tst_checkpoint
> 
> Hi!
> 
> There is a need to use the tst_checkpoint interface from shell, but
> we don't have wrappers for it (yet).
> 
> Patch 1 of the series contains one possible implementation for that,
> patch 2 - an example of usage in the context of the memcg_functional test
> case.
> 
> I'd like to get some feedback from LTP users.

If we don't plan to support oldlib, we should document that shell
checkpoints will work only with newlib C testcases, since oldlib
currently doesn't use LTP_IPC_PATH and file has different layout
(there is no results struct).

> 
> My primary concern is about two issues:
> 
> 1. The new test API for C is cool and takes the responsibility on
>    maintaining the infrastructure for tst_checkpoint. However, I couldn't
>    find
>    a way to implement something similar in shell, so I switched back to using
>    two separate functions for that - TST_CHECKPOINT_SETUP,
>    TST_CHECKPOINT_CLEANUP.
> 
>    There may be a better way...
> 
> 2. What is the best location for the new supplemental binaries
> (tst_checkpoint_wait,
> tst_checkpoint_wake)? tools/apicmds/ltpapicmd.c or separate source files in
> testcases/lib/ (similar to tst_sleep)?
> 
> Thanks.
> 
> 
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
> 
