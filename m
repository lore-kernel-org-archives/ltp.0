From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 9 Oct 2018 16:26:16 +0200
Subject: [LTP] [PATCH] syscalls/fsetxattr02.c: Fix missing ramdisk
	module error
In-Reply-To: <b9d064ce-6ff2-16ba-013b-b9c0b14f6d84@linaro.org>
References: <CABdQkv-px744Mc-RVH=Tpa+TPqhs3tYn-D8=JgzBdjmwMtpDVA@mail.gmail.com>
 <20181008154620.25237-1-rafael.tinoco@linaro.org>
 <20181009141725.GD16630@rei>
 <b9d064ce-6ff2-16ba-013b-b9c0b14f6d84@linaro.org>
Message-ID: <20181009142616.GE16630@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > I find it a bit silly to define a macro for a string that is used
> > exactly once. Why can't we just write "brd", in the needed_drivers?
> 
> I got it from from an existing test Cyril. I confess I thought the same 
> =), was afraid of being an etiquette or something. Feel free to drop it, 
> no hard feelings!

There is still a lot of silly code in LTP, just send a patch if you see
some :-).

-- 
Cyril Hrubis
chrubis@suse.cz
