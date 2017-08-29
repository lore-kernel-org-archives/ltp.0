From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 29 Aug 2017 17:50:49 +0200
Subject: [LTP] [PATCH 2/2] syscalls/mbind: cleanup and rewrite mbind01
 into new API
In-Reply-To: <d5f2d568-8e0b-3c6e-ea78-dfc77594ba36@redhat.com>
References: <20170829064309.14383-1-pvorel@suse.cz>
 <20170829064309.14383-2-pvorel@suse.cz>
 <d5f2d568-8e0b-3c6e-ea78-dfc77594ba36@redhat.com>
Message-ID: <20170829155048.smmokzivxwkawxws@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jan,

thank you for your comments. I fixed everything for 2/2 in v2.

> Patch 1/2: I would probably go with cast of max_node to int, to keep
> printf format specifiers and function arguments matching, but your
> version should work too.
I didn't get that - there is only for cycle in numa_helper.c. So I kept changing the type
instead of casting.


Kind regards,
Petr
