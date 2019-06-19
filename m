From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 19 Jun 2019 03:19:03 -0400 (EDT)
Subject: [LTP] [PATCH] lib: add include config.h in cloner.c
In-Reply-To: <20190619071401.18509-1-liwang@redhat.com>
References: <20190619071401.18509-1-liwang@redhat.com>
Message-ID: <1510222953.29055172.1560928743851.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> This is a follow fix for commit f6164ffc2804b2a68218, otherwise clone08
> failed with ENOSYS error:
> 
>     clone08.c:81: INFO: running CLONE_PARENT
>     clone08.c:104: BROK: CLONE_PARENT clone() failed: ENOSYS
>     tst_test.c:357: BROK: Reported by child (2785)
> 
> That becuase CLONE_SUPPORTS_7_ARGS macro is included in config.h, without
> this header file, the ltp_clone7() will fall into ENOSYS branch.
> 
> Reported-by: Ping Fang <pifang@redhat.com>
> Signed-off-by: Li Wang <liwang@redhat.com>

Sorry about that, that include should have stayed in.
Pushed.
