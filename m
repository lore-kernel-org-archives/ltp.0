From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 20 Aug 2020 22:33:35 +0200
Subject: [LTP] [PATCH v3 1/1] tst_kvcmp: Strip double quotes when
 parsing /etc/os-release
In-Reply-To: <CAMy_GT_0yg4CEW+a8TC-9rrYeNWW0Xa+UsMa70v495WBrUXeBA@mail.gmail.com>
References: <20200820133032.16840-1-pvorel@suse.cz>
 <20200820134557.GG9000@yuki.lan>
 <CAMy_GT_0yg4CEW+a8TC-9rrYeNWW0Xa+UsMa70v495WBrUXeBA@mail.gmail.com>
Message-ID: <20200820203335.GA7560@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Po-Hsu,

> LGTM,
> Tested with crafted ID, it can correctly parse the ID with or without
> the double quote.

> Another thing to note is that I found the loop in tst_kvercmp2 could
> iterate outside the size of "vers" and causing
> tst_test.c:1298: BROK: Test killed by SIGSEGV!
Will you post the patch for this?

> Reviewed-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
I'm sorry, I've merged it before, but forget to notify.
Is the bug mentioned above related to my commit?

Kind regards,
Petr
