From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 26 Jul 2017 16:55:28 +0200
Subject: [LTP] [RFC PATCH v7 07/11] lib/test_net.sh: Add function
 reset_ltp_netspace()
In-Reply-To: <46f0e647-8683-88b5-1ead-5287be4ae05d@oracle.com>
References: <20170721040407.868-1-pvorel@suse.cz>
 <20170721040407.868-8-pvorel@suse.cz>
 <46f0e647-8683-88b5-1ead-5287be4ae05d@oracle.com>
Message-ID: <20170726145528.neqjma47ebrhyjyh@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> >  	pid="$(echo $(readlink /var/run/netns/ltp_ns) | cut -f3 -d'/')"
> > -	export LTP_NETNS="${LTP_NETNS:-ns_exec $pid net,mnt}"
> > +	export LTP_NETNS="ns_exec $pid net,mnt"

> It is better to reset LTP_NETNS variable before calling
> init_ltp_netspace in reset_ltp_netspace().
OK, I'll do it :-). I wonder what is a real usage for LTP_NETNS configured by user...

Thanks for your review!

Kind regards,
Petr
