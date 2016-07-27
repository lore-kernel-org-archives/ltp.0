From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 27 Jul 2016 18:03:08 +0200
Subject: [LTP] [PATCH V3 11/23] lapi: Use sig_t instead of sighandler_t
In-Reply-To: <46510D01-1510-4C0E-BD03-7B8896652B55@gmail.com>
References: <20160722042656.22346-1-raj.khem@gmail.com>
 <20160722042656.22346-11-raj.khem@gmail.com>
 <20160727102218.GC10903@rei.lan>
 <46510D01-1510-4C0E-BD03-7B8896652B55@gmail.com>
Message-ID: <20160727160307.GI11986@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> overusing from my side. Do you want me to send a v4 ?

Looking at it again, the sig_t is BSD specific one and may not be
defined on older glibc.

So the safest bet would be to define it as:

void (*k_sa_handler)(int);

-- 
Cyril Hrubis
chrubis@suse.cz
