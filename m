From: Vinay Kumar <vinay.m.engg@gmail.com>
Date: Mon, 14 Jun 2021 20:44:40 +0530
Subject: [LTP] [PATCH v3] getrusage02: Skipped EFAULT tests for libc
 variant.
In-Reply-To: <YMdpulBdM4FEtFm5@yuki>
References: <YMNqQE218QqnPiZY@yuki>
 <20210613171642.7773-1-vinay.m.engg@gmail.com>
 <YMdpulBdM4FEtFm5@yuki>
Message-ID: <CANUMPcWU-fXLJvLR=4+uv4RJFJQ7-WcozND72RD7aouotLQgng@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

Thanks for your review.
In your corrections for getrusage02.c need below change.

============================
diff --git a/testcases/kernel/syscalls/getrusage/getrusage02.c
b/testcases/kernel/syscalls/getrusage/getrusage02.c
index 24777687c..767663090 100644
--- a/testcases/kernel/syscalls/getrusage/getrusage02.c
+++ b/testcases/kernel/syscalls/getrusage/getrusage02.c
@@ -61,7 +61,7 @@ static void verify_getrusage(unsigned int i)
                return;
        }

-       TST_EXP_FAIL(getrusage(tc[i].who, tc[i].usage), tc[i].exp_errno,
+       TST_EXP_FAIL(tv->getrusage(tc[i].who, tc[i].usage), tc[i].exp_errno,
                     "getrusage(%i, %p)", tc[i].who, tc[i].usage);
 }
============================

Regards,
Vinay

On Mon, Jun 14, 2021 at 8:33 PM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> Slightly adjusted and pushed, thanks.
>
> --
> Cyril Hrubis
> chrubis@suse.cz
