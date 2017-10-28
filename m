From: Petr Vorel <pvorel@suse.cz>
Date: Sat, 28 Oct 2017 18:47:36 +0200
Subject: [LTP] [PATCH v5 08/12] hotplug/memory_hotplug: Exit with TCONF
 when NUMA headers not available
In-Reply-To: <20171026110440.GE7806@rei>
References: <20171018111106.17215-1-pvorel@suse.cz>
 <20171018111106.17215-9-pvorel@suse.cz> <20171026110440.GE7806@rei>
Message-ID: <20171028164720.utteq22aykmzhe4x@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> > --- a/testcases/kernel/hotplug/memory_hotplug/memtoy.c
<snip>

> I was trying to figure out how is this binary executed and it seems like
> it is not. There even seems to be some scripts for it. So in the long
> term we should investigate if it's worth keeping or not and maybe
> ressurect it.

> So all in all I do not see if there is a value in patching it if we do
> not run it at all and it produces strange failures on non-numa machine
> anyways...

How about deleting whole testcases/kernel/hotplug/memory_hotplug directory?
The only binary from that directory is memtoy, which is indeed not used in
any runtest file nor any script called by a runtest file.

It was taken from an upstream project from
http://devresources.linux-foundation.org/dev/hotplug/, which is now available
in https://github.com/kosaki/memtoy.

I can send patch with RFC tag to ML before, if you want.


Kind regards,
Petr
