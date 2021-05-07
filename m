From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 7 May 2021 14:40:41 +0200
Subject: [LTP] LTP Release
In-Reply-To: <CAEemH2dPMc+XoOXokm6K9w07QK2p-y8ZWOiwbQRAQGLmnhMkmg@mail.gmail.com>
References: <YJOYgZNL7/qp5YCN@yuki>
 <CAEemH2dPMc+XoOXokm6K9w07QK2p-y8ZWOiwbQRAQGLmnhMkmg@mail.gmail.com>
Message-ID: <YJU1SdcvcwRbbku7@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I vote to fix the brk02 FAIL as Liam suggests way (just removing
> 'PROT_WRITE|PROT_EXEC'), but I'm still a bit hesitant if that's wise
> for the test, or we can leave this problem for a long time to investigate.
> 
> https://lists.linux.it/pipermail/ltp/2021-May/022474.html

I would be fine with changing the test to mprotect() with just PROT_READ
and if we are going to do that we should do it ASAP since we are going
to start pre-release testing anytime soon.

-- 
Cyril Hrubis
chrubis@suse.cz
