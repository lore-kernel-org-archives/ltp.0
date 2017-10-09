From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 9 Oct 2017 17:59:19 +0200
Subject: [LTP] [RFC PATCH v2 7/7] m4,
 kernel/lib: Detect libnuma presence in kernel libs
In-Reply-To: <20171009110101.3329-8-pvorel@suse.cz>
References: <20171009110101.3329-1-pvorel@suse.cz>
 <20171009110101.3329-8-pvorel@suse.cz>
Message-ID: <20171009155919.GH25633@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +#if HAVE_LIBNUMA && HAVE_NUMA_H

I guess that the HAVE_LIBNUMA and HAVE_NUMA_H could be combined to
HAVE_LIBNUMA as well, if we find a reasonable solution.

-- 
Cyril Hrubis
chrubis@suse.cz
