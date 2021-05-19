From: Li Wang <liwang@redhat.com>
Date: Wed, 19 May 2021 16:52:57 +0800
Subject: [LTP] [PATCH 2/2] tst_test: using SIGTERM to terminate process
In-Reply-To: <d70f9e5f-0008-02aa-e099-2a8243c4b3fa@jv-coder.de>
References: <20210518122610.17171-1-liwang@redhat.com>
 <20210518122610.17171-2-liwang@redhat.com>
 <d70f9e5f-0008-02aa-e099-2a8243c4b3fa@jv-coder.de>
Message-ID: <CAEemH2cjXaSLv9pwr9wqEnj9w+e-Y3mALG0dBovx-yN6KjwreA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Joerg,

> This works fine.
> +Reviewed-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
> after my remarks are resolved.

Thanks for the above comments, I will fix them all in patch V2.

> But one more strange thing here.
> I wonder why this even works. $pid is used in _tst_kill_test and defined
> in _tst_setup_timer as a local variable.
> It looks like it is inherited through the call chain and since it is
> copied to the background process, it cannot be manipulated by the tests.
> Still I would vote for changing this at some point, because it is highly
> confusing.

+1

Agree, I look at it a while and seems a local variable can only be
visible in the sub-function/call-chain of SHELL.

But I vote to fix the problem in a separate patch, it'd be appreciated
if you help make the patch.

-- 
Regards,
Li Wang

