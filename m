From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 18 Mar 2019 16:51:21 +0100
Subject: [LTP] [PATCH 4/5] mremap: Define _GNU_SOURCE to get
 MREMAP_MAYMOVE on MUSL
In-Reply-To: <20190318032330.3346-5-petr.vorel@gmail.com>
References: <20190318032330.3346-1-petr.vorel@gmail.com>
 <20190318032330.3346-5-petr.vorel@gmail.com>
Message-ID: <20190318155120.GD25922@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Unlike glibc and uclibc (which define MREMAP_MAYMOVE under __USE_MISC)
> MUSL requires _GNU_SOURCE.
> + Remove __USE_GNU

Acked, the __USE_GNU is hack that is not supposed to be used anyway.

-- 
Cyril Hrubis
chrubis@suse.cz
