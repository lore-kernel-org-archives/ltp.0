From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 13 Dec 2017 14:58:08 +0100
Subject: [LTP] [RFC PATCH 2/2] travis: Add 2x cross-compile ARM build
In-Reply-To: <20171212174544.12310-3-pvorel@suse.cz>
References: <20171212174544.12310-1-pvorel@suse.cz>
 <20171212174544.12310-3-pvorel@suse.cz>
Message-ID: <20171213135808.GE11493@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Builds replace native gcc-4.9 and gcc-6 builds to keep max 10 build
> jobs in travis.

So the cross compilers are gcc-4.x and gcc-6.x? I ask since we just ask
for arm cross compilers without a version in the script below.

I that is true I suppose that the cross compiler versions may change
without us noticing, which is not that big deal but it may be better to
select specific version instead if possible.

-- 
Cyril Hrubis
chrubis@suse.cz
