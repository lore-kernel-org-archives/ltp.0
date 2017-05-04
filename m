From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 4 May 2017 16:03:19 +0200
Subject: [LTP] [RFC PATCH v5 0/3] Simplify network setup
In-Reply-To: <fa243a13-7677-f8cd-15ca-de873af0d7da@oracle.com>
References: <20170503160751.1634-1-pvorel@suse.cz>
 <8a43347a-716f-7ce6-2758-e5eda838e265@oracle.com>
 <fa243a13-7677-f8cd-15ca-de873af0d7da@oracle.com>
Message-ID: <20170504140319.747xtmehwshjw3b6@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> Regarding IPV{4,6}_NETWORK calculation, I believe it would much
> simpler ifwe saved the same part of address from IPV{4,6}_HOST
> variables to_NETWORK variable and what is differ to the other
> variables.There is no need to any additional checks for these
> environment variables or I'm missing something?
You're right - calculating just network part and then get host part by substring operation
will be probably less error-prone. I planned to write some tests latter (sorry for not
including it now), but this is really better solution.

> Hmm, I didn't find how the patch is getting network prefix
> on the remote host, is it because of the assumption that they
> should be the same on both hosts?
Yes. So far we have just one IPV{4,6}_NETWORK variable for both, so I guess this makes us to use
the same network for both.

> It is fine for now as it's
> not so common for a test environment to have different ones,
> so the better approach in the future is to make a separate tool
> (installed on both hosts with LTP) and get prefixes from
> local and remote host similar to tst_get_hwaddrs() in test_net.sh.
I'm ok to make C binary which reads prefix, which will be run on both local and remote
hosts. But to be actually used, we'd need to change all tests using IPV{4,6}_NETWORK to
use different variables for local and remote hosts. I'd like to do it after having this
merged. I have also in my TODO list creating tst_net_reverse_ip binary for
stress/multicast and stress/route tests groups.

BTW is there a better/simpler way to get prefix than what I wrote?


Kind regards,
Petr
