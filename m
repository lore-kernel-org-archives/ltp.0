From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 3 Oct 2017 13:43:49 +0200
Subject: [LTP] [PATCH 1/1] syscalls, lib: Use SAFE_{BIND, LISTEN,
 SOCKET} macros
In-Reply-To: <20171002153616.k6fkz7fpzh2shzdc@dell5510>
References: <20170929231036.32262-1-pvorel@suse.cz>
 <87bmlpx195.fsf@our.domain.is.not.set>
 <20171002122920.rpurivi6x46duh4c@dell5510>
 <878tgtwqk7.fsf@our.domain.is.not.set>
 <20171002150417.jodtfynklflxe5pl@dell5510>
 <20171002152109.GA3736@rei>
 <20171002153616.k6fkz7fpzh2shzdc@dell5510>
Message-ID: <20171003114349.GA19124@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Shouldn't that be when != e & TFAIL? As far as I can tell the x is not
> > used in the matching part, or did I miss something?
> Sure, you're right, Cyril. Now I got your question Richard.
> I'm surprised that it work with x (result is the same).

I guess that this condition simply was always true, and it does not work
either way.

Anyway I got an idea yesterday and implemented a shell script that
generates a spatch based on function name and made it iterate over all
safe macros we have implemented making a git commit for each. The script
is attached for a reference.

I will look at the patches and do some minor adjustements now, there are
a few cases where the formatting ended up a bit confusing.

And I would consider these to be obvious enough to be commited without
review, but I can send them to ML if anyone wants to double check the
results.

-- 
Cyril Hrubis
chrubis@suse.cz
-------------- next part --------------
A non-text attachment was scrubbed...
Name: patch_safe_macros.sh
Type: application/x-sh
Size: 2280 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20171003/23122597/attachment.sh>
