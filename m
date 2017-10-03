From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 3 Oct 2017 16:28:29 +0200
Subject: [LTP] [PATCH 1/1] syscalls, lib: Use SAFE_{BIND, LISTEN,
 SOCKET} macros
In-Reply-To: <20171003123114.4iylsq2c35hh4pmh@dell5510>
References: <20170929231036.32262-1-pvorel@suse.cz>
 <87bmlpx195.fsf@our.domain.is.not.set>
 <20171002122920.rpurivi6x46duh4c@dell5510>
 <878tgtwqk7.fsf@our.domain.is.not.set>
 <20171002150417.jodtfynklflxe5pl@dell5510>
 <20171002152109.GA3736@rei>
 <20171002153616.k6fkz7fpzh2shzdc@dell5510>
 <20171003114349.GA19124@rei>
 <20171003123114.4iylsq2c35hh4pmh@dell5510>
Message-ID: <20171003142829.GC11692@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Anyway I got an idea yesterday and implemented a shell script that
> > generates a spatch based on function name and made it iterate over all
> > safe macros we have implemented making a git commit for each. The script
> > is attached for a reference.
> Really nice solution :-).
> This script is really worth of adding into LTP (even it requires to check formatting).

FYI: I've missed a pattern where the result is stored in a variable
     first hence things like SAFE_OPEN() haven't had chance to be used
     at all, I will fix that one and rerun the script.

-- 
Cyril Hrubis
chrubis@suse.cz
