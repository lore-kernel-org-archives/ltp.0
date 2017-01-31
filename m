From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 31 Jan 2017 13:41:29 +0100
Subject: [LTP] [PATCH 1/2] test_net.sh: add tst_set_sysctl()
In-Reply-To: <4017cf9c-3957-0a91-4fa3-8bafdad2f4c4@oracle.com>
References: <1485354100-24769-1-git-send-email-alexey.kodanev@oracle.com>
 <20170131100744.GD29227@rei.lan>
 <4017cf9c-3957-0a91-4fa3-8bafdad2f4c4@oracle.com>
Message-ID: <20170131124128.GF29227@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >> +# tst_set_sysctl NAME VALUE [safe]
> >> +# It can handle netns case when sysctl not namespaceified.
> >> +tst_set_sysctl()
> >> +{
> >> +	local name="$1"
> >> +	local value="$2"
> >> +	local safe=
> >> +	[ "$3" = "safe" ] && safe="-s" || safe=""
> > Uh, this syntax is confusing, besides isn't safe set to empty string
> > anyway?
> 
> What if we set TST_NO_CLEANUP just before calling cleanup()
> or unset TST_CLEANUP... then we can use ROD, etc. in cleanup?

You lost me here. How is this connected to the code I've commented?

-- 
Cyril Hrubis
chrubis@suse.cz
