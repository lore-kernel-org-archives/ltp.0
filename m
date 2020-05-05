From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 5 May 2020 16:31:35 +0200
Subject: [LTP] [PATCH 1/2] Add test for CVE 2016-8655
In-Reply-To: <20200505131724.GA21884@dell5510>
References: <20200505102456.13004-1-mdoucha@suse.cz>
 <20200505131724.GA21884@dell5510>
Message-ID: <20200505143135.GC27810@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I wanted to propose after release dropping gcc 4 support by deleting CentOS 6
> from Travis (but maybe we should drop it even now). To keep the support, it'd be
> good to add lapi/if_packet.h with this definition.

That mainly depends on if someone wants to still carry on supporting it.

Does someone out there still need CentOS 6?

-- 
Cyril Hrubis
chrubis@suse.cz
