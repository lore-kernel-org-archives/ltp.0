From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 24 Jan 2017 14:45:45 +0100
Subject: [LTP] [PATCH v2 1/1] network/mc_cmds: fix testing with iproute2
 <= ss161212
In-Reply-To: <20170124120612.62cg2l5r53pwtflp@dell5510>
References: <20170118140056.15507-1-pvorel@suse.cz>
 <20170124102805.GE27769@rei.lan>
 <20170124120612.62cg2l5r53pwtflp@dell5510>
Message-ID: <20170124134544.GE29054@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > I wonder if we should write a regression test for the ip as well. I
> > guess that some basic ip testsuite under testcases/commands/ wouldn't
> > hurt either.
> 
> I agree for the need of ip regression tests. If you don't mind I'd like to write this one.

Go ahead :-)

-- 
Cyril Hrubis
chrubis@suse.cz
