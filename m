From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 13 Nov 2020 16:26:54 +0100
Subject: [LTP] [PATCH v3 1/4] syscalls/msgstress: Add common file for
 msgstress
In-Reply-To: <5FAE244C.3030806@cn.fujitsu.com>
References: <20200722154558.GB2714@yuki.lan>
 <1603285074-28392-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20201111154437.GA23576@yuki.lan> <5FAE244C.3030806@cn.fujitsu.com>
Message-ID: <20201113152654.GB16827@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Well if we add msg to the function names there would be no harm in
> > putting these functions into the ipc library, right? E.g. we would have
> > msg_do_reader() etc.
> 
> Yes. it is no harm. But I don't see any other case using these api.

Well it makes it easier to maintain the build system since we do not end
up with hacks in random Makefiles.

> Also this patch looks has wrongly merged into ltp master.

Sorry I must have pushed that by accident yesterday, I've reverted it
now.

-- 
Cyril Hrubis
chrubis@suse.cz
