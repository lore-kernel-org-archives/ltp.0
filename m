From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 23 Apr 2019 21:50:25 +0200
Subject: [LTP] [RFC PATCH v2] syscalls/sendmmsg: add new test
In-Reply-To: <20190419210637.88522-1-smuckle@google.com>
References: <20190419210637.88522-1-smuckle@google.com>
Message-ID: <20190423195024.GA28637@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Steve,

> Known issues/questions:
>  - This test occasionally gets stuck when the two messages get sent by
>    separate sendmmsg calls. The two sendmmsg calls complete successfully
>    but recvmmsg blocks indefinitely. I am not yet sure what would cause
>    this.

>  - I have not used tst_get_unused_port() because I'm unsure of how that
>    function should be made available for both the new and old test API?
>    I can just create a duplicate function but is there a cleaner way?
As I need tst_get_unused_port() as well, I've sent a patch to port it to new API
and available for both new and legacy API via TST_GET_UNUSED_PORT() macro [1].

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/patch/1089695/
