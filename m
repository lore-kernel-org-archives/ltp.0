From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 3 Mar 2021 11:28:39 +0100
Subject: [LTP] Runtime test CI?
In-Reply-To: <20210303104833.3d36364e@kmaincent-XPS-13-7390>
References: <20210303104833.3d36364e@kmaincent-XPS-13-7390>
Message-ID: <YD9k15Clrdd/tqtq@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I have seen you are using Travis to build CI.
> Have you a runtime CI or a testbench to validate all the LTP tests on several
> distributions and architectures before the release?

Unfortunatelly we do not, it's on my long term TODO though.

I'm slowly getting all the required pieces together, it's mostly done at
this point and I'm using these tools to validate LTP releases.

If you want to experiment have a look at runltp-ng:

https://github.com/metan-ucw/runltp-ng

What I do before the release is to run similar scripts to the
compare_syscalls.sh to generate results in json for different LTP
runtest files on different VMs then diff them with res_diff.pl

What is missing there is a bit of scripts to automate all that so it
could be executed in a loop on a dedicated server and a better output
from res_diff.pl, maybe a html page that would be uploaded somewhere.

-- 
Cyril Hrubis
chrubis@suse.cz
