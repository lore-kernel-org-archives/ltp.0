From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 7 Jun 2018 10:45:22 +0200
Subject: [LTP] [PATCH] [RFC] syscalls/ipc: Rename some msgctl tests
In-Reply-To: <CAEemH2fxCoLB7S42xZKnT=4wFvTS-875AhvksFD3atYmjfPMWg@mail.gmail.com>
References: <20180606123735.15589-1-chrubis@suse.cz>
 <CAEemH2fxCoLB7S42xZKnT=4wFvTS-875AhvksFD3atYmjfPMWg@mail.gmail.com>
Message-ID: <20180607084522.GA2699@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Agreed. These tests fork too many times, and they often trigger OOM at
> runtime. So I think this patch make sense.
> ???
> Another thought of mine is that to remove them from the ltplite and
> syscalls runtest file. what about just putting them in stress.part3?

These shouldn't be part of ltplite for sure, I will remove them in a
follow up patch. I would like to keep them in the syscalls runtest file
though and make sure that they scale better accordingly to system
RAM/CPUs later on.

-- 
Cyril Hrubis
chrubis@suse.cz
