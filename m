From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 5 May 2021 13:24:49 +0200
Subject: [LTP] [PATCH v3 4/6] Add rtnetlink helper library
In-Reply-To: <aa553d92-661d-d792-2d10-c654a4edbc35@suse.cz>
References: <20210505081845.7024-1-mdoucha@suse.cz>
 <20210505081845.7024-4-mdoucha@suse.cz> <YJJwr+RdyOvKhrxs@pevik>
 <aa553d92-661d-d792-2d10-c654a4edbc35@suse.cz>
Message-ID: <YJKAgdpuAsRVmSse@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> On 05. 05. 21 12:17, Petr Vorel wrote:
> > Hi Martin,

> > it'd be great if you (later) add docs from v1 cover letter [1] into
> > doc/test-writing-guidelines.txt.

> > [1] https://patchwork.ozlabs.org/project/ltp/cover/20210426111918.4304-1-mdoucha@suse.cz/

> I think we should discuss the documentation structure first.
> test-writing-guidelines.txt is already too long and unreadable.
Agree. I was thinking this week to at least split C and shell API, that would
help a bit.

> We should probably split it by topic and put the network management docs
> into a separate file from the outset since I'm planning to build an
> entire packetdrill-like userspace TCP stack on top of it in the future.
Thanks a lot!

Kind regards,
Petr
